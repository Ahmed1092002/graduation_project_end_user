import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../Models/CountryModel.dart';
import '../../../Models/PersonModel.dart';
import '../../../Models/RefugeeModel.dart';
import '../../../Models/UserModel.dart';
import '../../../utils/cashe_helper.dart';
import '../../../utils/dio_helper.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());
  static ProfileCubit get(context) => BlocProvider.of(context);
  PersonModel? personModel;

  getPersonById() async {
    var personId = await CashHelper.getData(key: 'personId');
    emit(GetPersonByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/People/$personId");
      if (response.statusCode == 200) {
        personModel = PersonModel.fromJson(response.data);


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
  getCountryById() async {
    var countryId = await CashHelper.getData(key: 'countryId');
    emit(GetCountryByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Countries/$countryId");
      if (response.statusCode == 200) {

        countryModel = CountryModel.fromJson(response.data);

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


  RefugeeModel? refugeeModel;
  getRefugeeById() async {
    var refugeeId = await CashHelper.getData(key: 'refugeeId');
    emit(GetRefugeeByIdLoading());
    try {
      final response = await DioHelper.getData(url: "/Refugees/$refugeeId");
      if (response.statusCode == 200) {
        refugeeModel = RefugeeModel.fromJson(response.data);



        emit(GetRefugeeByIdLoaded());
      } else {
        print(response.statusCode);
        emit(GetRefugeeByIdError());
      }
    } catch (error) {
      emit(GetRefugeeByIdError());
    }
  }
}
