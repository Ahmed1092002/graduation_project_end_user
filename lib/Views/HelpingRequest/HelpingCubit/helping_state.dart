part of 'helping_cubit.dart';

@immutable
sealed class HelpingState {}

final class HelpingInitial extends HelpingState {}

final class HelpingLoading extends HelpingState {}

final class HelpingLoaded extends HelpingState {}

final class HelpingError extends HelpingState {}

