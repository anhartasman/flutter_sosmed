import 'dart:convert';

class LoginDemo {
  static String get username {
    return user.phone;
  }

  static String get password {
    return user.password;
  }

  static _UserDemo get user {
    return _UserDemo(phone: "08568654634", password: "654634");
    return _UserDemo(phone: "082231675079", password: "dkptulungagung");
    return _UserDemo(phone: "087786954808", password: "Amr1widi");
    return _UserDemo(phone: "08118696699", password: "696699");
    return _UserDemo(phone: "08568654634", password: "654634");
  }
}

class _UserDemo {
  final String phone;
  final String password;
  _UserDemo({
    required this.phone,
    required this.password,
  });

  _UserDemo copyWith({
    String? phone,
    String? password,
  }) {
    return _UserDemo(
      phone: phone ?? this.phone,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'phone': phone,
      'password': password,
    };
  }

  factory _UserDemo.fromMap(Map<String, dynamic> map) {
    return _UserDemo(
      phone: map['phone'] ?? '',
      password: map['password'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  factory _UserDemo.fromJson(String source) =>
      _UserDemo.fromMap(json.decode(source));

  @override
  String toString() => '_UserDemo(phone: $phone, password: $password)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is _UserDemo &&
        other.phone == phone &&
        other.password == password;
  }

  @override
  int get hashCode => phone.hashCode ^ password.hashCode;
}
