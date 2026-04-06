import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class ScanCodeDialog extends StatelessWidget {
  const ScanCodeDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Column(
        children: [
          SizedBox(
            height: 250,
            child: MobileScanner(
              onDetect: (capture) {
                final barcode = capture.barcodes.first;
                final String? value = barcode.rawValue;

                if (value != null) {
                  teste(value);
                  print("QR Lido: $value");
                }
              },

            ),
          ),
        ],
      ),
    );
  }

  teste(String v) async {
    // final response = await http.post(
    //   Uri.parse("http://192.168.0.15:3000/api/nfce"),
    //   body: jsonEncode({"url": v}),
    //   headers: {"Content-Type": "application/json"},
    // );
  }
}
