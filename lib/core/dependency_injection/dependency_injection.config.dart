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
import 'package:offline_ai_tutor/features/home/data/data_source/save_home_data_source.dart'
    as _i52;
import 'package:offline_ai_tutor/features/home/data/repositories/save_home_data_repo_impl.dart'
    as _i938;
import 'package:offline_ai_tutor/features/home/domain/repositories/save_home_data_repository.dart'
    as _i231;
import 'package:offline_ai_tutor/features/home/domain/use_cases/save_home_data.dart'
    as _i135;
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart'
    as _i701;
import 'package:offline_ai_tutor/features/onboarding/data/data_model/user_data_model.dart'
    as _i702;
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
    gh.lazySingleton<_i314.HiveInitializer>(() => _i314.HiveInitializerImpl());
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
    gh.lazySingleton<_i738.Box<_i702.UserDataModel>>(
      () => hiveBoxesModule.getUserPrefBox,
      instanceName: 'userPrefs',
    );
    gh.lazySingleton<_i463.SaveUserDataLocallyDataSource>(
      () => _i463.SaveUserDataLocallyDataSourceImpl(
        gh<_i1055.Box<_i702.UserDataModel>>(instanceName: 'userPrefs'),
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
    gh.lazySingleton<_i132.LLMModelDataSource>(
      () => _i132.LLMModelDataSourceImpl(dioClient: gh<_i536.DioClient>()),
    );
    gh.lazySingleton<_i1028.GetModelInstallStatusSource>(
      () => _i1028.GetModelInstallStatusSourceImpl(
        installStatusBox: gh<_i170.Box<List<dynamic>>>(
          instanceName: 'modelsInstall',
        ),
        userPrefBox: gh<_i170.Box<_i702.UserDataModel>>(
          instanceName: 'userPrefs',
        ),
      ),
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
    gh.lazySingleton<_i394.LanguageRepository>(
      () => _i590.LanguageRepoImpl(
        languageDataSource: gh<_i547.LanguageLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i255.SaveModelInstallStatusrepository>(
      () => _i999.SaveModelInstallStatusRepositoryImpl(
        saveModelsInstallStatusSource:
            gh<_i713.SaveModelsInstallStatusSource>(),
      ),
    );
    gh.lazySingleton<_i1031.GetLevels>(
      () => _i1031.GetLevels(gh<_i984.LevelRepository>()),
    );
    gh.lazySingleton<_i546.GetModelInstallStatusRepository>(
      () => _i862.GetModelInstallStatusRepoImpl(
        getModelInstallStatusSource: gh<_i1028.GetModelInstallStatusSource>(),
      ),
    );
    gh.factory<_i701.HomeDataCubit>(
      () => _i701.HomeDataCubit(saveData: gh<_i135.SaveHomeData>()),
    );
    gh.lazySingleton<_i925.GetLanguages>(
      () => _i925.GetLanguages(
        languageRepository: gh<_i394.LanguageRepository>(),
      ),
    );
    gh.lazySingleton<_i196.GetModelInstallStatus>(
      () => _i196.GetModelInstallStatus(
        getModelInstallStatusRepository:
            gh<_i546.GetModelInstallStatusRepository>(),
      ),
    );
    gh.lazySingleton<_i818.GetModels>(
      () => _i818.GetModels(llmModelRepository: gh<_i333.LlmModelRepository>()),
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
    gh.factory<_i960.OnboardingCubit>(
      () => _i960.OnboardingCubit(
        saveUserData: gh<_i1042.SaveUserData>(),
        getLanguages: gh<_i925.GetLanguages>(),
        getLevels: gh<_i1031.GetLevels>(),
        getModels: gh<_i818.GetModels>(),
        installModel: gh<_i132.InstallModel>(),
        saveModelInstallStatus: gh<_i247.SaveModelInstallStatus>(),
        getModelInstallStatus: gh<_i196.GetModelInstallStatus>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i989.RegisterModule {}

class _$HiveBoxesModule extends _i998.HiveBoxesModule {}
