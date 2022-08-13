









import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'dart:io';

class PurchasesPayment extends StatefulWidget {
  const PurchasesPayment({Key? key}) : super(key: key);

  @override
  _PurchasesPaymentState createState() => _PurchasesPaymentState();
}

class _PurchasesPaymentState extends State<PurchasesPayment> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  void reassemble() {
    super.reassemble();

    if (Platform.isAndroid) {
      controller!.pauseCamera();
    } else if (Platform.isIOS) {
      controller!.resumeCamera();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            flex: 5,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: (result != null)
                  ? Text(
                  "Barcode Type ${describeEnum(result!.format)} Data${result!.code}")
                  : Text("Scan a Code"),
            ),
          ),
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        result = scanData;
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}




//
// return Card(
// margin: EdgeInsets.all(10),
// child: Column(
// children: <Widget>[
// Container(
// height: 50,
// decoration: const BoxDecoration(
// color: Colors.blue,
// ),
// child: Center(
// child: Text(
// (transactionsList![index].startdate).toString(),
// ),
// ),
// ),
// Padding(
// padding: EdgeInsets.fromLTRB(10, 20, 10, 20),
// child: Text("Description : " +
// transactionsList![index].description),
// ),

// Padding(
//   padding: EdgeInsets.fromLTRB(10, 20, 0, 20),
//   child: Column(
//     children: <Row>[
//       Row(
//         children: <Widget>[
//           Text("Description : "),
//           Text(transactionsList![index].description),
//         ],
//       ),
//       Row(),
//     ],
//   )
// ),
// ],
// ),
// );
