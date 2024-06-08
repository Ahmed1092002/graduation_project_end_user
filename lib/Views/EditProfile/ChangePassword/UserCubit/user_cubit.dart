import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/UserModel.dart';
import 'package:meta/meta.dart';

import '../../../../utils/cashe_helper.dart';
import '../../../../utils/dio_helper.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  static UserCubit get(context) => BlocProvider.of(context);
  UserModel? userModel;
  getUserByID()async {
    emit(GetUserByIdLoading());
    try {
      var userId = await CashHelper.getData(key: 'userId');
      final response = await DioHelper.getData(url: "/Users/$userId");
      if (response.statusCode == 200) {
        print(response.data);


        userModel = UserModel.fromJson(response.data);

        emit(GetUserByIdSuccess());
      } else {
        print(response.statusCode);
        emit(GetUserByIdError());
      }
    } catch (error) {
      emit(GetUserByIdError());
    }
  }
  changePassword({String?password})async{
    var userId = await CashHelper.getData(key: 'userId');
    var personId = await CashHelper.getData(key: 'personId');
var createdAt = await CashHelper.getData(key: 'createdAt');
var userName = await CashHelper.getData(key: 'userName');

    try {
      emit(UserLoading());
      var response = await DioHelper.putData(
          url: '/Users',
          data: {
            "userId": userId,
            "personId": personId,
            "userName": userName,
            "password": password,
            "isBlocked": false,
            "createdAt": createdAt,
          }
      );
      if (response.statusCode == 200|| response.statusCode == 201|| response.statusCode == 204) {

        emit(UserSuccess());
        getUserByID();
      } else {
        print(response.statusCode);
        emit(UserError());
      }
      emit(UserLoaded());
    } catch (e) {
      emit(UserError());
    }

  }

}
