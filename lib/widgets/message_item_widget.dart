import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

enum MessageType {
  other,
  user,
}

class MessageItemWidget extends StatelessWidget {
  const MessageItemWidget({
    super.key,
    required this.senderType,
    required this.text,
  });

  final MessageType senderType;
  final String text;

  @override
  Widget build(BuildContext context) {
    const radius = 30.0;
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: senderType == MessageType.other
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            if (senderType == MessageType.other)
              const CircleAvatar(
                radius: radius,
                backgroundColor: Colors.blue,
              ),
            const SizedBox(
              width: 10,
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.7,
              margin: const EdgeInsets.symmetric(vertical: 8),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius:
                    const BorderRadius.vertical(top: Radius.circular(radius))
                        .copyWith(
                            bottomLeft: Radius.circular(
                                senderType == MessageType.user ? radius : 0),
                            bottomRight: Radius.circular(
                                senderType == MessageType.other ? radius : 0)),
              ),
              child: Text(
                text,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: senderType == MessageType.other
              ? MainAxisAlignment.start
              : MainAxisAlignment.end,
          children: [
            if (senderType == MessageType.other)
              const SizedBox(
                width: (radius * 2 + 10),
              ),
            Text(
              formattedDateTime(DateTime.now()),
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        )
      ],
    );
  }

  String formattedDateTime(DateTime dateTime) {
    String formattedDate = DateFormat('dd/MM/yyyy').format(dateTime);
    String formattedTime = DateFormat('HH:mm').format(dateTime);

    return '$formattedDate $formattedTime';
  }
}
