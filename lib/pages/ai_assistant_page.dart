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

  final Map<String, String> _teamHubInfo = {};

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
      return 'TeamHub, proje sahiplerini işbirliği yapmak isteyen geliştiricilerle buluşturan bir uygulamadır. Proje sahipleri projelerini tanıtabilir ve uygun takım üyelerini bulabilir, geliştiriciler ise ilgi ve becerilerine göre projelere başvurabilir.';
    } else if (lowerQuestion.contains('özellikler') ||
        lowerQuestion.contains('ne sağlar')) {
      return 'TeamHub, proje yönetimi, kullanıcı yönetimi, mesajlaşma, takım üyelerini keşfetme ve proje başvuru gibi özelliklere sahiptir.';
    } else if (lowerQuestion.contains('hedef kitle') ||
        lowerQuestion.contains('kimler kullanır')) {
      return 'TeamHub, proje sahipleri, geliştiriciler, tasarımcılar ve işbirliği yapmak isteyen tüm profesyoneller için uygundur.';
    } else if (lowerQuestion.contains('nasıl çalışır')) {
      return 'TeamHub, kullanıcıların projelerini oluşturup yayınlamalarını ve diğer kullanıcıların bu projelere başvurmasını sağlar. Kullanıcılar, projelerdeki rollerine göre katkıda bulunabilir ve projelerin ilerlemesini takip edebilirler.';
    } else if (lowerQuestion.contains('avantajlar')) {
      return 'TeamHub, proje sahiplerinin uygun takım üyelerini hızlı bir şekilde bulmasını sağlar ve geliştiricilere çeşitli projelerde yer alma fırsatı sunar. Ayrıca, işbirliğini ve iletişimi kolaylaştırır.';
    } else if (lowerQuestion.contains('katılabilirim')) {
      return 'TeamHub\'da projelere katılmak için ilgi alanlarınıza ve becerilerinize uygun projeleri keşfedebilir ve bu projelere başvuru yapabilirsiniz.';
    } else {
      return 'TeamHub hakkında daha fazla bilgi verin.';
    }
  }
}
