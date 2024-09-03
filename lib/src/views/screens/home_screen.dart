import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:callr/src/controllers/user_contact_controller.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userContact = ref.watch(userContactController);

    return Scaffold(
      appBar: AppBar(
        title: const Text('CallR'),
      ),
      body: Center(
        child: userContact?.phoneNumber != null
            ? Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: QrImageView(
                  data: userContact!.phoneNumber,
                  version: QrVersions.auto,
                  size: 200.0,
                ),
              )
            : const Text('No phone number available'),
      ),
    );
  }
}
