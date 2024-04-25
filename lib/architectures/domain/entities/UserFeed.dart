// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserFeed {
  final int id;
  final int userId;
  final String name;
  final String pict;
  final String feedContent;
  final DateTime created;
  final bool isLiked;
  final List<String> tags;

  const UserFeed({
    required this.id,
    required this.userId,
    required this.name,
    required this.pict,
    required this.feedContent,
    required this.created,
    required this.isLiked,
    required this.tags,
  });

  UserFeed copyWith({
    int? id,
    int? userId,
    String? name,
    String? pict,
    String? feedContent,
    DateTime? created,
    bool? isLiked,
    List<String>? tags,
  }) {
    return UserFeed(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      name: name ?? this.name,
      pict: pict ?? this.pict,
      feedContent: feedContent ?? this.feedContent,
      created: created ?? this.created,
      isLiked: isLiked ?? this.isLiked,
      tags: tags ?? this.tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'userId': userId,
      'name': name,
      'pict': pict,
      'feedContent': feedContent,
      'created': created.millisecondsSinceEpoch,
      'isLiked': isLiked,
      'tags': tags,
    };
  }

  factory UserFeed.fromMap(Map<String, dynamic> map) {
    return UserFeed(
      id: map['id']?.toInt() ?? 0,
      userId: map['userId']?.toInt() ?? 0,
      name: map['name'] ?? '',
      pict: map['pict'] ?? '',
      feedContent: map['feedContent'] ?? '',
      created: DateTime.fromMillisecondsSinceEpoch(map['created']),
      isLiked: map['isLiked'] ?? false,
      tags: List<String>.from(map['tags']),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserFeed.fromJson(String source) =>
      UserFeed.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserFeed(id: $id, userId: $userId, name: $name, pict: $pict, feedContent: $feedContent, created: $created, isLiked: $isLiked, tags: $tags)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserFeed &&
        other.id == id &&
        other.userId == userId &&
        other.name == name &&
        other.pict == pict &&
        other.feedContent == feedContent &&
        other.created == created &&
        other.isLiked == isLiked &&
        listEquals(other.tags, tags);
  }

  @override
  int get hashCode {
    return id.hashCode ^
        userId.hashCode ^
        name.hashCode ^
        pict.hashCode ^
        feedContent.hashCode ^
        created.hashCode ^
        isLiked.hashCode ^
        tags.hashCode;
  }
}
