import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:offline_ai_tutor/features/home/domain/entities/home_data.dart';
import 'package:offline_ai_tutor/features/home/domain/use_cases/save_home_data.dart';
import 'package:offline_ai_tutor/features/home/presentation/cubit/home_data_state.dart';

@injectable
class HomeDataCubit extends Cubit<HomeDataState> {
  final SaveHomeData saveData;
  HomeDataCubit({required this.saveData})
    : super(const HomeDataState(streakDays: 0)) {
    saveHomeData();
  }

  Future<void> saveHomeData() async {
    await saveData(HomeData(streakDays: 1));
  }
}
