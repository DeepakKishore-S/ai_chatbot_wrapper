class Message {
  final String text;
  final bool isUser;
  final DateTime? timestamp;

  Message({this.timestamp, required this.text, required this.isUser});
}