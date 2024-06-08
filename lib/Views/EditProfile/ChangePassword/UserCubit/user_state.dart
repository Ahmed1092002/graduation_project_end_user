part of 'user_cubit.dart';

@immutable
sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {

}

final class UserError extends UserState {}
final class GetUserByIdLoading extends UserState {}
final class GetUserByIdSuccess extends UserState {}
final class GetUserByIdError extends UserState {}
final class UserSuccess extends UserState {}


