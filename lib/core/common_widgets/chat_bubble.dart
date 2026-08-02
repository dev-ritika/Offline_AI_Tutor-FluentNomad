import 'package:flutter/material.dart';
import 'package:offline_ai_tutor/core/utils/constants/color_consts.dart';

class ChatBubble extends StatelessWidget {
  final String? childText;
  final bool isUser;
  const ChatBubble({super.key, required this.childText, this.isUser = true});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: isUser
          ? CrossAxisAlignment.end
          : CrossAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.only(
            left: isUser ? 40 : 0,
            right: isUser ? 0 : 40,
            top: 20,
            bottom: 5,
          ),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isUser
                ? ColorConsts.buttonSecondaryColor
                : ColorConsts.whiteColor10,
            borderRadius: BorderRadius.only(
              bottomLeft: isUser
                  ? const Radius.circular(20)
                  : const Radius.circular(0),
              bottomRight: isUser
                  ? const Radius.circular(0)
                  : const Radius.circular(20),
              topLeft: const Radius.circular(20),
              topRight: const Radius.circular(20),
            ),
            border: Border.all(
              color: isUser
                  ? ColorConsts.buttonSecondaryStrokeColor
                  : ColorConsts.whiteColor35,
              width: 1.5,
            ),
          ),
          child: Text(
            childText?.trim() ?? "",
            style: Theme.of(context).textTheme.labelLarge,
          ),
        ),

        Text(isUser ? "you" : "Tutor"),
      ],
    );
  }
}
