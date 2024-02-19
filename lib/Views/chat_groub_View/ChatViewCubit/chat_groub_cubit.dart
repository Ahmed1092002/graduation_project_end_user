import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

part 'chat_groub_state.dart';

class ChatGroubCubit extends Cubit<ChatGroubState> {
  ChatGroubCubit() : super(ChatGroubInitial());
  static ChatGroubCubit get(context) => BlocProvider.of(context);


}
