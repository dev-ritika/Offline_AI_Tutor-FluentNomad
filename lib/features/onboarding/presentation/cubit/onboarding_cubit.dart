import 'dart:async';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';
import 'package:offline_ai_tutor/core/utils/enums/state_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/language.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/level.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_enum.dart';
import 'package:offline_ai_tutor/features/user/domain/entities/user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_languages.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_levels.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_model_install_status.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_models.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/install_model.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_model_install_status.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_user_data.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_state.dart';
import 'package:offline_ai_tutor/features/onboarding/presentation/utils/enums/onboarding_header_enum.dart';
import 'package:offline_ai_tutor/features/onboarding/domain/entities/model_install_data.dart';
import 'package:offline_ai_tutor/features/user/domain/use_cases/get_user_data.dart';

@injectable
class OnboardingCubit extends Cubit<OnboardingState> {
  final GetLanguages getLanguages;
  final GetLevels getLevels;
  final SaveUserData saveUserData;
  final GetModels getModels;
  final InstallModel installModel;
  final SaveModelInstallStatus saveModelInstallStatus;
  final GetModelInstallStatus getModelInstallStatus;
  final GetUserData getUserData;

  OnboardingCubit({
    required this.saveUserData,
    required this.getLanguages,
    required this.getLevels,
    required this.getModels,
    required this.installModel,
    required this.saveModelInstallStatus,
    required this.getModelInstallStatus,
    required this.getUserData,
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

    if (next == OnboardingStepEnum.level &&
        (state.levelsList == null || (state.levelsList?.isEmpty ?? true))) {
      loadLevels();
    }
    if (next == OnboardingStepEnum.name && (state.modelsData == null)) {
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
                    installedStatus: ModelInstallStatus.Queued,
                    sizeInBytes: v.onnxSizeBytes,
                    name: v.displayName,
                    url: v.onnx,
                  ),
                );

                modelInstallData.add(
                  ModelInstallData(
                    id: x.id,
                    installedPercentage: 0,
                    installedStatus: ModelInstallStatus.Queued,
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
                  installedStatus: ModelInstallStatus.Queued,
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

  void getUserSavedData() {
    final Either<Failures, UserData?> data = getUserData();

    data.fold(
      (l) {
        emit(state.copyWith(error: l, status: StateStatusEnum.error));
      },
      (r) {
        print("userr dataa $r");
        if (r != null) {
          emit(
            state.copyWith(
              enteredName: r.userName,
              selectedLanguage: r.selectedLanguage,
              selectedLevel: r.selectedLevel,
            ),
          );
        }
      },
    );
  }

  Future<void> downloadModel() async {
    // flat list = one entry per file (what we download)
    final List<ModelInstallData> downloadableModels = List.from(
      state.modelInstallData!,
    );

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
    bool isError = false;
    // download each file
    for (final model in downloadableModels) {
      if (model.installedStatus != ModelInstallStatus.Downloaded) {
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
                    ? ModelInstallStatus.Downloading
                    : ModelInstallStatus.Downloaded,
              );

              emit(state.copyWith(modelInstallData: [...uiModels]));
            },
          );
        }

        if (isError) break; // stop BEFORE banking bytes

        // file finished -> add its bytes to that model's running total
        receivedBytes[model.id] = receivedBytes[model.id]! + model.sizeInBytes;

        //updating to keep in local
        ///trial with localIndex
        downloadableModels[localIndex] = downloadableModels[localIndex]
            .copyWith(
              installedPercentage: uiModels[index].installedPercentage >= 100
                  ? 100
                  : 0,
              installedStatus: uiModels[index].installedPercentage >= 100
                  ? ModelInstallStatus.Downloaded
                  : ModelInstallStatus.Queued,
              // id: downloadableModels[localIndex].id,
            );

        final Either<Failures, bool> data = await saveModelInstallStatus.call(
          downloadableModels,
        );

        data.fold(
          (l) => emit(state.copyWith(status: StateStatusEnum.error, error: l)),
          (r) => emit(state.copyWith(clearError: true)),
        );
      }
    }
    if (!isError) {
      emit(state.copyWith(installedAllModels: true));
    }
  }

  bool updateOnboardingStatus() {
    final Either<
      Failures,
      ({List<ModelInstallData> modelData, UserData? userData})
    >
    data = getModelInstallStatus.call();

    return data.fold(
      (l) {
        emit(state.copyWith(error: l, status: StateStatusEnum.error));
        return false;
      },
      (r) {
        if (r.modelData.isEmpty) {
          return false;
        }

        Map<String, dynamic> installationStatus = {};

        late bool onboardingCompleted = true;

        late bool modelsInstalled = false;

        for (var x in r.modelData) {
          installationStatus[x.id] = x.installedPercentage;
        }

        installationStatus.forEach((key, value) {
          if (value < 100) {
            onboardingCompleted = false;
            modelsInstalled = false;
          } else {
            modelsInstalled = true;
          }
        });

        //TODO

        // if (r.userData == null) {
        //   onboardingCompleted = false;
        // } else {
        //   emit(
        //     state.copyWith(
        //       enteredName: r.userData?.userName,
        //       selectedLanguage: r.userData?.selectedLanguage,
        //     ),
        //   );
        // }

        if (state.enteredName == null) {
          onboardingCompleted = false;
        }

        List<ModelInstallData>? finalModelList;

        if (modelsInstalled) {
          finalModelList = r.modelData
              .map(
                (x) => x.copyWith(
                  installedPercentage: 100,
                  installedStatus: ModelInstallStatus.Downloaded,
                ),
              )
              .toList();
        }

        emit(
          state.copyWith(
            modelInstallData: finalModelList ?? r.modelData,
            installedAllModels: false,
          ),
        );

        return onboardingCompleted;
      },
    );
  }
}
