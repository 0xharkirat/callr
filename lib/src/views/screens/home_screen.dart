import 'package:callr/src/views/dialogs/input_side_sheet.dart';
import 'package:callr/src/views/dialogs/scanner_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:callr/src/controllers/user_contact_controller.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

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
          IconButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              showShadDialog(
                context: context,
                builder: (context) => const ScannerDialog(),
              );
            },
          ),
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
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
                child: Center(
                  child: userContactAsync.when(
                    data: (userContact) {
                      return userContact != null
                          ? Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                RichText(
                                  textAlign: TextAlign.center,
                                  text: TextSpan(
                                    text: 'Hello, my name is ',
                                    style: ShadTheme.of(context).textTheme.h1,
                                    children: [
                                      TextSpan(
                                        text: "${userContact.name}.",
                                        style: ShadTheme.of(context)
                                            .textTheme
                                            .h1
                                            .copyWith(color: Colors.blueAccent),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 24),
                                ShadTooltip(
                                  anchor: ShadAnchor.center,
                                  builder: (BuildContext context) {
                                    return Text(userContactAsync
                                            .asData?.value?.phoneNumber ??
                                        '', style: ShadTheme.of(context).textTheme.h4);
                                  },
                                  child: Container(
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
                                  ),
                                ),
                              ],
                            )
                          : Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  "You haven't set up your QR code yet.",
                                  style: ShadTheme.of(context).textTheme.h3,
                                  textAlign: TextAlign.center,
                                ),
                                const SizedBox(height: 24),
                                ShadButton(
                                  applyIconColorFilter: true,
                                  onPressed: () => openSideSheet(context),
                                  backgroundColor: Colors.lightBlueAccent,
                                  icon: const Icon(Icons.qr_code,
                                      color: Colors.black),
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
                      child: CircularProgressIndicator.adaptive(),
                    ),
                  ),
                ),
              ),
            ),
            Divider(
              color: Colors.white,
              thickness: 0.5,
            ),
            GestureDetector(
              onTap: () async {
                const url =
                    'https://github.com/0xharkirat'; // Replace with your GitHub URL
                if (await canLaunchUrl(Uri.parse(url))) {
                  await launchUrl(Uri.parse(url));
                } else {
                  throw 'Could not launch $url';
                }
              },
              child: RichText(
                text: TextSpan(
                  text: 'Made by ',
                  style: ShadTheme.of(context).textTheme.p,
                  children: [
                    TextSpan(
                      text: 'Hark',
                      style: ShadTheme.of(context)
                          .textTheme
                          .blockquote
                          .copyWith(
                              color: Colors.lightBlueAccent,
                              decoration: TextDecoration.underline),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> openSideSheet(BuildContext context) {
    return showShadSheet(
      context: context,
      builder: (context) => const InputSideSheet(),
    );
  }
}
