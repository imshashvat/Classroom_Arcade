import 'package:google_generative_ai/google_generative_ai.dart';

class GameGeneratorService {
  static const String _apiKey = String.fromEnvironment('GEMINI_API_KEY', defaultValue: '');
  final GenerativeModel model = GenerativeModel(
    model: 'gemini-1.5-flash',
    apiKey: _apiKey,
  );

  Future<Map<String, dynamic>> generateGame(
      String subject, String mode, String level) async {
    final prompt =
        'Grade 3 $subject: Confusion. Class: 40 kids. Mode: $mode. $level. Format: 🎮 Title ⚔️ Teams: 4 Indian names 📋 Round 1: desc ⏱️ 12 mins 🏆 Prize. Rules: Physical movement every 90 sec. No materials.';
    try {
      final response = await model.generateContent([Content.text(prompt)]);
      return _parseResponse(response.text ?? 'Fallback game');
    } catch (e) {
      return {
        'title': 'PLANT WARRIOR BATTLE 🎮',
        'teams': ['🌱 Root', '🌿 Stem', '🍃 Leaf', '🌸 Flower'],
        'instructions': ['Photosynthesis race!', 'Parts match!', 'Grow fast!'],
        'duration': '12 mins',
        'prize': 'Plant Masters 🏆'
      };
    }
  }

  Map<String, dynamic> _parseResponse(String raw) {
    // Simple parsing logic (expand for full AI response)
    final title = raw.contains('🎮')
        ? raw.split('🎮')[1].split('⚔️')[0].trim()
        : 'Generated Game';
    final teams = raw.contains('⚔️')
        ? raw.split('⚔️')[1].split('📋')[0].trim().split(', ')
        : ['Team 1', 'Team 2'];
    final round1 = raw.contains('📋')
        ? raw.split('📋')[1].split('⏱️')[0].trim()
        : 'Round 1 desc';
    final duration = raw.contains('⏱️')
        ? raw.split('⏱️')[1].split('🏆')[0].trim()
        : '12 mins';
    final prize = raw.contains('🏆') ? raw.split('🏆')[1].trim() : 'Prize';
    return {
      'title': title,
      'teams': teams,
      'instructions': [round1],
      'duration': duration,
      'prize': prize
    };
  }
}
