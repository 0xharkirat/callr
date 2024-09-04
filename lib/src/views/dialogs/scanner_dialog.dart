import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:shadcn_ui/shadcn_ui.dart';
import 'package:url_launcher/url_launcher.dart';

class ScannerDialog extends ConsumerStatefulWidget {
  const ScannerDialog({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerDialogState();
}

class _ScannerDialogState extends ConsumerState<ScannerDialog> {
  
  String? code;

  void _handleBarcode(BarcodeCapture barcodes) {
    final barcode = barcodes.barcodes.firstOrNull;
    if (barcode != null && mounted) {
      setState(() {
        code = barcode.displayValue;
      });
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return ShadDialog(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: 16),
          if (code != null) ...[
            ShadButton.ghost(
              icon: const Icon(Icons.copy, color: Colors.black),
              onPressed: () {
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
                  icon: const Icon(Icons.phone, color: Colors.black),
                  child: const Text('Open Caller'),
                ),
                ShadButton(
                  onPressed: () async {
                    final url = 'sms:$code';
                    if (!await launchUrl(Uri.parse(url))) {
                      throw Exception('Could not launch $url');
                    }
                  },
                  icon: const Icon(Icons.sms, color: Colors.black),
                  child: const Text('Open SMS'),
                ),
              ],
            ),
            const SizedBox(height: 16),
          ],
          ShadButton(
            icon: const Icon(Icons.qr_code_scanner, color: Colors.black),
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return Scaffold(
                    appBar: AppBar(
                      title: const Text('Scan QR Code'),
                      backgroundColor: Colors.black,
                    ),
                    body: MobileScanner(
                      onDetect: _handleBarcode,
                    ),
                  );
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