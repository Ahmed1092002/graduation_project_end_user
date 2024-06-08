import 'dart:async';
import 'dart:io';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Views/chat_groub_View/image_screan.dart';
import 'package:graduation_project_end_user/Views/chat_groub_View/pdf_page.dart';
import 'package:graduation_project_end_user/Views/chat_groub_View/video_file.dart';
import 'package:graduation_project_end_user/main.dart';
import 'package:hive/hive.dart';
import 'package:intl/intl.dart';
import 'package:ionicons/ionicons.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../../utils/cashe_helper.dart';
import '../../utils/navigator.dart';
import 'ChatViewCubit/chat_groub_cubit.dart';
import 'model/chat_model.dart';

class ChatScreen extends StatefulWidget {


  ChatScreen({Key? key}) : super(key: key);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final _textController = TextEditingController();
  String? status;

  Widget _buildMassage({ChatModel? message, String? time}) {
    return Align(
      alignment: AlignmentDirectional.centerStart,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.blueAccent.withOpacity(0.4),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomEnd: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: status == 'Loading....'
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.grey, size: 20)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [


                  if (message!.message.contains('https://') ||
                      message.message.contains('http://'))
                    locaion(location: message.message)
                  else
                    Text(
                      message!.message,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                  if (message.images != null)
                    Wrap(
                      children: [
                        for (var image in message.images!)
                          if (image.toString().contains('.pdf'))
                            Container(
                              height: 80,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: fileIcon(url: image, context: context),
                            )
                          else if (image.toString().contains('.jpg') ||
                              image.toString().contains('.png'))
                            Image(image: image, context: context)
                          else if (image.toString().contains('.mp4'))
                              videoIcon  (image: image, context: context)
                      ],
                    ),
                  Text(
                    time!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }

  Widget _buildMyMassage({ChatModel? message, String? time}) {
    return Align(
      alignment: AlignmentDirectional.centerEnd,
      child: Container(
        decoration: BoxDecoration(
            color: Colors.grey.withOpacity(0.4),
            borderRadius: BorderRadiusDirectional.only(
              topEnd: Radius.circular(10),
              topStart: Radius.circular(10),
              bottomStart: Radius.circular(10),
            )),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
        child: status == 'Loading....'
            ? LoadingAnimationWidget.staggeredDotsWave(
                color: Colors.blueAccent, size: 20)
            : Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    message!.senderName,
                    textAlign: TextAlign.start,
                    style: TextStyle(color: Colors.black.withOpacity(0.5)),
                  ),
                  if (message!.message.contains('https://') ||
                      message.message.contains('http://'))
                    locaion(location: message.message)
                  else
                    Text(
                      message!.message,
                      textAlign: TextAlign.start,
                      style: TextStyle(color: Colors.black),
                    ),
                  if (message.images != null)
                    Wrap(
                      children: [
                        for (var image in message.images!)
                          if (image.toString().contains('.pdf'))
                            Container(
                              height: 80,
                              margin: EdgeInsets.all(8.0),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: fileIcon(url: image, context: context),
                            )
                          else if (image.toString().contains('.jpg') ||
                              image.toString().contains('.png'))
                            Image(image: image, context: context)
                          else if (image.toString().contains('.mp4'))
                              videoIcon  (image: image, context: context)
                      ],
                    ),
                  Text(
                    time!,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
      ),
    );
  }
  var box = Hive.box(boxName);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatGroubCubit(),
      child: Builder(builder: (context) {
        ChatGroubCubit.get(context).getChatGroubMessages();


        return BlocConsumer<ChatGroubCubit, ChatGroubState>(
          listener: (context, state) {
            if (state is SendMessageSuccessState) {
              ChatGroubCubit.get(context)
                  .getChatGroubMessages();
            }
            if (state is SendMessageLoadingState
                ||
                state is uploadProfileImageLoadingState) {
             CircularProgressIndicator();
            }
            if (state is GetMessagesLoadingState
                || state is SendMessageLoadingState ||
                state is uploadProfileImageLoadingState) {
              status = 'Loading...';
            }
          },
          builder: (context, state) {
            var cubit = ChatGroubCubit.get(context);
            return Scaffold(
              appBar: AppBar(
                title: Row(
                  children: [

                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      S.of(context).groub_chat,
                      style: TextStyle(
                          color: Colors.blueAccent,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                    Spacer(),
                  ],
                ),
                backgroundColor: Colors.white,
                elevation: 0,

              ),
              body: ConditionalBuilder(
                condition: ChatGroubCubit.get(context).Masseges.length >= 0,
                builder: (context) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          child: ListView.separated(
                              reverse: true,
                              itemBuilder: (context, index) {
                                var message =
                                ChatGroubCubit.get(context).Masseges[index];
                                DateTime dateTime =
                                    DateTime.parse(message.time);
                                String formattedDate =
                                    DateFormat('yyyy-MM-dd').format(dateTime);
                                String formattedTime =
                                    DateFormat('h:mm a').format(dateTime);

                                if (message.senderId ==   CashHelper.getData(key: 'refugeeId')) {
                                  return _buildMassage(
                                      message: message, time: formattedTime);
                                } else {
                                  return _buildMyMassage(
                                      message: message, time: formattedTime);
                                }
                              },
                              separatorBuilder: (context, index) => SizedBox(
                                    height: 8.0,
                                  ),
                              itemCount:
                              ChatGroubCubit.get(context).Masseges.length),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                      child: Container(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 8.0),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      border: Border.all(color: Colors.blueAccent),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          child: Column(
                                            children: [
                                              if (cubit.images.isNotEmpty)
                                                Container(

                                                  decoration: BoxDecoration(
                                                    color: Colors.white,
                                                    borderRadius:
                                                        BorderRadius.circular(10),
                                                  ),
                                                  child: Wrap(
                                                    children: [
                                                      for (var xfile
                                                      in cubit.images)
                                                        file(file: xfile),

                                                    ],
                                                  ),
                                                ),
                                              if (state is SendMessageLoadingState
                                                  ||
                                                  state is uploadProfileImageLoadingState)
                                               LoadingAnimationWidget.staggeredDotsWave(
                                                  color: Colors.blueAccent,
                                                  size: 20),
                                              Container(
                                                width: 200,
                                                decoration: BoxDecoration(
                                                  color: Colors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                ),
                                                clipBehavior:
                                                    Clip.antiAliasWithSaveLayer,
                                                child: TextFormFieldChat(textController: _textController),
                                              ),

                                            ],
                                          ),
                                        ),
                                        IconButton(
                                          style: ButtonStyle(
                                            padding: MaterialStateProperty.all(
                                                EdgeInsets.all(0)),
                                          ),
                                          icon: Icon(
                                            Ionicons.attach_outline,
                                            color: Colors.blueAccent,
                                          ),
                                          onPressed: () {
                                            // cubit.pickMultipleMediaImage();
                                            showModalBottomSheet(

                                                context: context,
                                                builder: (context) {
                                                  return chosenFile(
                                                      onGallary: () {
                                                    cubit
                                                        .pickMultipleMediaImage();
                                                    Navigator.pop(context);
                                                  }, onFile: () {
                                                    cubit.pickFilePdf();
                                                    Navigator.pop(context);
                                                  }, );
                                                });
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Ionicons.camera_outline,
                                            color: Colors.blueAccent,
                                          ),
                                          onPressed: () {
                                            cubit.pickCameraImage();
                                          },
                                        ),
                                      ],
                                    ),
                                  )),
                                  SizedBox(
                                    width: 8.0,
                                  ),
                                  MaterialButton(
                                      color: Colors.blueAccent,
                                      height: 40,
                                      minWidth: 40,
                                      animationDuration: Duration(seconds: 1),
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Icon(
                                        Ionicons.send,
                                        color: Colors.white,
                                      ),
                                      onPressed: () async {
                                        print('send');

                                        if (_textController.text.isEmpty &&
                                            cubit.images.isEmpty) {
                                          return;
                                        } else {
                                          if (cubit.images.isNotEmpty) {


                                            await cubit
                                                .uploadProfileImage()
                                            .whenComplete(() async =>   await cubit.sendMassageToGroub(
                                                message:
                                                _textController.text,



                                                imagesLink: cubit.imagesLink,
                                                time: DateTime.now()
                                                    .toString()));

                                          }

                                          else {
                                            await ChatGroubCubit.get(context)
                                                .sendMassageToGroub(
                                              message: _textController.text,

                                              imagesLink: [],


                                              time: DateTime.now().toString(),

                                            );
                                          }

                                          cubit.images.clear();
                                          cubit.imagesLink.clear();
                                          _textController.clear();
                                        }
                                      }),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  );
                },
                fallback: (context) => Center(
                    child: LoadingAnimationWidget.twoRotatingArc(
                  color: Colors.blueAccent,
                  size: 100,
                )),
              ),
            );
          },
        );
      }),
    );
  }
}

class TextFormFieldChat extends StatelessWidget {
  const TextFormFieldChat({
    super.key,
    required TextEditingController textController,
  }) : _textController = textController;

  final TextEditingController _textController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.blueAccent,
      style: TextStyle(
          color: Colors.blueAccent),
      cursorRadius:
          Radius.circular(10),
      controller: _textController,
      decoration: InputDecoration(
        isDense: true,
        hintText:
            'Enter your message',
        hintStyle: TextStyle(
          fontSize: MediaQuery.of(context).size.width / 25,
            color: Colors.blueAccent),
        filled: true,
        fillColor: Colors.white,
        border: InputBorder.none,
      ),
    );
  }
}

Widget chosenFile({
  Function()? onGallary,
  Function()? onFile,

}) =>
    Container(
       height: 100,

        margin: EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(

                width: 70,
                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),
                      child: IconButton(
                        onPressed: () {
                          onGallary!();
                        },
                        icon: Icon(
                          Ionicons.image_outline,
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(
                      'Gallery',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                )),
            SizedBox(
              width: 10,
            ),
            Container(

                margin: EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    CircleAvatar(
                      backgroundColor: Colors.blueAccent.withOpacity(0.2),

                      radius: 30,
                      child: IconButton(
                        onPressed: () {
                          onFile!();
                        },
                        icon: Icon(
                          Ionicons.file_tray,
                        ),
                        color: Colors.blueAccent,
                      ),
                    ),
                    Text(
                      'Document',
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                  ],
                )),
            SizedBox(
              width: 10,
            ),

          ],
        ));

Widget fileIcon({String? url, BuildContext? context}) {
  Uri uri = Uri.parse(url!);
  String fileName = uri.pathSegments.last.split('/').last;

  var dio = Dio();
  return Container(


    child: Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.blueAccent.withOpacity(0.2),
          child: IconButton(
            onPressed: () async {
              var pdfUrl = url;
              var dir = await getApplicationDocumentsDirectory();
              var filePath = '${dir.path}/file.pdf';
              var dio = Dio();

              // Wrap the download function in a FutureBuilder


              // Delay the navigation until the current widget tree build operation is complete
              // WidgetsBinding.instance!.addPostFrameCallback((_) {
              //   navigateToScreen(context, PdfPage(path: url));
              // });
              // // showDialog(
              // //   context: context!,
              // //   builder: (context) => FutureBuilder(
              // //     future: dio.download(pdfUrl, filePath),
              // //     builder: (context, snapshot) {
              // //       if (snapshot.connectionState == ConnectionState.waiting) {
              // //         return AlertDialog(
              // //           content: Row(
              // //             children: [
              // //               LoadingAnimationWidget.twoRotatingArc(
              // //                 color: greenColor,
              // //                 size: 100,
              // //               ),
              // //               SizedBox(width: 20),
              // //               Text('Downloading PDF...'),
              // //             ],
              // //           ),
              // //         );
              // //       } else if (snapshot.connectionState == ConnectionState.done) {
              // //         // Close the dialog when download is complete
              // //         Navigator.pop(context);
              // //
              // //         // Delay the navigation until the current widget tree build operation is complete
              // //         WidgetsBinding.instance!.addPostFrameCallback((_) {
              // //           navigateToScreen(context, PdfPage(path: url));
              // //         });
              // //       }
              // //       return Container();
              // //     },
              // //   ),
              // // );
              navigateToScreen(context!, PdfPage(path: url));
            },
            icon: Icon(
              Ionicons.file_tray,
            ),
            color: Colors.blueAccent,
          ),
        ),
        Flexible(
          child: Text(
            fileName,
            style: TextStyle(color: Colors.blueAccent),
          ),
        ),
      ],
    ),
  );
}

Widget Image({String? image, BuildContext? context}) {
  return GestureDetector(
    onTap: () {
      navigateToScreen(context!, ImageScrean(image: image!));
    },
    child: Container(
      height: 50,
      width: 50,
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: CachedNetworkImage(
        imageUrl: image!, // Use the image string directly as the imageUrl
        imageBuilder: (context, imageProvider) => Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            image: DecorationImage(
              image: imageProvider,
              fit: BoxFit.cover,
            ),
          ),
        ),
        fit: BoxFit.cover,
        placeholder: (context, url) => LoadingAnimationWidget.twoRotatingArc(
          color: Colors.blueAccent,
          size: 100,
        ),
        errorWidget: (context, url, error) => Icon(Icons.error),
      ),
    ),
  );
}

Widget locaion({String? location}) {
  RegExp regExp = RegExp(r'(https?://[^\s]+)');
  String? url = regExp.firstMatch(location!)?.group(0);
  String? othertext = location.replaceAll(regExp, '');

  Uri _url = Uri.parse(url!);

  return InkWell(
    child: Column(
      children: [
        Text(
          othertext!,
          textAlign: TextAlign.start,
        ),
        Text(
          url,
          textAlign: TextAlign.start,
          style: TextStyle(color: Colors.blueAccent),
        ),
      ],
    ),
    onTap: () async {
      if (!await launchUrl(_url)) {
        throw Exception('Could not launch $_url');
      }
    },
  );
}

Widget file({
  File? file,
}) {
  if (file!.path.contains('pdf')) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          child: Icon(
            Ionicons.file_tray,
            color: Colors.blueAccent,
          ),
        ),
        Text(
          file.path.split('/').last,
          style: TextStyle(color: Colors.blueAccent),
        ),
      ],
    );
  }
  if (file.path.contains('.mp4')) {
    return Container(

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            child: Icon(
              Ionicons.videocam,
              color: Colors.blueAccent,
            ),
          ),
          Text(
            file.path.split('/').last,
            style: TextStyle(color: Colors.blueAccent),
          ),
        ],
      ),
    );
  }
  else {
    return Container(
      height: 50,
      width: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: DecorationImage(
          image: FileImage(file),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}


Widget videoIcon  ({ String? image, BuildContext? context}){
  Uri uri = Uri.parse(image!);
  String fileName = uri.pathSegments.last.split('/').last;

return GestureDetector(

onTap: (){
navigateToScreen(context!, VideoFile(urlVideo: image));

},child: Container(


margin: EdgeInsets.all(8.0),
decoration: BoxDecoration(

borderRadius: BorderRadius.circular(10),
),
child: Container(
  padding: EdgeInsets.all(8.0),
  decoration: BoxDecoration(
    color: Colors.blueAccent.withOpacity(0.2),

    borderRadius: BorderRadius.circular(10),
border: Border.all(
  color: Colors.blueAccent,
  width: 2,
),
  ),
  child: Column(
    children: [
      Icon(
      Ionicons.videocam,
      color: Colors.blueAccent,
      ),
      Text(
        fileName,
        style: TextStyle(color: Colors.blueAccent),
      ),
    ],
  ),
),
) );
}
