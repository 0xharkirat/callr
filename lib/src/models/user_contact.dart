class UserContact {
  final String name;
  final String phoneNumber;

  UserContact({
    required this.name,
    required this.phoneNumber,
  });

  @override
  String toString() {
    return 'UserContact(name: $name, phoneNumber: $phoneNumber)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserContact &&
        other.name == name &&
        other.phoneNumber == phoneNumber;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phoneNumber.hashCode;
  }

  UserContact copyWith({
    String? name,
    String? phoneNumber,
    String? countryCode,
  }) {
    return UserContact(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
    };
  }

  factory UserContact.fromMap(Map<String, dynamic> map) {
    return UserContact(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
    );
  }
}
