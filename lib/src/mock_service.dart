import 'message_model.dart';

class MockAIService {
  Future<String> sendMessage(List<Message> messages) async {
    await Future.delayed(const Duration(seconds: 1));
    return "This is a mock response to: \"${messages.last.text}\"";
  }
}
