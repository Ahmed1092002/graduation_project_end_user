import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../generated/l10n.dart';
import '../../../utils/navigator.dart';
import '../../chat_bot_view/View/chat_bot_page.dart';
import '../../chat_groub_View/ChatScreen.dart' as chat_screen;

class ChatGroubCard extends StatelessWidget {
  const ChatGroubCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToScreen(context, chat_screen.ChatScreen());
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50.w,
          decoration: const BoxDecoration(
            color: Color(0xFF0B79B3),
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.asset(
                    'assets/image/community.png',
                    width: 50.w,
                    height: 50.h,
                  ),
                  Text(
                    S.of(context).Society,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
