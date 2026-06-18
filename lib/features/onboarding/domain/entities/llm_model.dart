import 'package:equatable/equatable.dart';

class LLMModelEntity extends Equatable {
  final List<Models> models;

  const LLMModelEntity({required this.models});

  @override
  List<Object?> get props => [models];
}

class Models extends Equatable {
  final String id;
  final String type;
  final String displayName;
  final String subtitleDisplay;
  final String? url;
  final int sizeBytes;
  final List<VoiceModel>? voices;

  const Models({
    required this.id,
    required this.displayName,
    required this.subtitleDisplay,
    required this.sizeBytes,
    required this.type,
    required this.url,
    required this.voices,
  });

  @override
  List<Object?> get props => [
    id,
    displayName,
    subtitleDisplay,
    sizeBytes,
    type,
    url,
    voices,
  ];
}

class VoiceModel extends Equatable {
  final String id;
  final String onnx;
  final String config;
  final String displayName;
  final int onnxSizeBytes;

  final int configSizeBytes;

  const VoiceModel({
    required this.config,
    required this.displayName,
    required this.id,
    required this.onnx,
    required this.onnxSizeBytes,
    required this.configSizeBytes,
  });

  @override
  List<Object?> get props => [
    config,
    displayName,
    id,
    onnx,
    onnxSizeBytes,
    configSizeBytes,
  ];
}
