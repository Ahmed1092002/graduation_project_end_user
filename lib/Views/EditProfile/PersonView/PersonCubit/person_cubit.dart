import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/PersonModel.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:meta/meta.dart';

import '../../../../utils/dio_helper.dart';

part 'person_state.dart';

class PersonCubit extends Cubit<PersonState> {
  PersonCubit() : super(PersonInitial());
  static PersonCubit get(context) => BlocProvider.of(context);

  PersonModel? personModel;
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController birthDateController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  getPersonById () async {
    int id = await CashHelper.getData(key: 'personId');
    emit(PersonLoadingState());
    try {
      var response = await DioHelper.getData(url: '/People/$id') ;
      if (response.statusCode == 200) {
        print (response.data);
        personModel = PersonModel.fromJson(response.data);
        firstNameController.text = personModel!.firstName!;
        lastNameController.text = personModel!.lastName!;
        emailController.text = personModel!.email!;
        phoneController.text = personModel!.phone1!;
        addressController.text = personModel!.address!;
        birthDateController.text = personModel!.dateOfBirth!;
        genderController.text = personModel!.gender!;


        emit(PersonSuccessState());
      }
    } catch (e) {
      print (e.toString());
      emit(PersonErrorState());
    }
  }


  editPerson({PersonModel? personModel })async{
    emit(EditPersonLoadingState());
    var response = await DioHelper.putData(
        url: '/People',
        data: personModel!.toJson(),
    );
    if (response.statusCode == 200|| response.statusCode == 201) {
      print (response.data);
      emit(EditPersonSuccessState());
    }
    else {
      emit(EditPersonErrorState());
    }
  }


}
