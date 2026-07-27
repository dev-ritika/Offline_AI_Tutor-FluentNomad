abstract interface class TranscribeAudioRepository {
  Future<String?> convertAudio(String audioPath);

  Future<String> transcribeAudio(String audioPath);
}
