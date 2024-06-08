import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/RefugeeModel.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';

import '../../../Models/CountryModel.dart';
import '../../../Models/PersonModel.dart';
import '../../../Models/UserModel.dart';
import '../../../utils/cashe_helper.dart';
import '../../../utils/dio_helper.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit() : super(RegisterInitial());
  static RegisterCubit get(context) => BlocProvider.of(context);

  PersonModel? personModel;
  UserModel? userModel;

//   Future<void> addPerson(PersonModel? personModel) async {
//     emit(AddPersonLoading());
//
//     var headers = {
//       'Content-Type': 'application/json',
//     };
//
//     var data = json.encode({
//       "firstName": personModel!.firstName,
//       "lastName": personModel.lastName,
//       "gender": personModel.gender,
//       "address": personModel.address,
//       "phone1": personModel.phone1 ?? '', // Ensure phone1 is not null
//       "phone2": personModel.phone2 ?? '', // Ensure phone2 is not null
//       "dateOfBirth": personModel.dateOfBirth,
//       "email": personModel.email,
//     });
//
//     try {
//       var dio = Dio();
//       var response = await dio.post(
//         'http://arshdny.runasp.net/api/People',
//         options: Options(
//           headers: headers,
//         ),
//         data: data,
//       );
// print (response.data);
//       if (response.statusCode == 200 || response.statusCode == 201) {
//         print(json.encode(response.data));
//         personModel = PersonModel.fromJson(response.data);
//         this.personModel = personModel; // Update the cubit's personModel
//         emit(
//             AddPersonSuccess(personModel)
//         );
//       } else {
//         print("Error message: ${response.statusMessage}");
//         print("Error message: ${response.statusCode}");
//         emit(AddPersonError());
//       }
//     } catch (error) {
//       print("Exception: $error");
//       emit(AddPersonError());
//     }
//   }
  Future<void> addPerson(PersonModel? personModel) async {
    emit(AddPersonLoading());

    var headers = {
      'Content-Type': 'application/json',
    };

    var data = json.encode({
      "firstName": personModel!.firstName,
      "lastName": personModel.lastName,
      "gender": personModel.gender,
      "address": personModel.address,
      "phone1": personModel.phone1 ?? '', // Ensure phone1 is not null
      "phone2": personModel.phone2 ?? '', // Ensure phone2 is not null
      "dateOfBirth": personModel.dateOfBirth,
      "email": personModel.email,
    });

    try {
      var dio = Dio();
      var response = await dio.post(
        'http://arshdny.runasp.net/api/People',
        options: Options(
          headers: headers,
        ),
        data: data,
      );

      if (response.statusCode == 200 || response.statusCode == 201|| response.statusCode ==204) {
        print(json.encode(response.data));
        personModel = PersonModel.fromJson(response.data);
        this.personModel = personModel; // Update the cubit's personModel
        await CashHelper.saveData(key: 'personId', value: personModel.personId);
        emit(AddPersonSuccess(personModel));
      } else if (response.statusCode == 409) {
        // Handle conflict error
        emit(AddPersonError("Conflict: The person already exists."));
      } else {
        print("Error message: ${response.statusMessage}");
        emit(AddPersonError("Error message: ${response.statusMessage}"));
      }
    } catch (error) {
      print("Exception: $error");
      emit(AddPersonError(error.toString()));
    }
  }
  Future addUser({int? personId, String? userName, String? passward }) async {
    emit(AddUserLoading());
    var data = {
      "personId": personId,
      "userName": userName,
      "password": passward,
      "isBlocked": false,
    };
    print("addUser request data: $data"); // Log request data

    try {
      var request = await DioHelper.postData(url: "/Users", data: data);
      if (request.statusCode == 200 || request.statusCode == 201|| request.statusCode == 204) {
        userModel = UserModel.fromJson(request.data);
        this.userModel = userModel; // Update the cubit's userModel
        await CashHelper.saveData(key: 'userId', value: userModel!.userId);
        await CashHelper.saveData(key: 'userName', value: userModel!.userName);
        await CashHelper.saveData(key: 'createdAt', value: userModel!.createdAt);


        emit(AddUserLoaded());
      } else {
        print("Error: ${request.data}"); // Log response body
        emit(AddUserError());
      }
    } catch (error) {
      print("Exception: $error"); // Log the error
      emit(AddUserError());
    }
  }

  getPersonById(int id) async {
    emit(GetPersonByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/People/$id");
      if (response.statusCode == 200) {
        personModel = PersonModel.fromJson(response.data);
        // await box.put('firstName', personModel!.firstName);
        //  await box.put('lastName', personModel!.lastName);
        //  await box.put('email', personModel!.email);
        //  await box.put('phone', personModel!.phone1);
        //  await box.put('address', personModel!.address);

        await CashHelper.saveData(key: 'firstName', value: personModel!.firstName);
        await CashHelper.saveData(key: 'lastName', value: personModel!.lastName);
        await CashHelper.saveData(key: 'email', value: personModel!.email);
        await CashHelper.saveData(key: 'phone', value: personModel!.phone1);


        emit(GetPersonByIdSuccess(

        ));
      } else {
        print(response.statusCode);
        emit(GetPersonByIdError());
      }
    } catch (error) {
      emit(GetPersonByIdError());
    }

  }

  CountryModel? countryModel;
 List <CountryModel>? countryModelList;
  getCountryById(int id) async {
    emit(GetCountryByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Countries/$id");
      if (response.statusCode == 200) {

        countryModel = CountryModel.fromJson(response.data);
        // await box.put('countryName', countryModel!.countryName);
        await CashHelper.saveData(key: 'countryName', value: countryModel!.countryName);
        emit(GetCountryByIdLoaded(

        ));
      } else {
        print(response.statusCode);
        emit(GetCountryByIdError());
      }
    } catch (error) {
      emit(GetCountryByIdError());
    }
  }

  getAllCountry() async {
    try {
      emit(GetAllCountryLoading());
      var response = await DioHelper.getData(url: '/Countries');
      if (response.statusCode == 200) {
        print(response.data);
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
  UserModel? user;
  String? profileImageLink = '';
  String? pdfLink = '';

  var imagePicker = ImagePicker();
  File? profileImage;
  File? pdfFile;
  String? fileName = '';

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
      emit(ProfileImagePickedSuccessState());
    } else {
      print('No image selected.');
      emit(ProfileImagePickedErrorState());
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


RefugeeModel? refugeeModel;


   generateRandomString(int length, {bool includeUppercase = true, bool includeLowercase = true, bool includeNumbers = true, bool includeSpecialChars = false})async {
    const String uppercaseLetters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    const String lowercaseLetters = 'abcdefghijklmnopqrstuvwxyz';
    const String numbers = '0123456789';
    const String specialChars = '!@#\$%^&*()_+[]{}|;:,.<>?';

    String charSet = '';
    if (includeUppercase) charSet += uppercaseLetters;
    if (includeLowercase) charSet += lowercaseLetters;
    if (includeNumbers) charSet += numbers;
    if (includeSpecialChars) charSet += specialChars;

    if (charSet.isEmpty) {
      throw ArgumentError("At least one character set must be selected.");
    }

    Random random = Random.secure();
    return List.generate(length, (index) => charSet[random.nextInt(charSet.length)]).join('');
  }
  Future<void> addRefugee({
    required int refugeeJobId,
    required int userId,
    required String refugeeCardNo,
    required int countryId,
    required int nationaltyId,
    required String cv,
    required String imagePath,
    required String cardStartDate,
    required String cardEndDate,
    required String deviceToken,
  }) async {
    emit(AddRefugeeLoading());
    deviceToken = await generateRandomString(10); // Generate a random device token

    // Parse cardStartDate and cardEndDate to DateTime
    DateTime? parsedStartDate;
    DateTime? parsedEndDate;
    try {
      parsedStartDate = DateTime.parse(cardStartDate); // Ensure cardStartDate is in a parsable format like "yyyy-MM-dd"
      parsedEndDate = DateTime.parse(cardEndDate); // Ensure cardEndDate is in a parsable format like "yyyy-MM-dd"
    } catch (e) {
      print("Error parsing dates: $e");
      emit(AddRefugeeError());
      return;
    }

    // Convert to ISO 8601 strings
    String cardStartDateToIso = parsedStartDate.toIso8601String();
    String cardEndDateToIso = parsedEndDate.toIso8601String();

    // var data = {
    //   "refugeeJobId": refugeeJobId,
    //   "userId": userId,
    //   "refugeeCardNo": refugeeCardNo,
    //   "countryId": countryId,
    //   "nationaltyId": nationaltyId,
    //   "cv": cv,
    //   "imagePath": imagePath,
    //   "cardStartDate": cardStartDateToIso,
    //   "cardEndDate": cardEndDateToIso,
    //   "deviceToken": deviceToken,
    // };

    var data2 = {
      "refugeeJobId": refugeeJobId ,
      "userId": userId,
      "refugeeCardNo": refugeeCardNo,
      "countryId": countryId,
      "nationaltyId": nationaltyId,
      "cv": cv,
      "imagePath": imagePath,
      "cardStartDate": cardStartDateToIso,
      "cardEndDate": cardEndDateToIso,
      "deviceToken": deviceToken
    };

    // Log request data
    print("addRefugee request data: $data2");

    try {
      var request = await DioHelper.postData(url: "/Refugees", data: data2);
      print("addRefugee response status: ${request.statusCode}");
      print("addRefugee response status: ${request.statusMessage}");
      print("addRefugee response data: ${request.data}");
      if (request.statusCode == 200 || request.statusCode == 201 || request.statusCode == 204) {
        var refugeeModel = RefugeeModel.fromJson(request.data);
        this.refugeeModel = refugeeModel; // Update the cubit's refugeeModel

        await CashHelper.saveData(key: 'countryId', value: refugeeModel.countryId);
        await CashHelper.saveData(key: 'refugeeId', value: refugeeModel.refugeeId);
        await CashHelper.saveData(key: 'cv', value: refugeeModel.cv);

        emit(AddRefugeeLoaded());
      } else {
        print("Error: ${request.data}"); // Log response body
        emit(AddRefugeeError());
      }
    } catch (error) {
      print("Exception: $error"); // Log the error
      emit(AddRefugeeError());
    }
  }











}
