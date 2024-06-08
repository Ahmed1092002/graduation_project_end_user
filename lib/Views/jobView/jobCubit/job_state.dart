part of 'job_cubit.dart';

@immutable
sealed class JobState {}

final class JobInitial extends JobState {}

final class JobLoading extends JobState {}

final class JobLoaded extends JobState {

}

final class JobError extends JobState {}
final class JobApplyingLoading extends JobState {}
final class JobApplyingSuccess extends JobState {}
final class JobApplyingError extends JobState {
  final String error;
  JobApplyingError(this.error);
}
final class getAllAppliedjobsLoading extends JobState {}
final class getAllAppliedjobsSuccess extends JobState {}
final class getAllAppliedjobsError extends JobState {}
final class GetJobByIdLoading extends JobState {}
final class GetJobByIdSuccess extends JobState {}
final class GetJobByIdError extends JobState {}



