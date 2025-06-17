import 'package:flutter/material.dart';
import '../main.dart'; // Import AppScreen enum
import 'package:intl/intl.dart';

enum MessageSender { user, ai }

class ChatMessage {
  final String id;
  final String message;
  final MessageSender sender;
  final DateTime timestamp;

  ChatMessage({
    required this.id,
    required this.message,
    required this.sender,
    required this.timestamp,
  });
}

final List<ChatMessage> mockChatMessages = [
  ChatMessage(
    id: '1',
    message:
        'Hello! I am your personal AI financial assistant. How can I help you today?',
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
  ),
  ChatMessage(
    id: '2',
    message: 'Hi FinDiu AI, I want to know about my spending habits.',
    sender: MessageSender.user,
    timestamp: DateTime.now().subtract(const Duration(minutes: 3)),
  ),
  ChatMessage(
    id: '3',
    message:
        'Sure! I can help with that. Could you tell me more about what specific spending habits you\'d like to analyze?',
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(minutes: 2)),
  ),
  ChatMessage(
    id: '4',
    message:
        'I\'m having trouble understanding. Would you like me to connect you with a human support agent instead?',
    sender: MessageSender.ai,
    timestamp: DateTime.now().subtract(const Duration(seconds: 30)),
  ),
];

class AIChatScreen extends StatefulWidget {
  final Function(AppScreen) onNavigate;

  const AIChatScreen({super.key, required this.onNavigate});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _messages = [];

  @override
  void initState() {
    super.initState();
    _messages = mockChatMessages;
    WidgetsBinding.instance.addPostFrameCallback((_) => _scrollToBottom());
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void _handleSendMessage() {
    if (_messageController.text.trim().isNotEmpty) {
      final userMessage = ChatMessage(
        id: 'user-${DateTime.now().millisecondsSinceEpoch}',
        message: _messageController.text.trim(),
        sender: MessageSender.user,
        timestamp: DateTime.now(),
      );

      setState(() {
        _messages.add(userMessage);
      });

      _messageController.clear();
      _scrollToBottom();

      // Simulate AI response
      Future.delayed(const Duration(seconds: 1), () {
        final aiResponse = ChatMessage(
          id: 'ai-${DateTime.now().millisecondsSinceEpoch}',
          message:
              'I understand your campus financial question! Let me analyze your spending patterns and provide personalized advice. Based on your recent transactions, I can help you make better decisions about tuition, campus food, and student budgets.',
          sender: MessageSender.ai,
          timestamp: DateTime.now(),
        );
        setState(() {
          _messages.add(aiResponse);
        });
        _scrollToBottom();
      });
    }
  }

  final List<String> _quickQuestions = [
    "Can I afford Green Garden daily?",
    "How to save for next semester?",
    "Best campus meal plan?",
    "One Card budget tips",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          // Header
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [
                  Color(0xFF6B46C1), // from-primary-500
                  Color(0xFF805AD5), // to-accent-500
                ],
              ),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
            child: SafeArea(
              child: Row(
                children: <Widget>[
                  IconButton(
                    icon: const Icon(
                      Icons.arrow_back,
                      color: Colors.white,
                      size: 20,
                    ),
                    onPressed: () => widget.onNavigate(AppScreen.dashboard),
                  ),
                  const SizedBox(width: 16),
                  Row(
                    children: <Widget>[
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFFFFFFF,
                          ).withAlpha((0.2 * 255).round()), // bg-white/20
                          borderRadius: BorderRadius.circular(
                            16,
                          ), // rounded-2xl
                        ),
                        child: const Icon(
                          Icons.smart_toy,
                          size: 20,
                          color: Colors.white,
                        ), // Bot icon
                      ),
                      const SizedBox(width: 12), // space-x-3
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const <Widget>[
                          Text(
                            'Campus AI Assistant',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          Text(
                            'Your student financial advisor',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white70, // opacity-80
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          // Messages
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(
                horizontal: 24,
                vertical: 24,
              ), // px-6 py-6
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final message = _messages[index];
                final isUser = message.sender == MessageSender.user;
                return Align(
                  alignment:
                      isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                    ), // space-y-4
                    child: Row(
                      mainAxisAlignment:
                          isUser
                              ? MainAxisAlignment.end
                              : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        if (!isUser)
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFFF0F4F8), // bg-primary-100
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // rounded-2xl
                            ),
                            child: const Icon(
                              Icons.smart_toy,
                              size: 16,
                              color: Color(0xFF553C9A),
                            ), // Bot icon
                          ),
                        if (!isUser) const SizedBox(width: 12), // space-x-3
                        Flexible(
                          child: Container(
                            padding: const EdgeInsets.all(16), // p-4
                            decoration: BoxDecoration(
                              color:
                                  isUser
                                      ? const Color(
                                        0xFF6B46C1,
                                      ) // bg-primary-500
                                      : Colors.white, // bg-white
                              borderRadius: BorderRadius.only(
                                topLeft: const Radius.circular(24),
                                topRight: const Radius.circular(24),
                                bottomLeft: Radius.circular(
                                  isUser ? 24 : 8,
                                ), // rounded-bl-lg
                                bottomRight: Radius.circular(
                                  isUser ? 8 : 24,
                                ), // rounded-br-lg
                              ), // rounded-3xl
                              boxShadow: [
                                if (!isUser)
                                  BoxShadow(
                                    color: Colors.grey.withAlpha(
                                      (0.1 * 255).round(),
                                    ),
                                    spreadRadius: 1,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  ),
                              ],
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  message.message,
                                  style: TextStyle(
                                    fontSize: 14,
                                    color:
                                        isUser
                                            ? Colors.white
                                            : const Color(
                                              0xFF1A202C,
                                            ), // text-gray-900
                                    height: 1.5, // leading-relaxed
                                  ),
                                ),
                                const SizedBox(height: 8), // mt-2
                                Text(
                                  DateFormat(
                                    'hh:mm a',
                                  ).format(message.timestamp),
                                  style: TextStyle(
                                    fontSize: 10, // text-xs
                                    color:
                                        isUser
                                            ? const Color(
                                              0xFFE2E8F0,
                                            ) // text-primary-100
                                            : const Color(
                                              0xFF718096,
                                            ), // text-gray-500
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        if (isUser) const SizedBox(width: 12), // space-x-3
                        if (isUser)
                          Container(
                            width: 32,
                            height: 32,
                            decoration: BoxDecoration(
                              color: const Color(0xFF6B46C1), // bg-primary-500
                              borderRadius: BorderRadius.circular(
                                16,
                              ), // rounded-2xl
                            ),
                            child: const Icon(
                              Icons.person,
                              size: 16,
                              color: Colors.white,
                            ), // User icon
                          ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          // Quick Questions
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 16,
            ), // px-6 pb-4
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children:
                    _quickQuestions.map((question) {
                      return Padding(
                        padding: const EdgeInsets.only(right: 8.0), // space-x-2
                        child: ActionChip(
                          label: Text(question),
                          onPressed: () {
                            setState(() {
                              _messageController.text = question;
                            });
                          },
                          backgroundColor: Colors.white, // bg-white
                          labelStyle: const TextStyle(
                            color: Color(0xFF4A5568),
                            fontSize: 14,
                          ), // text-gray-700
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              16,
                            ), // rounded-2xl
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ), // px-4 py-2
                        ),
                      );
                    }).toList(),
              ),
            ),
          ),

          // Message Input
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 24,
              vertical: 24,
            ), // px-6 pb-6
            child: Container(
              padding: const EdgeInsets.all(16), // p-4
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24), // rounded-3xl
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withAlpha((0.1 * 255).round()),
                    spreadRadius: 1,
                    blurRadius: 5,
                    offset: const Offset(0, 3), // shadow-sm
                  ),
                ],
              ),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      onSubmitted: (value) => _handleSendMessage(),
                      decoration: const InputDecoration(
                        hintText:
                            'Ask me about campus finances, tuition, or budgeting...',
                        hintStyle: TextStyle(
                          color: Color(0xFF718096),
                        ), // placeholder-gray-500
                        border: InputBorder.none,
                        isDense: true,
                        contentPadding: EdgeInsets.zero,
                      ),
                      style: const TextStyle(
                        color: Color(0xFF1A202C),
                      ), // text-gray-900
                    ),
                  ),
                  const SizedBox(width: 12), // space-x-3
                  IconButton(
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 20,
                    ), // Send icon
                    onPressed: _handleSendMessage,
                    style: IconButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF6B46C1,
                      ), // bg-primary-500
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ), // rounded-2xl
                      padding: const EdgeInsets.all(10),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
