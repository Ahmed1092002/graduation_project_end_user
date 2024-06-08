part of 'chat_groub_cubit.dart';

@immutable
abstract class ChatGroubState {}

class ChatGroubInitial extends ChatGroubState {}
class SendMessageSuccessState extends ChatGroubState {}

class SendMessageErrorState extends ChatGroubState {}

class SendMessageLoadingState extends ChatGroubState {}
class GetMessagesSuccessState extends ChatGroubState {}
class GetMessagesErrorState extends ChatGroubState {}
class GetMessagesLoadingState extends ChatGroubState {}
class GetChatSuccessState extends ChatGroubState {}
class GetChatErrorState extends ChatGroubState {}
class GetChatLoadingState extends ChatGroubState {}
class ProfileImagePickedSuccessState extends ChatGroubState {}
class ProfileImagePickedErrorState extends ChatGroubState {}
class uploadProfileImageSuccessState extends ChatGroubState {}
class uploadProfileImageErrorState extends ChatGroubState {}
class uploadProfileImageLoadingState extends ChatGroubState {}
class IsTypingSuccessState extends ChatGroubState {}
class IsTypingErrorState extends ChatGroubState {}
class IsWatchedSuccessState extends ChatGroubState {}
class IsWatchedErrorState extends ChatGroubState {}
class GetMessageErrorState extends ChatGroubState {}
class DeleteMessageSuccessState extends ChatGroubState {}
class DeleteMessageErrorState extends ChatGroubState {}
class EditMessageSuccessState extends ChatGroubState {}
class EditMessageErrorState extends ChatGroubState {}

