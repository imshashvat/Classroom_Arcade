import 'package:speech_to_text/speech_to_text.dart' as stt;

class SpeechService {
  final stt.SpeechToText _speech = stt.SpeechToText();

  Future<String> listen() async {
    String result = '';
    if (await _speech.initialize()) {
      _speech.listen(onResult: (res) {
        result = res.recognizedWords;
      });
      await Future.delayed(Duration(seconds: 3));
      _speech.stop();
    }
    return result;
  }
}