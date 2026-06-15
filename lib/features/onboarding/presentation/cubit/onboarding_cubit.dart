import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/language.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/level.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_languages.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_levels.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_model_install_status.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_models.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/install_model.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_model_install_status.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/model_install_status_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/onboarding_header_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final GetLanguages getLanguages;
  final GetLevels getLevels;
  final SaveUserData saveUserData;
  final GetModels getModels;
  final InstallModel installModel;
  final SaveModelInstallStatus saveModelInstallStatus;
  final GetModelInstallStatus getModelInstallStatus;

  OnboardingCubit({
    required this.saveUserData,
    required this.getLanguages,
    required this.getLevels,
    required this.getModels,
    required this.installModel,
    required this.saveModelInstallStatus,
    required this.getModelInstallStatus,
  }) : super(const OnboardingState()) {
    loadLanguages();
  }

  Future<void> submit() async {
    emit(state.copyWith(status: StateStatusEnum.saving));

    final UserData userData = UserData(
      selectedLanguage: state.selectedLanguage!,
      selectedLevel: state.selectedLevel!,
      userName: state.enteredName ?? "",
    );

    final result = await saveUserData.call(userData);

    result.fold(
      (l) => emit(state.copyWith(status: StateStatusEnum.error)),
      (r) => emit(state.copyWith(status: StateStatusEnum.saved)),
    );
  }

  bool installationStarted = false;
  void goNext() {
    final next = state.currentStep.next;

    if (next == OnboardingStepEnum.level) {
      loadLevels();
    }
    if (next == OnboardingStepEnum.name) {
      fetchModels();
    }

    if (next == OnboardingStepEnum.models && !installationStarted) {
      installationStarted = true;
      downloadModel();
    }

    if (next == null) {
      submit();
      return;
    }

    emit(state.copyWith(currentStep: next));
  }

  void goBack() {
    final previous = state.currentStep.back;
    if (previous == null) {
      return;
    }

    emit(
      state.copyWith(
        currentStep: previous,
        status: StateStatusEnum.loaded,
        clearError: true,
      ),
    );
  }

  Future<void> loadLanguages() async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    await Future.delayed(const Duration(seconds: 2));

    final Either<Failures, List<Language>> data = await getLanguages();

    data.fold(
      (l) {
        emit(state.copyWith(error: l, status: StateStatusEnum.error));
      },
      (r) {
        emit(state.copyWith(languagesList: r, status: StateStatusEnum.loaded));
      },
    );
  }

  void selectLanguage(Language? selectedLanguage) {
    bool isAlreadySelected =
        state.selectedLanguage?.langCode == selectedLanguage?.langCode;

    emit(
      state.copyWith(
        clearLanguageSelection: isAlreadySelected,
        selectedLanguage: selectedLanguage,
      ),
    );
  }

  void loadLevels() async {
    final Either<Failures, List<Level>> data = await getLevels();

    data.fold(
      (l) {
        emit(state.copyWith(error: l));
      },
      (list) {
        emit(state.copyWith(levelsList: list));
      },
    );
  }

  void selectLevel(Level? selectedLevel) {
    bool alreadySelected = state.selectedLevel == selectedLevel;

    emit(
      state.copyWith(
        selectedLevel: selectedLevel,
        clearLevelSelection: alreadySelected,
      ),
    );
  }

  void enterName(String? username) {
    emit(state.copyWith(enteredName: username?.trim()));
  }

  Future<void> fetchModels() async {
    emit(state.copyWith(status: StateStatusEnum.loading));

    final data = await getModels.call();

    data.fold(
      (l) => emit(state.copyWith(error: l, status: StateStatusEnum.error)),
      (r) {
        emit(state.copyWith(modelsDataa: r, status: StateStatusEnum.loaded));

        List<ModelInstallData> modelInstallData = [];

        //initial case - when nothing is loaded from local data
        if (state.modelInstallData?.isEmpty ?? true) {
          for (var x in r.models) {
            if (x.voices?.isNotEmpty ?? false) {
              for (var v in x.voices!) {
                modelInstallData.add(
                  ModelInstallData(
                    id: x.id,
                    installedPercentage: 0,
                    installedStatus: ModelInstallStatusEnum.Queued,
                    sizeInBytes: v.onnxSizeBytes,
                    name: v.displayName,
                    url: v.onnx,
                  ),
                );

                modelInstallData.add(
                  ModelInstallData(
                    id: x.id,
                    installedPercentage: 0,
                    installedStatus: ModelInstallStatusEnum.Queued,
                    sizeInBytes: v.configSizeBytes,
                    name: v.displayName,
                    url: v.config,
                  ),
                );
              }
            } else {
              modelInstallData.add(
                ModelInstallData(
                  id: x.id,
                  installedPercentage: 0,
                  sizeInBytes: x.sizeBytes,
                  url: x.url ?? "",
                  installedStatus: ModelInstallStatusEnum.Queued,
                  name: x.displayName,
                ),
              );
            }
          }

          emit(state.copyWith(modelInstallData: modelInstallData));
        }
      },
    );
  }

  Future<void> downloadModel() async {
    // flat list = one entry per file (what we download)
    final List<ModelInstallData> downloadableModels = List.from(
      state.modelInstallData!,
    );

    print("checkingggg ${downloadableModels}");

    // total bytes per model id  (Whisper = 1 file, tts = sum of all voice files)
    final Map<String, int> totalBytes = {};
    for (final m in downloadableModels) {
      totalBytes[m.id] = (totalBytes[m.id] ?? 0) + m.sizeInBytes;
    }

    // received bytes per model id (grows as files finish)
    final Map<String, int> receivedBytes = {
      for (final id in totalBytes.keys) id: 0,
    };

    // UI list = one card per id (what the screen shows)
    final List<ModelInstallData> uiModels = [];
    for (final m in downloadableModels) {
      if (uiModels.any((e) => e.id == m.id)) continue; // skip duplicates

      uiModels.add(
        m.copyWith(
          sizeInBytes: totalBytes[m.id]!,
          installedPercentage: m.installedPercentage,
          installedStatus: m.installedStatus,
        ),
      );
    }
    emit(state.copyWith(modelInstallData: [...uiModels]));

    int index = 0;
    int localIndex = 0;

    // download each file
    for (final model in downloadableModels) {
      if (model.installedStatus != ModelInstallStatusEnum.Downloaded) {
        bool isError = false;

        await for (final result in installModel.call(model.url)) {
          result.fold(
            (l) {
              isError = true;
              emit(state.copyWith(error: l, status: StateStatusEnum.error));
            },
            (r) {
              // bytes done for THIS model = finished files + current file's progress
              final received =
                  receivedBytes[model.id]! +
                  (model.sizeInBytes * (r.download / 100)).round();

              final percent = (received / totalBytes[model.id]! * 100)
                  .clamp(0, 100)
                  .round();

              index = uiModels.indexWhere((e) => e.id == model.id);
              localIndex = downloadableModels.indexWhere(
                (e) => e.url == model.url,
              );
              uiModels[index] = uiModels[index].copyWith(
                installedPercentage: percent,
                installedStatus: percent < 100
                    ? ModelInstallStatusEnum.Downloading
                    : ModelInstallStatusEnum.Downloaded,
              );

              emit(state.copyWith(modelInstallData: [...uiModels]));
            },
          );
        }

        if (isError) break; // stop BEFORE banking bytes

        // file finished -> add its bytes to that model's running total
        receivedBytes[model.id] = receivedBytes[model.id]! + model.sizeInBytes;

        //updating to keep in local
        //working fine for first model but how to handle for voices
        // i want if even one of the voices is not downloaded - then perc for all should be 0
        // i want if even all of the voices are downloaded - then perc for all should be 100

        ///trial with localIndex
        downloadableModels[localIndex] = downloadableModels[index].copyWith(
          installedPercentage: uiModels[index].installedPercentage >= 100
              ? 100
              : 0,
          installedStatus: uiModels[index].installedPercentage >= 100
              ? ModelInstallStatusEnum.Downloaded
              : ModelInstallStatusEnum.Queued,
        );

        print("is it updated $downloadableModels");

        final Either<Failures, bool> data = await saveModelInstallStatus.call(
          downloadableModels,
        );

        data.fold(
          (l) => emit(state.copyWith(status: StateStatusEnum.error, error: l)),
          (r) => emit(
            state.copyWith(status: StateStatusEnum.saved, clearError: true),
          ),
        );
      }
    }
    emit(state.copyWith(installedAllModels: true));
  }

  bool updateInstallStatus() {
    final Either<Failures, List<ModelInstallData>> data = getModelInstallStatus
        .call();

    return data.fold(
      (l) {
        emit(state.copyWith(error: l, status: StateStatusEnum.error));
        return false;
      },
      (r) {
        if (r.isEmpty) {
          return false;
        }

        print("what is in local $r");

        late bool allModelsInstalled = true;

        for (var x in r) {
          if (x.installedPercentage < 100) {
            allModelsInstalled = false;
          }
        }

        emit(state.copyWith(modelInstallData: r, installedAllModels: false));

        return allModelsInstalled;
      },
    );
  }
}
//en_US-lessac-medium.onnx
// url is repeating
// on restart - if all downloaded redirect to home