import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project_end_user/Views/chat_bot_view/blocs/chat_bot_cubit.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';

class ChatBotPage extends StatefulWidget {
  const ChatBotPage({Key? key}) : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  final TextEditingController _chatController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<Map<String, dynamic>> _chatHistory = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chat Ai", style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF0B79B3)),),
        iconTheme: const IconThemeData(color: Color(0xFF0B79B3)),
      ),
      body: BlocProvider(
  create: (context) => ChatBotCubit(),
  child: BlocConsumer<ChatBotCubit, ChatBotState>(
  listener: (context, state) {
    // TODO: implement listener
  },
  builder: (context, state) {
    var cubit = ChatBotCubit.get(context);
    return Column(
        children: [
          Expanded(
            child: Container(
              //get max height
              height: MediaQuery.of(context).size.height - 160,
              child: ListView.builder(
                itemCount:cubit.chatHistory.length,
                shrinkWrap: false,

                controller: _scrollController,
                physics: const BouncingScrollPhysics(),
                itemBuilder: (context, index){
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: cubit.chatHistory[index]["isSender"]?AlignmentDirectional.centerEnd:AlignmentDirectional.centerStart,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:cubit.chatHistory[index]["isSender"]?BorderRadius.only(
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                            bottomLeft: Radius.circular(23),
                          ):BorderRadius.only(
                            topLeft: Radius.circular(23),
                            topRight: Radius.circular(23),
                            bottomRight: Radius.circular(23),
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 2,
                              blurRadius: 5,
                              offset: const Offset(0, 3),
                            ),
                          ],

                          color: cubit.chatHistory[index]["isSender"]?Colors.blue:Colors.white,
                        ),
                        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                        child: Text(cubit.chatHistory[index]["message"], style: TextStyle(fontSize: 10, color: cubit.chatHistory[index]["isSender"]?Colors.white:Colors.black)),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            height: 60.h,
            width: double.infinity,
            decoration: BoxDecoration(
           boxShadow: [
             BoxShadow(
               color: Colors.grey.withOpacity(0.5),
               spreadRadius: 1,
               blurRadius: 1,
               blurStyle: BlurStyle.outer,
               offset: const Offset(0, 3),
             ),
           ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: TextFormField(
                      style: TextStyle(fontSize: 10,color: Color(0xFF0B79B3)),
                      cursorColor: Color(0xFF0B79B3),
                      decoration: const InputDecoration(
                        hintText: "Type a message",
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20.0)),
                          borderSide: BorderSide(color: Colors.white),
                        ),
                      ),


                      controller: _chatController,
                    ),
                  ),
                ),

                MaterialButton(
                  onPressed: (){
                    setState(() {
                      if(_chatController.text.isNotEmpty){
                        print (_chatController.text);
                        cubit.getAns(text: _chatController.text.toString().trim());

                        cubit.chatHistory.add({
                          "time": DateTime.now(),
                          "message": _chatController.text,
                          "isSender": true,
                        });

                       _chatController.clear();

                      }
                    });

                    _scrollController.jumpTo(
                      _scrollController.position.maxScrollExtent,
                    );

                  },
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
minWidth: 50.w,
                  height: 50.h,
                  child: Container(
                      alignment: Alignment.center,
                      child: const Icon(Icons.send, color: Color(0xFF0B79B3),)
                  ),
                )
              ],
            ),
          )
        ],
      );
  },
),
),
    );
  }



}


