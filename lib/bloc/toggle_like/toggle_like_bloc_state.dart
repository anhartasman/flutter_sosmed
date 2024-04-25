import 'dart:convert';

import 'package:equatable/equatable.dart';

class ToggleLikeBlocState extends Equatable {
  final bool isLiked;
  final int feedId;
  final bool onLoading;
  const ToggleLikeBlocState({
    this.isLiked = false,
    this.feedId = 0,
    this.onLoading = false,
  });
  @override
  List<Object> get props => [isLiked, feedId, onLoading];

  @override
  String toString() =>
      'ToggleLikeBlocState(isLiked: $isLiked, feedId: $feedId, onLoading: $onLoading)';

  ToggleLikeBlocState copyWith({
    bool? isLiked,
    int? feedId,
    bool? onLoading,
  }) {
    return ToggleLikeBlocState(
      isLiked: isLiked ?? this.isLiked,
      feedId: feedId ?? this.feedId,
      onLoading: onLoading ?? this.onLoading,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'isLiked': isLiked,
      'feedId': feedId,
      'onLoading': onLoading,
    };
  }

  factory ToggleLikeBlocState.fromMap(Map<String, dynamic> map) {
    return ToggleLikeBlocState(
      isLiked: map['isLiked'] ?? false,
      feedId: map['feedId']?.toInt() ?? 0,
      onLoading: map['onLoading'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory ToggleLikeBlocState.fromJson(String source) =>
      ToggleLikeBlocState.fromMap(json.decode(source));
}
