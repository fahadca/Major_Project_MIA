import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechToTextService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  void startListening(Function(String) onCommandRecognized) async {
    bool available = await _speech.initialize();
    if (available) {
      _speech.listen(onResult: (result) => onCommandRecognized(result.recognizedWords));
    }
  }

  void stopListening() {
    _speech.stop();
  }
}