abstract class ToggleFollowBlocEvent {}

class ToggleFollowBlocSetStatus extends ToggleFollowBlocEvent {
  final int userId;
  final bool isFollowed;
  ToggleFollowBlocSetStatus(this.userId, this.isFollowed);
}

class ToggleFollowBlocStart extends ToggleFollowBlocEvent {}
