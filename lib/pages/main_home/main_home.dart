import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:how_many_i_spend/pages/dialogs/scan_code/scan_code_dialog.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:http/http.dart' as http;

class MainHome extends StatelessWidget {
  const MainHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Total gasto hoje",
          style: TextStyle(color: Colors.grey),
        ),

        Text(
          'R\$ 150,00',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 26.0,
          ),
        ),

        Container(
          margin: const EdgeInsets.symmetric(horizontal: 22.0),
          child: RawMaterialButton(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
            fillColor: Colors.blueGrey,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  MdiIcons.qrcode,
                  color: Theme.of(context).primaryColor,
                ),
                const SizedBox(width: 12),
                Text(
                  "Escanear nota",
                  style: TextStyle(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ],
            ),
            onPressed: () => openScanner(context),
          ),
        ),

        TextButton(
          onPressed: () {},
          child: Text('Adicionar gastos'),
        ),
      ],
    );
  }


  openScanner(BuildContext context) {
    showDialog(
      context: context,
      builder: (_) => const ScanCodeDialog(),
    );
  }


  teste(String v) async {
    final response = await http.post(
      Uri.parse("http://192.168.0.15:3000/api/nfce"),
      body: jsonEncode({"url": v}),
      headers: {"Content-Type": "application/json"},
    );
  }
}
