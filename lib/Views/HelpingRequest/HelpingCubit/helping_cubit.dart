import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/HelpingRequestModel.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:meta/meta.dart';

import '../../../utils/dio_helper.dart';

part 'helping_state.dart';

class HelpingCubit extends Cubit<HelpingState> {
  HelpingCubit() : super(HelpingInitial());

  static HelpingCubit get(context) => BlocProvider.of(context);

  HelpingRequestModel? helpingRequestModel;

  sendRequest({
    required String message,


}) async {
    emit (HelpingLoading());
    var refugeeId= await CashHelper.getData(key: 'refugeeId');

    try {
      var response= await DioHelper.postData(
          url: '/HelpingRefugee',
          data:{
            "refugeeID": refugeeId,
            "message": message,
            "requestDate": DateTime.now().toIso8601String(),
          });
      if (response.statusCode == 200 || response.statusCode ==201) {
        print(response.data);
        helpingRequestModel = HelpingRequestModel.fromJson(response.data);
        emit(HelpingLoaded());
      }


    }
    catch (e) {
      emit(HelpingError());
    }

  }

}
