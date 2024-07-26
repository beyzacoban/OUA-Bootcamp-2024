import 'package:flutter/material.dart';
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
    final prompt = _generatePrompt(question);
    final content = [Content.text(prompt)];

    try {
      final response = await _model.generateContent(content);
      return response.text ?? 'Yanıt alınamadı.';
    } catch (e) {
      return 'Hata: ${e.toString()}';
    }
  }

  String _generatePrompt(String question) {
    final lowerQuestion = question.toLowerCase();

    if (lowerQuestion.contains('açıklama') ||
        lowerQuestion.contains('ne yapar')) {
      return 'TeamHub nedir?';
    } else if (lowerQuestion.contains('özellikler') ||
        lowerQuestion.contains('ne sağlar')) {
      return 'TeamHub hangi özelliklere sahiptir?';
    } else if (lowerQuestion.contains('hedef kitle') ||
        lowerQuestion.contains('kimler kullanır')) {
      return 'TeamHub kimler için uygundur?';
    } else {
      return 'TeamHub hakkında daha fazla bilgi ver.';
    }
  }
}
