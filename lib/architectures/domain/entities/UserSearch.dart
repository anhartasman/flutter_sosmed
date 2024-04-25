// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

class UserSearch {
  final int page;
  final int limit;
  final bool onlyFriend;
  final int? userId;

  const UserSearch({
    this.page = 0,
    this.limit = 5,
    this.onlyFriend = false,
    this.userId,
  });

  UserSearch copyWith({
    int? page,
    int? limit,
    bool? onlyFriend,
    ValueGetter<int?>? userId,
  }) {
    return UserSearch(
      page: page ?? this.page,
      limit: limit ?? this.limit,
      onlyFriend: onlyFriend ?? this.onlyFriend,
      userId: userId != null ? userId() : this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'limit': limit,
      'onlyFriend': onlyFriend,
      'userId': userId,
    };
  }

  factory UserSearch.fromMap(Map<String, dynamic> map) {
    return UserSearch(
      page: map['page']?.toInt() ?? 0,
      limit: map['limit']?.toInt() ?? 0,
      onlyFriend: map['onlyFriend'] ?? false,
      userId: map['userId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserSearch.fromJson(String source) =>
      UserSearch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserSearch(page: $page, limit: $limit, onlyFriend: $onlyFriend, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserSearch &&
        other.page == page &&
        other.limit == limit &&
        other.onlyFriend == onlyFriend &&
        other.userId == userId;
  }

  @override
  int get hashCode {
    return page.hashCode ^
        limit.hashCode ^
        onlyFriend.hashCode ^
        userId.hashCode;
  }
}
