import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

import '../../../Models/UserModel.dart';
import '../../../main.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../utils/cashe_helper.dart';
import '../model/chat_model.dart';

part 'chat_groub_state.dart';

class ChatGroubCubit extends Cubit<ChatGroubState> {
  ChatGroubCubit() : super(ChatGroubInitial());
  static ChatGroubCubit get(context) => BlocProvider.of(context);

  List<String> messages = [];
  var box = Hive.box(boxName);

  UserModel? user;
  String? profileImageLink = '';
  var imagePicker = ImagePicker();
  File? profileImage;
  List<File> images = [];
  List<String> imagesLink = [];
  Future<void> pickMultipleMediaImage() async {
    final List<XFile> medias = await imagePicker.pickMultipleMedia();
    if (medias.isNotEmpty) {
      for (var element in medias) {
        images.add(File(element.path));

      }
      // profileImage = File(pickedFile.path);

      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> pickCameraImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      images.add(File(pickedFile.path));


      emit(ProfileImagePickedSuccessState());

    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }
  }

  Future<void> pickFilePdf() async {
// Picking a PDF file
    FilePickerResult? result = await FilePicker.platform.pickFiles(type: FileType.custom, allowedExtensions: ['pdf'],allowMultiple: true);
    if (result != null) {
      File file = File(result.files.single.path!);
      images.add(file);
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
    }

  }

  Future uploadProfileImage() async {
    if (images.isNotEmpty) {
      emit(uploadProfileImageLoadingState());
      try {
        for (var element in images) {
          await firebase_storage.FirebaseStorage.instance
              .ref()
              .child('users/${Uri.file(element.path).pathSegments.last}')
              .putFile(element)
              .then((value) async {
            await value.ref.getDownloadURL().then((value) {
              imagesLink.add(value);
              print(value);
            });
          }).catchError((error) {
            print(error);
          });
        }
        emit(uploadProfileImageSuccessState());
      } catch (error) {
        print(error);
        emit(uploadProfileImageErrorState());
      }
      return imagesLink;
    } else {
      print('No profile image selected.');
      emit(uploadProfileImageErrorState());
      return imagesLink;
    }
  }

  String ?firstName ;
  String ?lastName ;
  int ?countryId;
  int ?refugeeId ;
  getPersonData()async{
    print ("getPersonData");
    // firstName = await box.get("firstName");
    // lastName = await box.get("lastName");
    // countryId = await box.get("countryId");
    // refugeeId = await box.get('refugeeId');
    String ?firstName = await CashHelper.getData(key: 'firstName');
    String ?lastName = await CashHelper.getData(key: 'lastName');
    int ?countryId = await CashHelper.getData(key: 'countryId');
    int ?refugeeId = await CashHelper.getData(key: 'refugeeId');
    print(refugeeId);
    print(firstName);
    print(lastName);
    print(countryId);


  }
  sendMassageToGroub(
  {
    required String message,


    required List<String> imagesLink,


    required String time,

  }
      )async{

    await getPersonData();
    // String ?firstName = await box.get("firstName").toString();
    // String ?lastName = await box.get("lastName").toString();
    // int ?countryId = await box.get("countryId");
    // int ?refugeeId = await box.get('refugeeId');

    // print (refugeeId);
    // print(firstName);
    // print(lastName);
    // print(countryId);


    String ?firstName = await CashHelper.getData(key: 'firstName');
    String ?lastName = await CashHelper.getData(key: 'lastName');
    int ?countryId = await CashHelper.getData(key: 'countryId');
    int ?refugeeId = await CashHelper.getData(key: 'refugeeId');

    ChatModel chatModel = ChatModel(
      message: message,

      senderId:refugeeId!,
      senderName: "${firstName} ${lastName}",
      images: imagesLink,
      time: time,
    );
    emit(SendMessageLoadingState());
    await FirebaseFirestore.instance.collection(countryId.toString())
        .add(chatModel.toMap())
    .then((value) {
      emit(SendMessageSuccessState());
    }).catchError((error){
      emit(SendMessageErrorState());
    });










  }

  List<ChatModel>Masseges = [];
  getChatGroubMessages()async{
    int ?countryId = await CashHelper.getData(key: 'countryId');
    emit(GetMessagesLoadingState());
    await FirebaseFirestore.instance.collection(countryId.toString())
        .orderBy('time',descending: true)
        .snapshots()
        .listen((event) {
      Masseges = [];

      event.docs.forEach((element) {

        Masseges.add(ChatModel.fromMap(element.data(), element.id));
      });
      emit(GetMessagesSuccessState());
    });
  }

  editMyMessage({
    required String message,
    required String time,
    required String chatId,
    required List<String> imagesLink,
  })async{
    int ?countryId = await CashHelper.getData(key: 'countryId');
    await FirebaseFirestore.instance.collection(countryId.toString())
        .doc(chatId)
        .update({
      'message':message,
      'time':time,
      'images':imagesLink,
    }).then((value) {
      emit(EditMessageSuccessState());
    }).catchError((error){
      emit(EditMessageErrorState());
    });
  }

  deleteMyMessage({
    required String chatId,
  })async{
    int ?countryId = await CashHelper.getData(key: 'countryId');
    await FirebaseFirestore.instance.collection(countryId.toString())
        .doc(chatId)
        .delete()
        .then((value) {
      emit(DeleteMessageSuccessState());
    }).catchError((error){
      emit(DeleteMessageErrorState());
    });
  }

}
