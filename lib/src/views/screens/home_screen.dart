import 'package:callr/src/views/dialogs/input_side_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:callr/src/controllers/user_contact_controller.dart';
import 'package:shadcn_ui/shadcn_ui.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userContactAsync = ref.watch(userContactController);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: ShadTheme.of(context).colorScheme.secondary,
        centerTitle: true,
        title: RichText(
          text: TextSpan(
            text: 'Qall',
            style: ShadTheme.of(context).textTheme.h2,
            children: [
              TextSpan(
                text: 'R',
                style: ShadTheme.of(context).textTheme.h2.copyWith(
                      color: Colors.blueAccent,
                    ),
              ),
            ],
          ),
        ),
        actions: [
          if (userContactAsync.asData?.value != null) ...[
            IconButton(
              icon: const Icon(Icons.edit_square),
              onPressed: () => openSideSheet(context),
            ),
            IconButton(
                onPressed: () {
                  ref.read(userContactController.notifier).clearUserContact();
                },
                icon: const Icon(Icons.delete_outline, color: Colors.red)),
          ]
        ],
      ),
      body: Center(
        child: userContactAsync.when(
          data: (userContact) {
            return userContact != null
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: QrImageView(
                      data: userContact.phoneNumber,
                      version: QrVersions.auto,
                      size: 200.0,
                    ),
                  )
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text("You haven't set up your QR code yet.",
                          style: ShadTheme.of(context).textTheme.h3),
                      const SizedBox(height: 24),
                      ShadButton(
                        onPressed: () => openSideSheet(context),
                        backgroundColor: Colors.lightBlueAccent,
                        icon: const Icon(Icons.qr_code),
                        child: const Text(
                          'Create a QR Code',
                          style: TextStyle(fontSize: 16),
                        ),
                      ),
                    ],
                  );
          },
          error: (error, stack) => Center(
            child: Text('An error occurred: $error'),
          ),
          loading: () => const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }

  Future<void> openSideSheet(BuildContext context) {
    return showShadSheet(
      context: context,
      builder: (context) => InputSideSheet(),
    );
  }
}
