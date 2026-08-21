// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter/services.dart' as _i281;
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive_ce/hive.dart' as _i738;
import 'package:hive_ce/hive_ce.dart' as _i1055;
import 'package:hive_ce_flutter/adapters.dart' as _i170;
import 'package:hive_ce_flutter/hive_ce_flutter.dart' as _i965;
import 'package:injectable/injectable.dart' as _i526;
import 'package:offline_ai_tutor/core/dependency_injection/register_module.dart'
    as _i989;
import 'package:offline_ai_tutor/core/network/dio_client.dart' as _i536;
import 'package:offline_ai_tutor/core/network/downloader_client.dart' as _i998;
import 'package:offline_ai_tutor/core/storage/hive/hive_boxes_module.dart'
    as _i998;
import 'package:offline_ai_tutor/core/storage/hive/hive_initializer.dart'
    as _i314;
import 'package:offline_ai_tutor/features/home/data/data_model/home_data_model.dart'
    as _i1057;
import 'package:offline_ai_tutor/features/home/data/data_source/get_home_data_source.dart'
    as _i87;
import 'package:offline_ai_tutor/features/home/data/data_source/save_home_data_source.dart'
    as _i52;
import 'package:offline_ai_tutor/features/home/data/repositories/get_home_data_repo_impl.dart'
    as _i937;
import 'package:offline_ai_tutor/features/home/data/repositories/save_home_data_repo_impl.dart'
    as _i938;
import 'package:offline_ai_tutor/features/home/domain/repositories/get_home_data_repository.dart'
    as _i651;
import 'package:offline_ai_tutor/features/home/domain/repositories/save_home_data_repository.dart'
    as _i231;
import 'package:offline_ai_tutor/features/home/domain/use_cases/get_home_data.dart'
    as _i327;
import 'package:offline_ai_tutor/features/home/domain/use_cases/save_home_data.dart'
    as _i135;
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart'
    as _i701;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/get_model_install_status_source.dart'
    as _i1028;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/install_model_data_source.dart'
    as _i627;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/language_local_data_source.dart'
    as _i547;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/languages_parser.dart'
    as _i718;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/level_local_data_source.dart'
    as _i510;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/llm_model_data_source.dart'
    as _i132;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/save_models_install_status_source.dart'
    as _i713;
import 'package:offline_ai_tutor/features/onboarding/data/data_sources/save_user_data_source.dart'
    as _i463;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/get_model_install_status_repo_impl.dart'
    as _i862;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/install_model_repo_impl.dart'
    as _i325;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/language_repo_impl.dart'
    as _i590;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/level_repo_impl.dart'
    as _i936;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/llm_model_repo_impl.dart'
    as _i309;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/save_model_install_status_repository_impl.dart'
    as _i999;
import 'package:offline_ai_tutor/features/onboarding/data/repositories/save_user_data_repo_impl.dart'
    as _i974;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/get_model_install_status_repository.dart'
    as _i546;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/install_model_repository.dart'
    as _i550;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/language_repository.dart'
    as _i394;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/level_repository.dart'
    as _i984;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/llm_model_repository.dart'
    as _i333;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/save_model_install_status_repository.dart'
    as _i255;
import 'package:offline_ai_tutor/features/onboarding/domain/repositories/save_user_data_repository.dart'
    as _i649;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_languages.dart'
    as _i925;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_levels.dart'
    as _i1031;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_model_install_status.dart'
    as _i196;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/get_models.dart'
    as _i818;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/install_model.dart'
    as _i132;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_model_install_status.dart'
    as _i247;
import 'package:offline_ai_tutor/features/onboarding/domain/use_cases/save_user_data.dart'
    as _i1042;
import 'package:offline_ai_tutor/features/onboarding/presentation/cubit/onboarding_cubit.dart'
    as _i960;
import 'package:offline_ai_tutor/features/record_learn/data/data_source/audio_level_data_source.dart'
    as _i174;
import 'package:offline_ai_tutor/features/record_learn/data/data_source/load_model_data_source.dart'
    as _i34;
import 'package:offline_ai_tutor/features/record_learn/data/data_source/recording_data_source.dart'
    as _i409;
import 'package:offline_ai_tutor/features/record_learn/data/data_source/transcribe_audio_data_source.dart'
    as _i566;
import 'package:offline_ai_tutor/features/record_learn/data/platform/whisper_method_channel.dart'
    as _i880;
import 'package:offline_ai_tutor/features/record_learn/data/repositories/audio_level_repo_impl.dart'
    as _i837;
import 'package:offline_ai_tutor/features/record_learn/data/repositories/load_whisper_model_repo_impl.dart'
    as _i619;
import 'package:offline_ai_tutor/features/record_learn/data/repositories/recording_repo_impl.dart'
    as _i927;
import 'package:offline_ai_tutor/features/record_learn/data/repositories/transcribe_audio_repo_impl.dart'
    as _i989;
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/audio_level_repository.dart'
    as _i638;
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/load_whisper_model_repository.dart'
    as _i684;
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/recording_repository.dart'
    as _i834;
import 'package:offline_ai_tutor/features/record_learn/domain/repositories/transcribe_audio_repository.dart'
    as _i670;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/audio_level_stream.dart'
    as _i829;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/cancel_transcription.dart'
    as _i602;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/convert_audio.dart'
    as _i1000;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/load_whisper_model.dart'
    as _i949;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/start_audio_level_stream.dart'
    as _i402;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/start_recording.dart'
    as _i861;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/stop_audio_level_stream.dart'
    as _i983;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/stop_recording.dart'
    as _i211;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/transcribe_audio.dart'
    as _i504;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/transcription_audio_stream.dart'
    as _i982;
import 'package:offline_ai_tutor/features/record_learn/domain/use_cases/transcription_progress_stream.dart'
    as _i180;
import 'package:offline_ai_tutor/features/record_learn/presentation/cubit/recording_cubit.dart'
    as _i3;
import 'package:offline_ai_tutor/features/user/data/data_model/user_data_model.dart'
    as _i666;
import 'package:offline_ai_tutor/features/user/data/data_source/get_user_data_source.dart'
    as _i861;
import 'package:offline_ai_tutor/features/user/data/repositories/get_user_data_repo_impl.dart'
    as _i1059;
import 'package:offline_ai_tutor/features/user/domain/repositories/get_user_data_repository.dart'
    as _i907;
import 'package:offline_ai_tutor/features/user/domain/use_cases/get_user_data.dart'
    as _i76;
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_cubit.dart'
    as _i1036;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    final hiveBoxesModule = _$HiveBoxesModule();
    gh.lazySingleton<_i281.AssetBundle>(() => registerModule.assetBundle);
    gh.lazySingleton<_i536.DioClient>(() => _i536.DioClient());
    gh.lazySingleton<_i998.DownloaderClient>(() => _i998.DownloaderClient());
    gh.lazySingleton<_i718.LanguagesParser>(() => _i718.LanguagesParser());
    gh.lazySingleton<_i880.WhisperMethodChannel>(
      () => _i880.WhisperMethodChannel(),
    );
    gh.lazySingleton<_i314.HiveInitializer>(() => _i314.HiveInitializerImpl());
    gh.lazySingleton<_i566.TranscribeAudioDataSource>(
      () => _i566.TranscribeAudioDataSourceImpl(
        whisperMethodChannel: gh<_i880.WhisperMethodChannel>(),
      ),
    );
    gh.lazySingleton<_i34.LoadModelDataSource>(
      () => _i34.LoadModelDataSourceImpl(
        whisperMethodChannel: gh<_i880.WhisperMethodChannel>(),
      ),
    );
    gh.lazySingleton<_i738.Box<List<dynamic>>>(
      () => hiveBoxesModule.getModelsInstallBox,
      instanceName: 'modelsInstall',
    );
    gh.lazySingleton<_i510.LevelLocalDataSource>(
      () => const _i510.LevelLocalDataSourceImpl(),
    );
    gh.lazySingleton<_i738.Box<_i1057.HomeDataModel>>(
      () => hiveBoxesModule.homeDataBox,
      instanceName: 'homeData',
    );
    gh.lazySingleton<_i738.Box<_i666.UserDataModel>>(
      () => hiveBoxesModule.getUserPrefBox,
      instanceName: 'userPrefs',
    );
    gh.lazySingleton<_i174.AudioLevelDataSource>(
      () => _i174.AudioLevelDataSourceImpl(
        whisperMethodChannel: gh<_i880.WhisperMethodChannel>(),
      ),
    );
    gh.lazySingleton<_i409.RecordingDataSource>(
      () => _i409.RecordingDataSourceImpl(),
    );
    gh.lazySingleton<_i984.LevelRepository>(
      () => _i936.LevelRepoImpl(gh<_i510.LevelLocalDataSource>()),
    );
    gh.lazySingleton<_i713.SaveModelsInstallStatusSource>(
      () => _i713.SaveModelsInstallStatusSourceImpl(
        installStatusBox: gh<_i738.Box<List<dynamic>>>(
          instanceName: 'modelsInstall',
        ),
      ),
    );
    gh.lazySingleton<_i547.LanguageLocalDataSource>(
      () => _i547.LanguageLocalDataSourceImpl(
        rootBundle: gh<_i281.AssetBundle>(),
        languagesParser: gh<_i718.LanguagesParser>(),
      ),
    );
    gh.lazySingleton<_i627.InstallModelDataSource>(
      () => _i627.InstallModelDataSourceImpl(
        downloaderClient: gh<_i998.DownloaderClient>(),
      ),
    );
    gh.lazySingleton<_i861.GetUserDataSource>(
      () => _i861.GetUserDataSourceImpl(
        userPrefBox: gh<_i170.Box<_i666.UserDataModel>>(
          instanceName: 'userPrefs',
        ),
      ),
    );
    gh.lazySingleton<_i684.LoadWhisperModelRepository>(
      () => _i619.LoadWhisperModelRepoImpl(
        loadModelDataSource: gh<_i34.LoadModelDataSource>(),
      ),
    );
    gh.lazySingleton<_i87.GetHomeDataSource>(
      () => _i87.GetHomeDataSourceImpl(
        homeDataBox: gh<_i738.Box<_i1057.HomeDataModel>>(
          instanceName: 'homeData',
        ),
      ),
    );
    gh.lazySingleton<_i132.LLMModelDataSource>(
      () => _i132.LLMModelDataSourceImpl(dioClient: gh<_i536.DioClient>()),
    );
    gh.lazySingleton<_i52.SaveHomeDataSource>(
      () => _i52.SaveHomeDataSourceImpl(
        homeDataBox: gh<_i965.Box<_i1057.HomeDataModel>>(
          instanceName: 'homeData',
        ),
      ),
    );
    gh.lazySingleton<_i231.SaveHomeDataRepository>(
      () => _i938.SaveHomeDataRepoImpl(
        saveHomeDataSource: gh<_i52.SaveHomeDataSource>(),
      ),
    );
    gh.lazySingleton<_i550.InstallModelRepository>(
      () => _i325.InstallModelRepoImpl(
        installModelDataSource: gh<_i627.InstallModelDataSource>(),
      ),
    );
    gh.lazySingleton<_i135.SaveHomeData>(
      () => _i135.SaveHomeData(
        saveHomeDataRepository: gh<_i231.SaveHomeDataRepository>(),
      ),
    );
    gh.lazySingleton<_i333.LlmModelRepository>(
      () => _i309.LlmModelRepoImpl(
        llmMModelDataSource: gh<_i132.LLMModelDataSource>(),
      ),
    );
    gh.lazySingleton<_i670.TranscribeAudioRepository>(
      () => _i989.TranscribeAudioRepositoryImpl(
        transcribeAudioDataSource: gh<_i566.TranscribeAudioDataSource>(),
      ),
    );
    gh.lazySingleton<_i638.AudioLevelRepository>(
      () => _i837.AudioLevelRepoImpl(
        audioLevelDataSource: gh<_i174.AudioLevelDataSource>(),
      ),
    );
    gh.lazySingleton<_i394.LanguageRepository>(
      () => _i590.LanguageRepoImpl(
        languageDataSource: gh<_i547.LanguageLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i463.SaveUserDataLocallyDataSource>(
      () => _i463.SaveUserDataLocallyDataSourceImpl(
        gh<_i1055.Box<_i666.UserDataModel>>(instanceName: 'userPrefs'),
      ),
    );
    gh.lazySingleton<_i949.LoadWhisperModel>(
      () => _i949.LoadWhisperModel(
        loadWhisperModelRepository: gh<_i684.LoadWhisperModelRepository>(),
      ),
    );
    gh.lazySingleton<_i255.SaveModelInstallStatusrepository>(
      () => _i999.SaveModelInstallStatusRepositoryImpl(
        saveModelsInstallStatusSource:
            gh<_i713.SaveModelsInstallStatusSource>(),
      ),
    );
    gh.lazySingleton<_i834.RecordingRepository>(
      () => _i927.RecordingRepoImpl(
        recordingDataSource: gh<_i409.RecordingDataSource>(),
      ),
    );
    gh.lazySingleton<_i1031.GetLevels>(
      () => _i1031.GetLevels(gh<_i984.LevelRepository>()),
    );
    gh.lazySingleton<_i1028.GetModelInstallStatusSource>(
      () => _i1028.GetModelInstallStatusSourceImpl(
        installStatusBox: gh<_i170.Box<List<dynamic>>>(
          instanceName: 'modelsInstall',
        ),
        userPrefBox: gh<_i170.Box<_i666.UserDataModel>>(
          instanceName: 'userPrefs',
        ),
      ),
    );
    gh.lazySingleton<_i651.GetHomeDataRepository>(
      () => _i937.GetHomeDataRepoImpl(
        getHomeDataSource: gh<_i87.GetHomeDataSource>(),
      ),
    );
    gh.lazySingleton<_i861.StartRecording>(
      () => _i861.StartRecording(
        recordingRepository: gh<_i834.RecordingRepository>(),
      ),
    );
    gh.lazySingleton<_i211.StopRecording>(
      () => _i211.StopRecording(
        recordingRepository: gh<_i834.RecordingRepository>(),
      ),
    );
    gh.lazySingleton<_i925.GetLanguages>(
      () => _i925.GetLanguages(
        languageRepository: gh<_i394.LanguageRepository>(),
      ),
    );
    gh.lazySingleton<_i818.GetModels>(
      () => _i818.GetModels(llmModelRepository: gh<_i333.LlmModelRepository>()),
    );
    gh.lazySingleton<_i602.CancelTranscription>(
      () => _i602.CancelTranscription(
        transcribeAudioRepository: gh<_i670.TranscribeAudioRepository>(),
      ),
    );
    gh.lazySingleton<_i1000.ConvertAudio>(
      () => _i1000.ConvertAudio(
        transcribeAudioRepository: gh<_i670.TranscribeAudioRepository>(),
      ),
    );
    gh.lazySingleton<_i504.TranscribeAudio>(
      () => _i504.TranscribeAudio(
        transcribeAudioRepository: gh<_i670.TranscribeAudioRepository>(),
      ),
    );
    gh.lazySingleton<_i982.TranscriptionAudioStream>(
      () => _i982.TranscriptionAudioStream(
        transcribeAudioRepository: gh<_i670.TranscribeAudioRepository>(),
      ),
    );
    gh.factory<_i180.TranscriptionProgressStream>(
      () => _i180.TranscriptionProgressStream(
        transcribeAudioRepository: gh<_i670.TranscribeAudioRepository>(),
      ),
    );
    gh.lazySingleton<_i829.AudioLevelStream>(
      () => _i829.AudioLevelStream(
        audioLevelRepository: gh<_i638.AudioLevelRepository>(),
      ),
    );
    gh.lazySingleton<_i402.StartAudioLevelStream>(
      () => _i402.StartAudioLevelStream(
        audioLevelRepository: gh<_i638.AudioLevelRepository>(),
      ),
    );
    gh.lazySingleton<_i983.StopAudioLevelStream>(
      () => _i983.StopAudioLevelStream(
        audioLevelRepository: gh<_i638.AudioLevelRepository>(),
      ),
    );
    gh.lazySingleton<_i649.SaveUserDataRepository>(
      () => _i974.SaveUserDataRepoImpl(
        saveUserDataLocallyDataSource:
            gh<_i463.SaveUserDataLocallyDataSource>(),
      ),
    );
    gh.lazySingleton<_i1042.SaveUserData>(
      () => _i1042.SaveUserData(
        saveUserDataRepo: gh<_i649.SaveUserDataRepository>(),
      ),
    );
    gh.lazySingleton<_i907.GetUserDataRepository>(
      () => _i1059.GetUserDataRepoImpl(
        getUserDataSource: gh<_i861.GetUserDataSource>(),
      ),
    );
    gh.lazySingleton<_i247.SaveModelInstallStatus>(
      () => _i247.SaveModelInstallStatus(
        saveUserDataRepository: gh<_i255.SaveModelInstallStatusrepository>(),
      ),
    );
    gh.lazySingleton<_i132.InstallModel>(
      () => _i132.InstallModel(
        installModelRepository: gh<_i550.InstallModelRepository>(),
      ),
    );
    gh.lazySingleton<_i76.GetUserData>(
      () => _i76.GetUserData(
        getUserDataRepository: gh<_i907.GetUserDataRepository>(),
      ),
    );
    gh.lazySingleton<_i327.GetHomeData>(
      () => _i327.GetHomeData(
        getHomeDataRepository: gh<_i651.GetHomeDataRepository>(),
      ),
    );
    gh.factory<_i3.RecordingCubit>(
      () => _i3.RecordingCubit(
        loadWhisperModel: gh<_i949.LoadWhisperModel>(),
        startRecording: gh<_i861.StartRecording>(),
        stopRecording: gh<_i211.StopRecording>(),
        convertAudio: gh<_i1000.ConvertAudio>(),
        transcribeAudio: gh<_i504.TranscribeAudio>(),
        transcriptionProgressStream: gh<_i180.TranscriptionProgressStream>(),
        cancelTranscription: gh<_i602.CancelTranscription>(),
        transcriptionAudioStream: gh<_i982.TranscriptionAudioStream>(),
        startAudioLevelStream: gh<_i402.StartAudioLevelStream>(),
        stopAudioLevelStream: gh<_i983.StopAudioLevelStream>(),
        audioLevelStream: gh<_i829.AudioLevelStream>(),
      ),
    );
    gh.lazySingleton<_i546.GetModelInstallStatusRepository>(
      () => _i862.GetModelInstallStatusRepoImpl(
        getModelInstallStatusSource: gh<_i1028.GetModelInstallStatusSource>(),
      ),
    );
    gh.lazySingleton<_i196.GetModelInstallStatus>(
      () => _i196.GetModelInstallStatus(
        getModelInstallStatusRepository:
            gh<_i546.GetModelInstallStatusRepository>(),
      ),
    );
    gh.factory<_i701.HomeDataCubit>(
      () => _i701.HomeDataCubit(
        saveData: gh<_i135.SaveHomeData>(),
        getData: gh<_i327.GetHomeData>(),
      ),
    );
    gh.factory<_i1036.UserDataCubit>(
      () => _i1036.UserDataCubit(getUserData: gh<_i76.GetUserData>()),
    );
    gh.factory<_i960.OnboardingCubit>(
      () => _i960.OnboardingCubit(
        saveUserData: gh<_i1042.SaveUserData>(),
        getLanguages: gh<_i925.GetLanguages>(),
        getLevels: gh<_i1031.GetLevels>(),
        getModels: gh<_i818.GetModels>(),
        installModel: gh<_i132.InstallModel>(),
        saveModelInstallStatus: gh<_i247.SaveModelInstallStatus>(),
        getModelInstallStatus: gh<_i196.GetModelInstallStatus>(),
        getUserData: gh<_i76.GetUserData>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i989.RegisterModule {}

class _$HiveBoxesModule extends _i998.HiveBoxesModule {}
