import 'package:flutter_test/flutter_test.dart';
import 'package:ai_chatbot_wrapper/src/mock_service.dart';
import 'package:ai_chatbot_wrapper/src/message_model.dart';

void main() {
  group('MockAIService', () {
    test('sendMessage returns a mock response', () async {
      final service = MockAIService();

      final response = await service.sendMessage([
        Message(text: "Hello", isUser: true),
      ]);

      expect(response, "This is a mock response to: \"Hello\"");
    });
  });
}
