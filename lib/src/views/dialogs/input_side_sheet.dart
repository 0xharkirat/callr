import 'dart:developer';

import 'package:callr/src/controllers/user_contact_controller.dart';
import 'package:callr/src/core/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class InputSideSheet extends ConsumerStatefulWidget {
  const InputSideSheet({super.key});

  @override
  ConsumerState<InputSideSheet> createState() => _InputSideSheetState();
}

class _InputSideSheetState extends ConsumerState<InputSideSheet> {
  final GlobalKey<ShadFormState> formKey = GlobalKey<ShadFormState>();

  

  @override
  Widget build(BuildContext context) {
    final userContact = ref.watch(userContactController).asData?.value;
    return SafeArea(
      child: ShadSheet(
        title: const Text('Create a QR Code'),
        description:
            const Text("Enter your Info here. Click save to generate QR code."),
        actions: [
          ShadButton(
            onPressed:  () {
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
                      Navigator.of(context).pop();

                      log('User contact updated: $name, $phone, $countryCode');
                    } else {
                      log('Validation failed');
                    }
                  }
                ,
            child: const Text('Save changes'),
          ),
        ],
        child: ShadForm(
          key: formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text("Name",
                          textAlign: TextAlign.start,
                          style: ShadTheme.of(context).textTheme.small),
                    ),
                    Expanded(
                      flex: 5,
                      child: ShadInputFormField(
                        autofocus: true,
                        
                        id: 'name',
                        placeholder: const Text('Enter your name'),
                        initialValue: userContact?.name,
                        keyboardType: TextInputType.text,
                        decoration: const ShadDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent),
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'Name is required.';
                          }
                          return null;
                        },
                        onEditingComplete: () {
                          formKey.currentState?.fields['phone']?.focus();
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Text("Phone Number",
                          textAlign: TextAlign.start,
                          style: ShadTheme.of(context).textTheme.small),
                    ),
                    Expanded(
                      flex: 5,
                      child: ShadInputFormField(
                        id: 'phone',
                        placeholder: const Text('Enter your phone number'),
                        initialValue: userContact?.phoneNumber,
                        keyboardType: TextInputType.phone,
                        decoration: const ShadDecoration(
                          errorStyle: TextStyle(color: Colors.redAccent),
                        ),
                        validator: (v) {
                          if (v.isEmpty) {
                            
                            return 'Phone Number is required.';
                            
                          }
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
