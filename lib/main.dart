import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_ai_tutor/config/routes/routes_config.dart';
import 'package:offline_ai_tutor/config/theme/theme_config.dart';
import 'package:offline_ai_tutor/core/dependency_injection/dependency_injection.dart';
import 'package:offline_ai_tutor/core/storage/hive/hive_initializer.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_cubit.dart';
import 'package:offline_ai_tutor/features/splash/presentation/screen/splash_screen.dart';
import 'package:offline_ai_tutor/features/user/presentation/cubit/user_data_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  configureDependency();

  await sl<HiveInitializer>().init();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          lazy: false,
          create: (context) => sl<UserDataCubit>()..getUserLocalData(),
        ),
        BlocProvider(
          create: (context) => sl<HomeDataCubit>()
            ..getHomeData()
            ..saveHomeData(),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      routes: RoutesConfig.getRoutes,
      debugShowCheckedModeBanner: false,
      title: 'Fluent Nomad',
      theme: ThemeConfig.appThemeData(),
      home: const Splash(),
      //  home: OnboardingScreen(),
    );
  }
}
