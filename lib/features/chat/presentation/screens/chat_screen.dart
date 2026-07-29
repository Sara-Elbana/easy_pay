import 'package:easy_localization/easy_localization.dart';
import 'package:easy_pay_app/core/widgets/custom_app_bar.dart';
import 'package:easy_pay_app/core/utils/responsive_helper.dart';
import 'package:easy_pay_app/core/widgets/custom_error_widget.dart';
import 'package:easy_pay_app/features/chat/data/models/message_model_local.dart';
import 'package:easy_pay_app/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:easy_pay_app/features/chat/presentation/cubit/chat_state.dart';
import 'package:easy_pay_app/features/chat/presentation/widgets/chat_input_field.dart';
import 'package:easy_pay_app/features/chat/presentation/widgets/received_message_widget.dart';
import 'package:easy_pay_app/features/chat/presentation/widgets/sent_message_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _controller = TextEditingController();
  final List<MessageModelLocal> _messages = [];

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _sendMessage(BuildContext context) {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final int? notificationId =
    ModalRoute.of(context)?.settings.arguments as int?;

    context.read<ChatCubit>().sendMessage(
      text,
      notificationId: notificationId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: "bank_of_america".tr(),
      ),
      body: BlocConsumer<ChatCubit, ChatState>(
        listener: (context, state) {
          if (state is ChatMessageSentSuccess) {
            setState(() {
              _messages.add(MessageModelLocal(
                  text: _controller.text.trim(), isSent: true));
              _controller.clear();
            });
          }
        },
        builder: (context, state) {
          return Column(
            children: [
              Expanded(
                child: state is ChatError
                    ? SingleChildScrollView(child: CustomErrorWidget(message: state.message))
                    : _messages.isEmpty
                    ? const SizedBox.shrink()
                    : ListView.builder(
                  padding: EdgeInsets.symmetric(
                    horizontal: context.scaleWidth(24),
                    vertical: context.scaleHeight(16),
                  ),
                  itemCount: _messages.length,
                  itemBuilder: (context, index) {
                    final msg = _messages[index];
                    return msg.isSent
                        ? SentMessageWidget(text: msg.text)
                        : ReceivedMessageWidget(texts: [msg.text]);
                  },
                ),
              ),
              ChatInputField(
                controller: _controller,
                isLoading: state is ChatLoading,
                onSendPressed: () => _sendMessage(context),
                onChanged: (value){
                  context.read<ChatCubit>().clearError();
                },
              ),
            ],
          );
        },
      ),
    );
  }
}