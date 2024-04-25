// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';

class HomeNavBlocState extends Equatable {
  final int menuActive;
  final bool openDrawer;
  const HomeNavBlocState({
    this.menuActive = -1,
    this.openDrawer = false,
  });

  HomeNavBlocState copyWith({
    int? menuActive,
    bool? openDrawer,
  }) {
    return HomeNavBlocState(
      menuActive: menuActive ?? this.menuActive,
      openDrawer: openDrawer ?? this.openDrawer,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'menuActive': menuActive,
      'openDrawer': openDrawer,
    };
  }

  factory HomeNavBlocState.fromMap(Map<String, dynamic> map) {
    return HomeNavBlocState(
      menuActive: map['menuActive'] as int,
      openDrawer: map['openDrawer'] as bool,
    );
  }

  String toJson() => json.encode(toMap());

  factory HomeNavBlocState.fromJson(String source) =>
      HomeNavBlocState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;

  @override
  List<Object> get props => [menuActive, openDrawer];
}
