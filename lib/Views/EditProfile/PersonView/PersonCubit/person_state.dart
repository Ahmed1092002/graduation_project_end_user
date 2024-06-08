part of 'person_cubit.dart';

@immutable
sealed class PersonState {}

final class PersonInitial extends PersonState {}

final class PersonLoadingState extends PersonState {}

final class PersonSuccessState extends PersonState {

}

final class PersonErrorState extends PersonState {}
final class EditPersonLoadingState extends PersonState {}
final class EditPersonSuccessState extends PersonState {}
final class EditPersonErrorState extends PersonState {}

