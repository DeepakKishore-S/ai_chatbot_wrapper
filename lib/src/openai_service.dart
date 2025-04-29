import 'dart:convert';
import 'package:http/http.dart' as http;
import 'message_model.dart';

class OpenAIService {
  final String apiKey;
  final String model;

  OpenAIService({required this.apiKey, this.model = 'gpt-3.5-turbo'});

  Future<String> sendMessage(List<Message> messages) async {
    final uri = Uri.parse('https://api.openai.com/v1/chat/completions');

    final body = jsonEncode({
      'model': model,
      'messages': messages
          .map(
            (msg) => {
              'role': msg.isUser ? 'user' : 'assistant',
              'content': msg.text,
            },
          )
          .toList(),
      'temperature': 0.7,
    });

    final response = await http.post(
      uri,
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: body,
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Failed to connect to OpenAI API');
    }
  }
}
