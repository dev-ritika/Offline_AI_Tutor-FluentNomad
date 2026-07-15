import 'package:equatable/equatable.dart';

sealed class Failures extends Equatable {
  final String message;

  const Failures(this.message);

  @override
  List<Object?> get props => [message];
}

class CacheFailure extends Failures {
  const CacheFailure(super.message);
}

class AssetFailure extends Failures {
  const AssetFailure(super.message);
}

class NetworkFailure extends Failures {
  const NetworkFailure(super.message);
}

class AudioFailure extends Failures {
  const AudioFailure(super.message);
}
