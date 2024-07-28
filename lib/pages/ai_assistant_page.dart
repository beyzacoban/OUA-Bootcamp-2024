import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:google_generative_ai/google_generative_ai.dart';

const apiKey = '';

class AiAssistantPage extends StatefulWidget {
  const AiAssistantPage({Key? key}) : super(key: key);

  @override
  _AiAssistantPageState createState() => _AiAssistantPageState();
}

class _AiAssistantPageState extends State<AiAssistantPage> {
  final TextEditingController _questionController = TextEditingController();
  final List<Map<String, String>> _conversation = [];
  final GenerativeModel _model = GenerativeModel(
    model: 'gemini-1.5-flash-latest',
    apiKey: apiKey,
  );

  Map<String, String> _teamHubInfo = {};

  @override
  void initState() {
    super.initState();
    _loadTeamHubInfo();
  }

  Future<void> _loadTeamHubInfo() async {
    try {
      final String response = await rootBundle
          .loadString('lib/assets/images/data/teamhub_info.json');
      final data = json.decode(response);
      final List questions = data['sorular'];
      for (var item in questions) {
        _teamHubInfo[item['soru'].toLowerCase()] = item['cevap'];
      }
      print('Loaded teamHubInfo: $_teamHubInfo'); // Debug
    } catch (e) {
      print('Error loading teamHubInfo: $e'); // Debug
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AI Assistant'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _conversation.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_conversation[index]['user']!),
                  subtitle: Text(_conversation[index]['ai']!),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _questionController,
                    decoration: const InputDecoration(
                      hintText: 'Ask me anything...',
                    ),
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    final userQuestion = _questionController.text;
                    final aiResponse = await _getAIResponse(userQuestion);
                    setState(() {
                      _conversation
                          .add({'user': userQuestion, 'ai': aiResponse});
                      _questionController.clear();
                    });
                  },
                  icon: const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<String> _getAIResponse(String question) async {
    final lowerQuestion = question.toLowerCase();

    if (_teamHubInfo.containsKey(lowerQuestion)) {
      return _teamHubInfo[lowerQuestion]!;
    } else {
      final prompt = _generatePrompt(question);
      final content = [Content.text(prompt)];
      try {
        final response = await _model.generateContent(content);
        return response.text ?? 'Yanıt alınamadı.';
      } catch (e) {
        return 'Hata: ${e.toString()}';
      }
    }
  }

  String _generatePrompt(String question) {
    final lowerQuestion = question.toLowerCase();

    if (lowerQuestion.contains('teamhub nedir')) {
      return 'TeamHub nedir?';
    } else if (lowerQuestion.contains('özellikler') ||
        lowerQuestion.contains('ne sağlar')) {
      return 'TeamHub hangi özelliklere sahiptir?';
    } else if (lowerQuestion.contains('hedef kitle') ||
        lowerQuestion.contains('kimler kullanır')) {
      return 'TeamHub kimler için uygundur?';
    } else if (lowerQuestion.contains('nasıl çalışır')) {
      return 'TeamHub nasıl çalışır?';
    } else if (lowerQuestion.contains('avantajlar')) {
      return 'TeamHub avantajları nelerdir?';
    } else if (lowerQuestion.contains('katılabilirim')) {
      return 'TeamHub ile projelere nasıl katılabilirim?';
    } else {
      return 'TeamHub hakkında daha fazla bilgi ver.';
    }
  }
}
