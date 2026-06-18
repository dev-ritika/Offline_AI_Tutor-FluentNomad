import 'dart:convert';

import 'package:offline_ai_tutor/features/onboarding/domain/entities/llm_model.dart';

LlmModel llmModelFromJson(String str) => LlmModel.fromJson(json.decode(str));

String llmModelToJson(LlmModel data) => json.encode(data.toJson());

class LlmModel {
  final String version;
  final List<Model> models;

  LlmModel({required this.version, required this.models});

  factory LlmModel.fromJson(Map<String, dynamic> json) => LlmModel(
    version: json["version"],
    models: List<Model>.from(json["models"].map((x) => Model.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "version": version,
    "models": List<dynamic>.from(models.map((x) => x.toJson())),
  };

  LLMModelEntity toDomain() {
    return LLMModelEntity(models: models.map((x) => x.toDomain()).toList());
  }
}

class Model {
  final String id;
  final String type;
  final String displayName;
  final String subtitleDisplay;
  final int sizeBytes;
  final String? url;
  final List<Voices>? voices;

  Model({
    required this.id,
    required this.type,
    required this.subtitleDisplay,
    required this.displayName,
    required this.sizeBytes,
    required this.url,
    required this.voices,
  });

  factory Model.fromJson(Map<String, dynamic> json) => Model(
    id: json["id"],
    type: json["type"],
    subtitleDisplay: json['subtitleDisplay'],
    displayName: json["displayName"],
    sizeBytes: json["sizeBytes"],
    url: json["url"],
    voices: json["items"] == null
        ? []
        : List<Voices>.from(json["items"]!.map((x) => Voices.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "displayName": displayName,
    "subtitleDisplay": subtitleDisplay,
    "sizeBytes": sizeBytes,
    "url": url,
    "items": voices == null
        ? []
        : List<dynamic>.from(voices!.map((x) => x.toJson())),
  };

  Models toDomain() {
    return Models(
      id: id,
      displayName: displayName,
      sizeBytes: sizeBytes,
      type: type,
      url: url,
      subtitleDisplay: subtitleDisplay,
      voices: voices?.map((x) => x.toDomain()).toList(),
    );
  }
}

class Voices {
  final String id;
  final String displayName;
  final int onnxSizeBytes;
  final String onnx;
  final int configSizeBytes;
  final String config;

  Voices({
    required this.id,
    required this.displayName,
    required this.onnx,
    required this.config,
    required this.onnxSizeBytes,
    required this.configSizeBytes,
  });

  factory Voices.fromJson(Map<String, dynamic> json) => Voices(
    id: json["id"],
    displayName: json["displayName"],
    onnx: json["onnx"],
    config: json["config"],
    onnxSizeBytes: json["onnxSizeBytes"],
    configSizeBytes: json["configSizeBytes"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "displayName": displayName,
    "onnx": onnx,
    "config": config,
    "configSizeBytes": configSizeBytes,
    "onnxSizeBytes": onnxSizeBytes,
  };

  VoiceModel toDomain() {
    return VoiceModel(
      config: config,
      displayName: displayName,
      id: id,
      onnx: onnx,
      onnxSizeBytes: onnxSizeBytes,
      configSizeBytes: configSizeBytes,
    );
  }
}
