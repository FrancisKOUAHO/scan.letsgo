import 'dart:convert';
import 'dart:io' show Platform;

import 'dart:developer';
import 'dart:io';

import 'package:LetsGo_Scan/widgets/globals.dart' as globals;
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:http/http.dart' as http;

import '../../constants/url.dart';
import '../../database/db_provider.dart';

class ScannerScreen extends StatefulWidget {
  const ScannerScreen({Key? key}) : super(key: key);

  @override
  State<ScannerScreen> createState() => _ScannerScreenState();
}

class _ScannerScreenState extends State<ScannerScreen> {
  final DatabaseProvider? db = DatabaseProvider();
  final requestBaseUrl = AppUrl.baseUrl;
  Barcode? result;
  bool? valid;
  bool _qrCodeScanned = false;
  QRViewController? controller;
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');

  @override
  void initState() {
    super.initState();
    db!.getUser().then((value) => {
          if (value != null)
            {
              globals.userID = value['id'],
            }
        });
  }

  @override
  void reassemble() {
    super.reassemble();
    if (Platform.isAndroid) {
      controller!.pauseCamera();
    }
    controller!.resumeCamera();
  }

  Future validateQrCode(reservation) async {
    if (_qrCodeScanned) {
      print("1");
      return;
    } else {
      print("2");
      String url = '$requestBaseUrl/reservations/validateQrCode/$reservation';
      final response = await http.get(Uri.parse(url));
      final body = jsonDecode(response.body);
      valid = body['success'];
      setState(() {
        _qrCodeScanned = true;
      });
      print("_qrCodeScanned $_qrCodeScanned");
      print("3");
      return body;
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      this.controller = controller;
    });
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        validateQrCode(scanData.code);
        result = scanData;
        controller.pauseCamera();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
  }

  buildQRView(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 400 ||
            MediaQuery.of(context).size.height < 400)
        ? 300.0
        : 300.0;
    return QRView(
      key: qrKey,
      onQRViewCreated: _onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderColor: Colors.blue,
        borderRadius: 10,
        borderLength: 30,
        borderWidth: 10,
        cutOutSize: scanArea,
      ),
      onPermissionSet: (ctrl, p) => _onPermissionSet(context, ctrl, p),
    );
  }

  void _onPermissionSet(BuildContext context, QRViewController ctrl, bool p) {
    log('${DateTime.now().toIso8601String()}_onPermissionSet $p');
    if (!p) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('no Permission')),
      );
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  void _resetScanner() {
    controller?.resumeCamera();
    setState(() {
      _qrCodeScanned = false;
      result = null;
    });
  }

  buildResult() => Container(
      padding: const EdgeInsets.all(5),
      decoration: BoxDecoration(
        color: Colors.white24,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (_qrCodeScanned)
            valid == true
                ? Column(
                    children: const [
                      Icon(
                        Icons.check_circle,
                        color: Colors.green,
                        size: 45.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      SizedBox(height: 10),
                      Text(
                        'Valider',
                        style: TextStyle(fontSize: 15, color: Colors.green),
                        maxLines: 5,
                      ),
                    ],
                  )
                : Column(
                    children: const [
                      Icon(
                        Icons.cancel,
                        color: Colors.red,
                        size: 45.0,
                        semanticLabel:
                            'Text to announce in accessibility modes',
                      ),
                      SizedBox(height: 10),
                      Text(
                        'déja utilisé',
                        style: TextStyle(fontSize: 15, color: Colors.red),
                        maxLines: 5,
                      ),
                    ],
                  )
          else
            const Text('Scan a Qr code'),
        ],
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
                return Icon(snapshot.data != null
                    ? Icons.camera_front
                    : Icons.camera_rear);
              },
            ),
            onPressed: () => controller?.flipCamera(),
          ),
          if (_qrCodeScanned)
            IconButton(
              icon: const Icon(Icons.restart_alt_rounded),
              onPressed: () {
                _resetScanner();
              },
            ),
        ],
      ));
}
