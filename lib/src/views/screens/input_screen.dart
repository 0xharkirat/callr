import 'dart:developer';

import 'package:callr/src/controllers/user_contact_controller.dart';
import 'package:callr/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InputScreen extends ConsumerWidget {
  InputScreen({super.key});

  final GlobalKey<ShadFormState> formKey = GlobalKey<ShadFormState>();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: ShadForm(
          key: formKey,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 350),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                ShadInputFormField(
                  id: 'name',
                  label: const Text('Name'),
                  placeholder: const Text('Enter your name'),
                  keyboardType: TextInputType.text,
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Name is required.';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'phone',
                  label: const Text('Phone Number'),
                  placeholder: const Text('Enter your phone number'),
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    // No length validation, but you can add other validations if needed
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ShadInputFormField(
                  id: 'country_code',
                  label: const Text('Country Code'),
                  placeholder: const Text('Enter your country code'),
                  keyboardType: TextInputType.phone,
                  validator: (v) {
                    // Optional field, so no validation required
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                ShadButton(
                  child: const Text('Submit'),
                  onPressed: () {
                    if (formKey.currentState?.validate() ?? false) {
                      final name =
                          formKey.currentState!.fields['name']?.value ?? '';
                      final phone =
                          formKey.currentState!.fields['phone']?.value ?? '';
                      final countryCode =
                          formKey.currentState!.fields['country_code']?.value ??
                              '';

                      // Update the user contact using Riverpod
                      ref
                          .read(userContactController.notifier)
                          .updateUserContact(name, phone, countryCode);
                      context.goNamed(AppRoute.homeScreen.name);

                      log('User contact updated: $name, $phone, $countryCode');
                    } else {
                      log('Validation failed');
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
