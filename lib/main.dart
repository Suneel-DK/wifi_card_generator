import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: WifiQRGenerator(),
  ));
}

class WifiQRGenerator extends StatefulWidget {
  const WifiQRGenerator({super.key});

  @override
  State<WifiQRGenerator> createState() => _WifiQRGeneratorState();
}

class _WifiQRGeneratorState extends State<WifiQRGenerator> {
  TextEditingController ssidController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  String encryption = "WPA"; 
  String qrData = "";

  void generateQR() {
    String ssid = ssidController.text;
    String password = passwordController.text;
    
    if (ssid.isNotEmpty) {
      setState(() {
        qrData = "WIFI:T:$encryption;S:$ssid;P:$password;;";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("WiFi QR Code Generator")),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: ssidController,
              decoration: InputDecoration(labelText: "WiFi Name (SSID)"),
            ),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: "Password"),
            ),
            DropdownButton<String>(
              value: encryption,
              onChanged: (String? newValue) {
                setState(() {
                  encryption = newValue!;
                });
              },
              items: ["WPA", "WEP", "nopass"]
                  .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                  .toList(),
            ),
            ElevatedButton(
              onPressed: generateQR,
              child: Text("Generate QR Code"),
            ),
            SizedBox(height: 20),
            qrData.isNotEmpty
                ? QrImageView(
                    data: qrData,
                    version: QrVersions.auto,
                    size: 200.0,
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
