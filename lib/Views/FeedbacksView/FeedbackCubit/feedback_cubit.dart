import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/feedback_model.dart';
import 'package:graduation_project_end_user/main.dart';
import 'package:graduation_project_end_user/utils/cashe_helper.dart';
import 'package:graduation_project_end_user/utils/dio_helper.dart';
import 'package:hive/hive.dart';
import 'package:meta/meta.dart';

part 'feedback_state.dart';

class FeedbackCubit extends Cubit<FeedbackState> {
  FeedbackCubit() : super(FeedbackInitial());
  static FeedbackCubit get(context) => BlocProvider.of(context);
  FeedbackModel? feedbackModel ;
  var box =Hive.box(boxName);


   sendFeedback({
      required int rating,
      required String message,

}) async {
     // var refugeeId = await box.get('refugeeId');
     var refugeeId = await CashHelper.getData(key: 'refugeeId');


     emit(FeedbackLoading());
     try {
       var response = await DioHelper.postData(
         url: '/Feedbacks',
         data: {
           "refugeeID":refugeeId,
           "rating": rating,
           "message": message,
           "feedbackDate": DateTime.now().toIso8601String()
         },

       );
       if (response.statusCode == 200 || response.statusCode == 201) {
         emit(FeedbackLoaded());
       } else {
         emit(FeedbackError());
       }

     } catch (e) {
       emit(FeedbackError());
     }
   }


}
