import 'dart:io' show Platform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  Barcode? result;
  QRViewController? controller;


  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller?.pauseCamera();
    }
    controller?.resumeCamera();
  }

  @override
  Widget build(BuildContext context) => SafeArea(
          child: Scaffold(
              body: Stack(
        alignment: Alignment.center,
        children: [
          buildQRView(context),
          Positioned(
            bottom: 10,
            child: buildResult(),
          ),
          Positioned(
            top: 10,
            child: buildControlButtons(),
          ),
        ],
      )));

  buildQRView(BuildContext context) => QRView(
      key: qrKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
          borderColor: Theme.of(context).accentColor,
          borderRadius: 10,
          borderLength: 20,
          borderWidth: 10,
          cutOutSize: MediaQuery.of(context).size.width * 0.8));

  void onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });

    controller.scannedDataStream.listen((scanData) {
      setState(() {
        controller.pauseCamera();
        Navigator.of(context).pop(scanData.code);
      });
    });
  }

  buildResult() => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(10),
    ),
      child: Text(
        result != null
            ? 'Barcode Type: ${describeEnum(result!.format)}   Data: ${result!.code}'
            : 'Scanner un code',
        style: const TextStyle(fontSize: 20),
        maxLines: 3,
      ));

  buildControlButtons() => Container(
    padding: const EdgeInsets.symmetric(horizontal: 12),
    decoration: BoxDecoration(
      color: Colors.white24,
      borderRadius: BorderRadius.circular(8),
    ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          IconButton(
            icon: FutureBuilder(
              future: controller?.getFlashStatus(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Icon(Icons.flash_off);
                }
                return Icon(snapshot.data! ? Icons.flash_on : Icons.flash_off);
              },
            ),
            onPressed: () => controller?.toggleFlash(),
          ),
          IconButton(
            icon: FutureBuilder(
              future: controller?.getCameraInfo(),
              builder: (context, snapshot) {
                if (snapshot.data == null) {
                  return const Icon(Icons.flip_camera_ios);
                }
                return Icon(snapshot.data != null ? Icons.camera_front : Icons.camera_rear);
              },
            ),
            onPressed: () => controller?.flipCamera(),
          ),
        ],
      ));
}
