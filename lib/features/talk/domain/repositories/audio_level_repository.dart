abstract interface class AudioLevelRepository {
  Stream<double> audioLevelStream();
  Future<void> startAudioLevelStream();
  Future<void> stopAudioLevelStream();
}
