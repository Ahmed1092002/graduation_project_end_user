import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/chat_bot_view/View/chat_bot_page.dart';
import 'package:graduation_project_end_user/utils/navigator.dart';

import '../../../generated/l10n.dart';
import '../../../utils/colors_.dart';
import '../../chat_bot_view/widget/gradient_text.dart';

class ChatBotCard extends StatelessWidget {
   ChatBotCard({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        navigateToScreen(context, ChatBotPage());
      },

      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: 50.w,

            decoration: const BoxDecoration(
          color:Color(0xFF64C2F5),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(

                  children: [
                    // TextButton(
                    //     onPressed: () {
                    //       navigateToScreen(context, ChatBotPage());
                    //     },
                    //     style: ButtonStyle(
                    //       backgroundColor:
                    //       MaterialStateProperty.all<Color>(Colors.white),
                    //       foregroundColor:
                    //       MaterialStateProperty.all<Color>(Colors.black),
                    //     ),
                    //     child: const Padding(
                    //       padding: EdgeInsets.symmetric(horizontal: 16.0),
                    //       child: GradientText(
                    //         "Ask Now",
                    //         style: TextStyle(
                    //           fontSize: 16.0,
                    //           fontWeight: FontWeight.bold,
                    //         ),
                    //         gradient: LinearGradient(colors: [
                    //           Color(0xFFF69170),
                    //           Color(0xFF7D96E6),
                    //         ]),
                    //       ),
                    //     )),
                    Image(image: AssetImage('assets/image/robot.png'),width: 50.w,height: 50.h,),
                    Text(S.of(context).Chat_Ai,
                        style: const TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.white)),


                  ],
                )
              ],
            )),
      ),
    );
  }
}
