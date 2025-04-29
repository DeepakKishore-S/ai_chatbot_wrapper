import 'package:flutter/material.dart';
import 'dart:async';
import 'message_model.dart';

class ChatBotView extends StatefulWidget {
  final Future<String> Function(List<Message>) sendMessage;

  const ChatBotView({super.key, required this.sendMessage});

  @override
  State<ChatBotView> createState() => _ChatBotViewState();
}

class _ChatBotViewState extends State<ChatBotView> {
  final List<Message> _messages = [];
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  late Timer _typingTimer;
  int _dotsCount = 0;

  final ScrollController _scrollController = ScrollController();

  Future<void> _handleSend(String text) async {
    if (text.isEmpty) return;

    setState(() {
      _messages.add(
        Message(timestamp: DateTime.now(), text: text, isUser: true),
      );
      _isLoading = true;
      _dotsCount = 0; // Reset dots when new message is sent
    });

    try {
      final reply = await widget.sendMessage(_messages);
      setState(() {
        _messages.add(
          Message(timestamp: DateTime.now(), text: reply, isUser: false),
        );
      });
      _scrollToBottom();
    } catch (e) {
      setState(() {
        _messages.add(
          Message(
            timestamp: DateTime.now(),
            text: 'Error: ${e.toString()}',
            isUser: false,
          ),
        );
      });
    } finally {
      setState(() => _isLoading = false);
      _controller.clear();
      _scrollToBottom();
    }
  }

  void _scrollToBottom() {
    _scrollController.animateTo(
      _scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  String _formatTimestamp(DateTime timestamp) {
    return '${timestamp.hour}:${timestamp.minute < 10 ? '0' : ''}${timestamp.minute}';
  }

  @override
  void initState() {
    super.initState();
    _startTypingAnimation();
  }

  void _startTypingAnimation() {
    _typingTimer = Timer.periodic(const Duration(milliseconds: 500), (_) {
      if (_isLoading) {
        setState(() {
          _dotsCount = (_dotsCount % 3) + 1; // Cycle through 1 to 3 dots
        });
      }
    });
  }

  @override
  void dispose() {
    _typingTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            controller: _scrollController,
            padding: const EdgeInsets.all(8),
            itemCount: _messages.length,
            itemBuilder: (context, index) {
              final msg = _messages[index];
              return Align(
                alignment:
                    msg.isUser ? Alignment.centerRight : Alignment.centerLeft,
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 4),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color:
                        msg.isUser ? Colors.blueAccent : Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: msg.isUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        msg.text,
                        style: TextStyle(
                          color: msg.isUser ? Colors.white : Colors.black,
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        _formatTimestamp(msg.timestamp ?? DateTime.now()),
                        style: TextStyle(
                          fontSize: 10,
                          color: msg.isUser ? Colors.white70 : Colors.black54,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        if (_isLoading)
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: _buildTypingIndicator(),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade100,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 5,
                        offset: Offset(0, 2),
                      ),
                    ],
                  ),
                  child: TextField(
                    controller: _controller,
                    onSubmitted: _handleSend,
                    decoration: InputDecoration(
                      hintText: 'Type your message...',
                      hintStyle: TextStyle(color: Colors.grey.shade600),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send, color: Colors.blue),
                onPressed: () => _handleSend(_controller.text),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Typing indicator with a creative dot animation
  Widget _buildTypingIndicator() {
    String dots = '.' * _dotsCount; // Create a string with 1-3 dots

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          'Typing$dots',
          style: TextStyle(
            fontSize: 18,
            color: Colors.blueAccent,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
