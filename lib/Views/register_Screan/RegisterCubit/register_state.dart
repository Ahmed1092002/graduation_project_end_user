part of 'register_cubit.dart';

@immutable
sealed class RegisterState {}

final class RegisterInitial extends RegisterState {}

final class AddPersonLoading extends RegisterState {}

final class AddPersonSuccess extends RegisterState {
  final PersonModel personModel;
  AddPersonSuccess(this.personModel);
}

class AddPersonError extends RegisterState {
  final String message;
  AddPersonError(this.message);
}

final class AddUserLoading extends RegisterState {}

final class AddUserLoaded extends RegisterState {

}

final class AddUserError extends RegisterState {}
final class GetPersonByIdLoading extends RegisterState {}

final class GetPersonByIdSuccess extends RegisterState {}

final class GetPersonByIdError extends RegisterState {}
final class GetCountryByIdLoading extends RegisterState {}

final class GetCountryByIdLoaded extends RegisterState {}

final class GetCountryByIdError extends RegisterState {}
final class GetAllCountryLoading extends RegisterState {}

final class GetAllCountrySuccess extends RegisterState {}

final class GetAllCountryError extends RegisterState {}
final class ProfileImagePickedSuccessState extends RegisterState {}

final class ProfileImagePickedErrorState extends RegisterState {}
final class uploadProfileImageLoadingState extends RegisterState {}

final class uploadProfileImageSuccessState extends RegisterState {}

final class uploadProfileImageErrorState extends RegisterState {}
final class AddRefugeeLoading extends RegisterState {}

final class AddRefugeeLoaded extends RegisterState {}

final class AddRefugeeError extends RegisterState {}






final class FileUploadLoadingState extends RegisterState {}
final class FileUploadSuccessState extends RegisterState {}
final class PdfPickedSuccessState extends RegisterState {}
final class PdfPickedErrorState extends RegisterState {}
final class FileUploadErrorState extends RegisterState {}
