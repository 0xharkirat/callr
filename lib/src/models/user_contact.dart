class UserContact {

  final String name;
  final String phoneNumber;
  final String? countryCode;

  UserContact({
    required this.name,
    required this.phoneNumber,
    this.countryCode,
  });

  @override
  String toString() {
    return 'UserContact(name: $name, phoneNumber: $phoneNumber, countryCode: $countryCode)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is UserContact &&
      other.name == name &&
      other.phoneNumber == phoneNumber &&
      other.countryCode == countryCode;
  }

  @override
  int get hashCode {
    return name.hashCode ^ phoneNumber.hashCode ^ countryCode.hashCode;
  }

  UserContact copyWith({
    String? name,
    String? phoneNumber,
    String? countryCode,
  }) {
    return UserContact(
      name: name ?? this.name,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      countryCode: countryCode ?? this.countryCode,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'countryCode': countryCode,
    };
  }

  factory UserContact.fromMap(Map<String, dynamic> map) {
    return UserContact(
      name: map['name'],
      phoneNumber: map['phoneNumber'],
      countryCode: map['countryCode'] ,
    );
  }
}