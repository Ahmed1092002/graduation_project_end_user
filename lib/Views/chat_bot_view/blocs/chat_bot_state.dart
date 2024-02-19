part of 'chat_bot_cubit.dart';

@immutable
abstract class ChatBotState {}

class ChatBotInitial extends ChatBotState {}
class ChatBotLoading extends ChatBotState {}
class ChatBotSuccess extends ChatBotState {}
class ChatBotError extends ChatBotState {}

