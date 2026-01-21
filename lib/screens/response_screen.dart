import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:teacher_sos_app/providers/scenario_provider.dart';
import 'package:teacher_sos_app/services/hive_service.dart';
import 'package:teacher_sos_app/services/tts_service.dart';
import 'package:teacher_sos_app/services/speech_service.dart';

class ResponseScreen extends ConsumerStatefulWidget {
  @override
  _ResponseScreenState createState() => _ResponseScreenState();
}

class _ResponseScreenState extends ConsumerState<ResponseScreen> {
  final TtsService _ttsService = TtsService();
  final SpeechService _speechService = SpeechService();
  String _feedbackNote = '';

  @override
  void initState() {
    super.initState();
    HiveService.preloadResponses();
  }

  @override
  Widget build(BuildContext context) {
    final scenario = ref.watch(selectedScenarioProvider);
    final response = HiveService.getResponse(scenario);

    return Scaffold(
      appBar: AppBar(title: Text('Coaching Tip')),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Text(response['text']!, style: TextStyle(fontSize: 18)),
            SizedBox(height: 20),
            ElevatedButton(onPressed: () => _ttsService.speak(response['text']!), child: Text('Play Audio')),
            SizedBox(height: 20),
            Text('Feedback:'),
            Row(
              children: [
                IconButton(icon: Icon(Icons.thumb_up), onPressed: () => _logFeedback(true)),
                IconButton(icon: Icon(Icons.thumb_down), onPressed: () => _logFeedback(false)),
                IconButton(icon: Icon(Icons.mic), onPressed: () => _recordVoiceNote()),
              ],
            ),
            Text(_feedbackNote),
          ],
        ),
      ),
    );
  }

  void _logFeedback(bool positive) {
    HiveService.logFeedback(positive, 'fallback');
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Feedback logged!')));
  }

  void _recordVoiceNote() async {
    _feedbackNote = await _speechService.listen();
    setState(() {});
  }
}