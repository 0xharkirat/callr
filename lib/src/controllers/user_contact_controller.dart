import 'package:callr/src/models/user_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserContactController extends Notifier<UserContact?> {
  @override
  UserContact? build() {
    return null;
  }

  void updateUserContact(String name, String phoneNumber, String countryCode) {
    state = UserContact(
      name: name,
      phoneNumber: phoneNumber,
      countryCode: countryCode,
    );
  }

 
}

final userContactController = NotifierProvider<UserContactController, UserContact?>(() {
  return UserContactController();
});
