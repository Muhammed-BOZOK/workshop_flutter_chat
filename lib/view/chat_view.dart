import 'package:flutter/material.dart';
import 'package:workshop_flutter_chat/widgets/message_item_widget.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final List<MessageItemWidget> dialogs = [];
  final ScrollController scrollController = ScrollController();
  TextEditingController messageController = TextEditingController();

  @override
  void initState() {
    dialogs.addAll(const [
      MessageItemWidget(
        senderType: MessageType.other,
        text: 'Hello',
      ),
      MessageItemWidget(
        senderType: MessageType.user,
        text: 'Hi, how are you an muhammeds',
      ),
      MessageItemWidget(
        senderType: MessageType.other,
        text: 'bye\nSee you later\nmuhammed',
      )
    ]);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          child: Column(children: [
            Expanded(
              child: ListView(
                controller: scrollController,
                shrinkWrap: true,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                children: [
                  for (var dialog in dialogs) ...{
                    dialog,
                  },
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: Colors.blueAccent,
                        border: OutlineInputBorder(
                            borderSide: BorderSide.none,
                            borderRadius: BorderRadius.circular(50)),
                      ),
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (messageController.text == '') {
                          setState(() {
                            dialogs.add(MessageItemWidget(
                              senderType: MessageType.user,
                              text: messageController.text,
                            ));
                          });
                        }
                        await Future.delayed(const Duration(microseconds: 100));
                        scrollController.animateTo(
                            scrollController.position.maxScrollExtent,
                            duration: const Duration(microseconds: 500),
                            curve: Curves.easeOut);

                        messageController.clear();
                      },
                      icon: const Icon(
                        Icons.send,
                        size: 30,
                      ))
                ],
              ),
            )
          ]),
        ),
      ),
    );
  }
}
