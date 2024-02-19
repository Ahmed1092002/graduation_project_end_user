import 'dart:convert';
import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:graduation_project_end_user/Views/chat_bot_view/data/ChatBotModel.dart';
import 'package:meta/meta.dart';

part 'chat_bot_state.dart';

class ChatBotCubit extends Cubit<ChatBotState> {
  ChatBotCubit() : super(ChatBotInitial());
  static ChatBotCubit get(context) => BlocProvider.of(context);
  List<Map<String, dynamic>> chatHistory = [];



  getAns({required String text}) async {
    ChatBotModel model ;
    emit(ChatBotLoading());
    var headers = {
      'Content-Type': 'application/json'
    };
    var data = json.encode({
      "contents": [
        {
          "role": "user",
          "parts": [
            {
              "text": "${text}",
            }
          ]
        }
      ]
    });
    var dio = Dio();
    var response = await dio.request(
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=AIzaSyClklLFmcj7-2eA91BKO_jraYGqSXFp4IY',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );

    if (response.statusCode == 200) {


      model= ChatBotModel.fromJson(response.data);

      print (response.data);

      print(model.candidates![0].content!.parts![0].text);
      chatHistory.add({
        "time": DateTime.now(),
        "message": model.candidates![0].content!.parts![0].text,
        "isSender": false,
      });
      emit(ChatBotSuccess());


    }
    else {
      print(response.statusMessage);

      emit(ChatBotError());
    }
  }

}
