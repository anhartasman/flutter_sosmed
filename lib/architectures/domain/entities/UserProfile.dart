import 'dart:convert';

class UserProfile {
  final int id;
  final String name;
  final String profilePict;
  final String coverPict;
  const UserProfile({
    required this.id,
    required this.name,
    required this.profilePict,
    required this.coverPict,
  });

  UserProfile copyWith({
    int? id,
    String? name,
    String? profilePict,
    String? coverPict,
  }) {
    return UserProfile(
      id: id ?? this.id,
      name: name ?? this.name,
      profilePict: profilePict ?? this.profilePict,
      coverPict: coverPict ?? this.coverPict,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'profilePict': profilePict,
      'coverPict': coverPict,
    };
  }

  factory UserProfile.fromMap(Map<String, dynamic> map) {
    return UserProfile(
      id: map['id']?.toInt() ?? 0,
      name: map['name'] ?? '',
      profilePict: map['profilePict'] ?? '',
      coverPict: map['coverPict'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory UserProfile.fromJson(String source) =>
      UserProfile.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserProfile(id: $id, name: $name, profilePict: $profilePict, coverPict: $coverPict)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserProfile &&
        other.id == id &&
        other.name == name &&
        other.profilePict == profilePict &&
        other.coverPict == coverPict;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        profilePict.hashCode ^
        coverPict.hashCode;
  }
}
