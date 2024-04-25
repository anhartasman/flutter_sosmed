import 'dart:convert';

import 'package:equatable/equatable.dart';

class ToggleFollowBlocState extends Equatable {
  final bool isFollowed;
  final int userId;
  final bool onLoading;
  const ToggleFollowBlocState({
    this.isFollowed = false,
    this.userId = 0,
    this.onLoading = false,
  });
  @override
  List<Object> get props => [isFollowed, userId, onLoading];

  @override
  String toString() =>
      'ToggleFollowBlocState(isFollowed: $isFollowed, userId: $userId, onLoading: $onLoading)';

  ToggleFollowBlocState copyWith({
    bool? isFollowed,
    int? userId,
    bool? onLoading,
  }) {
    return ToggleFollowBlocState(
      isFollowed: isFollowed ?? this.isFollowed,
      userId: userId ?? this.userId,
      onLoading: onLoading ?? this.onLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isFollowed': isFollowed,
      'userId': userId,
      'onLoading': onLoading,
    };
  }

  factory ToggleFollowBlocState.fromMap(Map<String, dynamic> map) {
    return ToggleFollowBlocState(
      isFollowed: map['isFollowed'] ?? false,
      userId: map['userId']?.toInt() ?? 0,
      onLoading: map['onLoading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToggleFollowBlocState.fromJson(String source) =>
      ToggleFollowBlocState.fromMap(json.decode(source));
}
