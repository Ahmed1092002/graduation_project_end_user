import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project_end_user/Models/ContentModel.dart';
import 'package:meta/meta.dart';

part 'content_state.dart';

class ContentCubit extends Cubit<ContentState> {
  ContentCubit() : super(ContentInitial());
  static ContentCubit get(context) => BlocProvider.of(context);

  List<ContentModel> content = [];

  getAllContent() async {
    emit(ContentLoading());
    FirebaseFirestore.instance.collection('Content').get().then((value) {
      value.docs.forEach((element) {
        content.add(ContentModel.fromJson(element.data(), element.id));
      });
      emit(ContentLoaded(content));
    }).catchError((e) {
      emit(ContentError(e.toString()));
    });


  }
}
