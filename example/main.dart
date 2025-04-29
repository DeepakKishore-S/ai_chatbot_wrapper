import 'package:flutter/material.dart';
import 'package:ai_chatbot_wrapper/ai_chatbot_wrapper.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: Text("ChatBot Example")),
        body: ChatBotView(
          sendMessage: OpenAIService(apiKey: "your-api-key").sendMessage,
        ),
      ),
    );
  }
}
