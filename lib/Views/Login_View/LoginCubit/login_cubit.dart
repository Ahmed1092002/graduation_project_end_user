import 'package:bloc/bloc.dart';
import 'package:graduation_project_end_user/Models/PersonModel.dart';
import 'package:graduation_project_end_user/Models/UserModel.dart';
import 'package:graduation_project_end_user/Views/Login_View/Model/LoginModel.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:graduation_project_end_user/utils/dio_helper.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../Models/CountryModel.dart';
part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());
  static LoginCubit get(context) => BlocProvider.of(context);
  var box = Hive.box('localization');
  LoginModel? loginModel;
   login ({required String email, required String password}) async {
    emit(LoginLoadingState());

    try {
      var response = await DioHelper.getData(url: '/Refugees/RefugeeLogin?email=$email&password=$password') ;
      if (response.statusCode == 200) {
        print (response.data);
        loginModel = LoginModel.fromJson(response.data);
     await   getPersonById(loginModel!.personId!);
     //  await   getCountryById(loginModel!.countryId!);


        // await box.put('refugeeId', loginModel!.refugeeId);
        // await box.put('personId', loginModel!.personId);
        // await box.put('userId', loginModel!.userId);
        // await box.put('countryId', loginModel!.countryId);
        // await box.put('cv', loginModel!.cv);
        // await box.put('imagePath', loginModel!.imagePath);

        await CashHelper.saveData(key: 'refugeeId', value: loginModel!.refugeeId);
        await CashHelper.saveData(key: 'personId', value: loginModel!.personId);
        await CashHelper.saveData(key: 'userId', value: loginModel!.userId);
        await CashHelper.saveData(key: 'countryId', value: loginModel!.countryId);
        await CashHelper.saveData(key: 'cv', value: loginModel!.cv);
        await CashHelper.saveData(key: 'imagePath', value: loginModel!.imagePath);



        // String ?firstName = await box.get("firstName").toString();
        // String ?lastName = await box.get("lastName").toString();
        // int ?countryId = await box.get("countryId");
        // int ?refugeeId = await box.get('refugeeId');




await getUserByID();


        emit(LoginSuccessState());
      } else {
        emit(LoginErrorState());
      }

      emit(LoginSuccessState());
    } catch (e) {
      emit(LoginErrorState());
    }
  }
  PersonModel? personModel;
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
  UserModel ? userModel;
getUserByID()async {
  emit(GetUserByIdLoading());
  try {
    var userId = await CashHelper.getData(key: 'userId');
    final response = await DioHelper.getData(url: "/Users/$userId");
    if (response.statusCode == 200) {
      print(response.data);

      userModel = UserModel.fromJson(response.data);
      await CashHelper.saveData(key: 'userName', value: userModel!.userName);
      await CashHelper.saveData(key: 'createdAt', value: userModel!.createdAt);


      emit(GetUserByIdSuccess());
    } else {
      print(response.statusCode);
      emit(GetUserByIdError());
    }
  } catch (error) {
    emit(GetUserByIdError());
  }
}



}
