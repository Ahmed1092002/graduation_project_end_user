part of 'localization_cubit.dart';

@immutable
abstract class LocalizationState {}

class LocalizationInitial extends LocalizationState {}
class LocalizationChangeLang extends LocalizationState {}
class ChangeLanguageSuccessState extends LocalizationState {}
class ChangeLanguageFaildState extends LocalizationState {}
class ChangeLanguageLoadingState extends LocalizationState {}
