import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/RefugeeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

import '../../../../Models/CountryModel.dart';
import '../../../../Models/UserModel.dart';
import '../../../../utils/cashe_helper.dart';
import '../../../../utils/dio_helper.dart';

part 'refugee_state.dart';

class RefugeeCubit extends Cubit<RefugeeState> {
  RefugeeCubit() : super(RefugeeInitial());

  static RefugeeCubit get(context) => BlocProvider.of(context);
  CountryModel? countryModel;

  getCountryById() async {
    var countryId = await CashHelper.getData(key: 'countryId');

    emit(GetCountryByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Countries/$countryId");
      if (response.statusCode == 200) {
        countryModel = CountryModel.fromJson(response.data);


        emit(GetCountryByIdSuccess(

        ));
      } else {
        print(response.statusCode);
        emit(GetCountryByIdFailure());
      }
    } catch (error) {
      emit(GetCountryByIdFailure());
    }
  }

  RefugeeModel? refugeeModel;

  getRefugeeById() async {
    var refugeeId = await CashHelper.getData(key: 'refugeeId');

    emit(GetRefugeeByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Refugees/$refugeeId");

      if (response.statusCode == 200) {
        print(response.data);
        refugeeModel = RefugeeModel.fromJson(response.data);
        print(refugeeModel!.refugeeId);
        emit(GetRefugeeByIdSuccess(

        ));
      }
      else {
        print(response.statusCode);
        emit(GetRefugeeByIdFailure());
      }
    } catch (error) {
      emit(GetRefugeeByIdFailure());
    }
  }

  editRefugee({RefugeeModel? refugeeModel}) async {
    emit(EditRefugeeLoading());

    final response = await DioHelper.putData(
      url: '/Refugees',
      data: refugeeModel!.toJson(),
    );
    if (response.statusCode == 200 || response.statusCode == 201|| response.statusCode == 204) {
      print(response.data);
      await CashHelper.UpdateData(key: 'countryId', value: refugeeModel!.countryId);
      await getRefugeeById();
      await getAllCountry();
      await getCountryById();
      emit(EditRefugeeSuccess());
    } else {
      emit(EditRefugeeFailure());
    }
  }

  UserModel? user;
  String? profileImageLink = '';
  String? pdfLink = '';
  String? fileName = '';
  var imagePicker = ImagePicker();
  File? profileImage;
  File? pdfFile;
  String? fileLink;
  Future<void> pickCameraImage() async {
    final pickedFile = await imagePicker.pickImage(source: ImageSource.camera);
    if (pickedFile != null) {
      profileImage = File(pickedFile.path);


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
      for (PlatformFile file in result.files) {
        // Print the name of the file
        print('Selected PDF file name: ${file.name}');
        fileName = file.name;
        // You can also print other properties if needed
        print('Selected PDF file path: ${file.path}');
        print('Selected PDF file size: ${file.size}');
      }
      pdfFile = file;
      print (pdfFile!.path);
      emit(PdfPickedSuccessState());
    } else {
      print('No image selected.');
      emit(PdfPickedErrorState());
    }

  }

  Future<String?> uploadFile({
    required File? file,

  }) async {
    if (file != null) {
      print (file.path);
      emit(FileUploadLoadingState());
      try {
        // Upload the file to Firebase Storage
        var storageRef = firebase_storage.FirebaseStorage.instance
            .ref()
            .child("users/${Uri.file(file.path).pathSegments.last}");
        var uploadTask = await storageRef.putFile(file);

        // Get the download URL
        String fileLink = await uploadTask.ref.getDownloadURL();

        emit(FileUploadSuccessState());
        return fileLink;
      } catch (error) {
        print(error);
        emit(FileUploadErrorState());
        return null;
      }
    } else {
      print('No file selected.');
      emit(FileUploadErrorState());
      return null;
    }
  }


  List <CountryModel>? countryModelList;

  getAllCountry() async {
    try {
      emit(GetAllCountryLoading());
      var response = await DioHelper.getData(url: '/Countries');
      if (response.statusCode == 200) {

        countryModelList = (response.data as List).map((e) => CountryModel.fromJson(e)).toList();
        emit(GetAllCountrySuccess());
      } else {
        emit(GetAllCountryError());
      }
    } catch (e) {
      print(e.toString());
      emit(GetAllCountryError());
    }
  }


}
