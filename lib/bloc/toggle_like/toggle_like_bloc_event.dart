abstract class ToggleLikeBlocEvent {}

class ToggleLikeBlocSetStatus extends ToggleLikeBlocEvent {
  final int feedId;
  final bool isLiked;
  ToggleLikeBlocSetStatus(this.feedId, this.isLiked);
}

class ToggleLikeBlocStart extends ToggleLikeBlocEvent {}
