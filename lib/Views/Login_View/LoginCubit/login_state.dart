part of 'login_cubit.dart';

@immutable
sealed class LoginState {}

final class LoginInitial extends LoginState {}

final class LoginLoadingState extends LoginState {}

final class LoginSuccessState  extends LoginState {}

final class LoginErrorState extends LoginState {}
final class GetPersonByIdLoading extends LoginState {}
final class GetPersonByIdSuccess extends LoginState {}
final class GetPersonByIdError extends LoginState {}
final class GetCountryByIdLoading extends LoginState {}
final class GetCountryByIdLoaded extends LoginState {}
final class GetCountryByIdError extends LoginState {}
final class GetUserByIdLoading extends LoginState {}
final class GetUserByIdSuccess extends LoginState {}
final class GetUserByIdError extends LoginState {}





