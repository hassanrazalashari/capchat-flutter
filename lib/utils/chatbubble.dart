import 'package:chatapp/utils/gradient.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isSent;
  final DateTime timestamp;

  const ChatBubble({
    super.key,
    required this.message,
    required this.isSent,
    required this.timestamp,
  });

  @override
  Widget build(BuildContext context) {
    final time = DateFormat.jm().format(timestamp);
    final screenWidth = MediaQuery.of(context).size.width;

    return Align(
      alignment: isSent ? Alignment.centerRight : Alignment.centerLeft,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: screenWidth * 0.7, // Limit width to 70% of screen
        ),
        child: Container(
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 10),
          decoration: BoxDecoration(
            gradient: isSent
                ? GradientHelper.sentbubble()
                : GradientHelper.recievedbubble(),
            borderRadius: BorderRadius.only(
              topLeft: const Radius.circular(10),
              topRight: const Radius.circular(10),
              bottomLeft: isSent ? const Radius.circular(10) : Radius.zero,
              bottomRight: isSent ? Radius.zero : const Radius.circular(10),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                message,
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 13,
                    fontFamily: "Poppins SemiBold"),
              ),
              const SizedBox(height: 2),
              Text(
                time,
                style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 10,
                    fontFamily: "Poppins SemiBold"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
