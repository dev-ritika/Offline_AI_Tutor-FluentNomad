import 'package:equatable/equatable.dart';

class HomeDataState extends Equatable {
  final int streakDays;

  const HomeDataState({required this.streakDays});

  HomeDataState copyWith({int? streakDays}) {
    return HomeDataState(streakDays: streakDays ?? this.streakDays);
  }

  @override
  List<Object?> get props => [];
}
