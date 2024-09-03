import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_bar_code_scanner_dialog/qr_bar_code_scanner_dialog.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerDialog extends ConsumerStatefulWidget {
  const ScannerDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerDialogState();
}

class _ScannerDialogState extends ConsumerState<ScannerDialog> {
  final _qrBarCodeScannerDialogPlugin = QrBarCodeScannerDialog();
  String? code;

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          if (code != null) ...[
            ShadButton.ghost(
              icon: const Icon(Icons.copy),
              onPressed: () {
               

                ShadToaster.of(context).show(
                  const ShadToast(
                    description: Text('Long press to copy the number.'),
                  ),
                );
              },
              onLongPress: () {
                // Copy the code to the clipboard
                Clipboard.setData(ClipboardData(text: code!));
                ShadToaster.of(context).show(
                  const ShadToast(
                    description: Text('Your number is copied.'),
                  ),
                );
              },
              child: Text(
                'Scanned Number: $code',
                style: ShadTheme.of(context).textTheme.blockquote,
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ShadButton(
                  onPressed: () async {
                    final url = 'tel:$code';
                    if (!await launchUrl(Uri.parse(url))) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  icon: const Icon(Icons.phone),
                  child: const Text('Open Caller'),
                ),
                ShadButton(
                  onPressed: () async {
                    final url = 'sms:$code';
                    if (!await launchUrl(Uri.parse(url))) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  icon: const Icon(Icons.sms),
                  child: const Text('Open SMS'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          ShadButton(
            icon: const Icon(Icons.qr_code_scanner),
            onPressed: () {
              _qrBarCodeScannerDialogPlugin.getScannedQrBarCode(
                context: context,
                onCode: (String? scannedCode) {
                  setState(() {
                    code = scannedCode;
                  });
                },
              );
            },
            child: const Text('Scan QR Code'),
          ),
        ],
      ),
    );
  }
}
