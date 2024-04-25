// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/widgets.dart';

class FeedSearch {
  final int page;
  final int? userId;

  const FeedSearch({
    required this.page,
    this.userId,
  });

  FeedSearch copyWith({
    int? page,
    ValueGetter<int?>? userId,
  }) {
    return FeedSearch(
      page: page ?? this.page,
      userId: userId != null ? userId() : this.userId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'page': page,
      'userId': userId,
    };
  }

  factory FeedSearch.fromMap(Map<String, dynamic> map) {
    return FeedSearch(
      page: map['page']?.toInt() ?? 0,
      userId: map['userId']?.toInt(),
    );
  }

  String toJson() => json.encode(toMap());

  factory FeedSearch.fromJson(String source) =>
      FeedSearch.fromMap(json.decode(source));

  @override
  String toString() => 'FeedSearch(page: $page, userId: $userId)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is FeedSearch && other.page == page && other.userId == userId;
  }

  @override
  int get hashCode => page.hashCode ^ userId.hashCode;
}
