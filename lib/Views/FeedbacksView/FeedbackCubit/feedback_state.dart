part of 'feedback_cubit.dart';

@immutable
sealed class FeedbackState {}

final class FeedbackInitial extends FeedbackState {}

final class FeedbackLoading extends FeedbackState {}

final class FeedbackLoaded extends FeedbackState {}

final class FeedbackError extends FeedbackState {}

