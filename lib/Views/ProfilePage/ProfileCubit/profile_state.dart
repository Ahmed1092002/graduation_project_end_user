part of 'profile_cubit.dart';

@immutable
sealed class ProfileState {}

final class ProfileInitial extends ProfileState {}
final class GetRefugeeByIdLoading extends ProfileState {}
final class GetRefugeeByIdLoaded extends ProfileState {}
final class GetRefugeeByIdError extends ProfileState {}
final class GetPersonByIdLoading extends ProfileState {}
final class GetPersonByIdSuccess extends ProfileState {}
final class GetPersonByIdError extends ProfileState {}
final class GetCountryByIdLoading extends ProfileState {}
final class GetCountryByIdLoaded extends ProfileState {}
final class GetCountryByIdError extends ProfileState {}

