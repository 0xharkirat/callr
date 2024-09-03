import 'dart:async';

import 'package:callr/src/models/user_contact.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserContactController extends AsyncNotifier<UserContact?> {
  @override
  Future<UserContact?> build() async {
    await Future.delayed(const Duration(seconds: 3));
    return await _loadUserContact();
  }

  // Method to update user contact details and save to local storage
  Future<void> updateUserContact(
      String name, String phoneNumber, String countryCode) async {
    final userContact = UserContact(
      name: name,
      phoneNumber: phoneNumber,
    );

    state = AsyncData(userContact);
    await _saveUserContact(userContact);
  }

  // Load user contact from local storage
  Future<UserContact?> _loadUserContact() async {
    final prefs = await SharedPreferences.getInstance();
    final name = prefs.getString('name');
    final phoneNumber = prefs.getString('phoneNumber');

    if (name != null && phoneNumber != null) {
      return UserContact(
        name: name,
        phoneNumber: phoneNumber,
      );
    }
    return null;
  }

  // Save user contact to local storage
  Future<void> _saveUserContact(UserContact userContact) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', userContact.name);
    await prefs.setString('phoneNumber', userContact.phoneNumber);
  }

  // Method to clear user contact details
  Future<void> clearUserContact() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('name');
    await prefs.remove('phoneNumber');
    state = const AsyncData(null);
  }

  // Method to check if user contact exists
  bool get hasUserContact => state.value != null;
}

final userContactController =
    AsyncNotifierProvider<UserContactController, UserContact?>(
  () => UserContactController(),
);
