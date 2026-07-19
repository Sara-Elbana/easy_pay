import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/core.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:flutter/material.dart';

class Message {
  final String text;
  final bool isSent;
  Message({required this.text, required this.isSent});
}

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<Message> _messages = [];

  void _sendMessage() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    setState(() {
      _messages.add(Message(text: text, isSent: true));
      _controller.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "bank_of_america".tr(),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: context.scaleWidth(24),
                vertical: context.scaleHeight(16),
              ),
              itemCount: _messages.length,
              itemBuilder: (context, index) {
                final msg = _messages[index];
                return msg.isSent
                    ? _SentMessage(text: msg.text)
                    : _ReceivedMessage(texts: [msg.text]);
              },
            ),
          ),
          // Input field with active send button
          Container(
            padding: EdgeInsets.symmetric(
              horizontal: context.scaleWidth(24),
              vertical: context.scaleHeight(12),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: context.scaleWidth(8),
                      vertical: context.scaleHeight(4),
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.gray,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(context.scaleWidth(20)),
                    ),
                    child: TextField(
                      controller: _controller,
                      decoration: InputDecoration(
                        hintText: 'type_something'.tr(),
                        hintStyle: TextStyle(
                          fontFamily: 'Poppins',
                          fontSize: context.scaleWidth(14),
                          fontWeight: FontWeight.w500,
                          color: const Color(0xFF989898),
                        ),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: context.scaleWidth(12)),
                // Active send button
                GestureDetector(
                  onTap: _sendMessage,
                  child: Container(
                    width: context.scaleWidth(44),
                    height: context.scaleHeight(44),
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius: BorderRadius.circular(context.scaleWidth(22)),
                    ),
                    child: Icon(
                      Icons.arrow_forward_outlined,
                      color: Colors.white,
                      size: context.scaleWidth(22),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Helper widgets for chat bubbles
class _ReceivedMessage extends StatelessWidget {
  final List<String> texts;
  const _ReceivedMessage({required this.texts});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.scaleWidth(250)),
        padding: EdgeInsets.all(context.scaleWidth(12)),
        decoration: BoxDecoration(
          color: const Color(0xFFF2F1F9),
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: texts
              .map((t) => Text(
                    t,
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: context.scaleWidth(14),
                      fontWeight: FontWeight.w500,
                      color: const Color(0xFF343434),
                      height: 1.5,
                    ),
                  ))
              .toList(),
        ),
      ),
    );
  }
}

class _SentMessage extends StatelessWidget {
  final String text;
  const _SentMessage({required this.text});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        constraints: BoxConstraints(maxWidth: context.scaleWidth(200)),
        padding: EdgeInsets.all(context.scaleWidth(12)),
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(context.scaleWidth(15)),
        ),
        child: Text(
          text,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: context.scaleWidth(14),
            fontWeight: FontWeight.w500,
            color: Colors.white,
            height: 1.5,
          ),
        ),
      ),
    );
  }
}
