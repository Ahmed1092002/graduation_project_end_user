part of 'content_cubit.dart';

@immutable
sealed class ContentState {}

final class ContentInitial extends ContentState {}

final class ContentLoading extends ContentState {}

final class ContentLoaded extends ContentState {
  final List<ContentModel> contentModel;
  ContentLoaded(this.contentModel);
}

final class ContentError extends ContentState {
  final String message;
  ContentError(this.message);
}
