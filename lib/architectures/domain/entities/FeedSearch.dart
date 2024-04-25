// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

class FeedSearch {
  final int limit;
  final int page;
  final int? userId;
  final bool favourite;

  const FeedSearch({
    this.limit = 5,
    this.page = 0,
    this.userId,
    this.favourite = false,
  });

  FeedSearch copyWith({
    int? limit,
    int? page,
    ValueGetter<int?>? userId,
    bool? favourite,
  }) {
    return FeedSearch(
      limit: limit ?? this.limit,
      page: page ?? this.page,
      userId: userId != null ? userId() : this.userId,
      favourite: favourite ?? this.favourite,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'limit': limit,
      'page': page,
      'userId': userId,
      'favourite': favourite,
    };
  }

  factory FeedSearch.fromMap(Map<String, dynamic> map) {
    return FeedSearch(
      limit: map['limit']?.toInt() ?? 0,
      page: map['page']?.toInt() ?? 0,
      userId: map['userId']?.toInt(),
      favourite: map['favourite'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedSearch.fromJson(String source) =>
      FeedSearch.fromMap(json.decode(source));

  @override
  String toString() {
    return 'FeedSearch(limit: $limit, page: $page, userId: $userId, favourite: $favourite)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedSearch &&
        other.limit == limit &&
        other.page == page &&
        other.userId == userId &&
        other.favourite == favourite;
  }

  @override
  int get hashCode {
    return limit.hashCode ^
        page.hashCode ^
        userId.hashCode ^
        favourite.hashCode;
  }
}
