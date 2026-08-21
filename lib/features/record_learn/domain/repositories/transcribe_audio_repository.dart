abstract interface class TranscribeAudioRepository {
  Future<String?> convertAudio(String audioPath);

  Future<String> transcribeAudio(String audioPath);

  Stream<int> transcriptionProgressStream();

  Future<void> cancelTranscription();

  Stream<String> get transcriptionAudioStream;
}
