part of 'refugee_cubit.dart';

@immutable
sealed class RefugeeState {}

final class RefugeeInitial extends RefugeeState {}

final class GetCountryByIdLoading extends RefugeeState {}

final class GetCountryByIdSuccess extends RefugeeState {

}

final class GetCountryByIdFailure extends RefugeeState {

}

final class GetRefugeeByIdLoading extends RefugeeState {}

final class GetRefugeeByIdSuccess extends RefugeeState {

}

final class GetRefugeeByIdFailure extends RefugeeState {

}
final class EditRefugeeLoading extends RefugeeState {}
final class EditRefugeeSuccess extends RefugeeState {}
final class EditRefugeeFailure extends RefugeeState {}
final class ProfileImagePickedSuccessState extends RefugeeState {}
final class ProfileImagePickedErrorState extends RefugeeState {}
final class FileUploadLoadingState extends RefugeeState {}
final class FileUploadSuccessState extends RefugeeState {}
final class FileUploadErrorState extends RefugeeState {}
final class GetAllCountryLoading extends RefugeeState {}
final class GetAllCountrySuccess extends RefugeeState {}
final class GetAllCountryError extends RefugeeState {}
final class PdfPickedSuccessState extends RefugeeState {}
final class PdfPickedErrorState extends RefugeeState {}


