import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QRScanScreen extends StatefulWidget {
  const QRScanScreen({super.key});

  @override
  _QRScanScreenState createState() => _QRScanScreenState();
}

class _QRScanScreenState extends State<QRScanScreen> {
  String? _scannedData;
  MobileScannerController controller = MobileScannerController();

  void _handleScan(BarcodeCapture capture) {
    final List<Barcode> barcodes = capture.barcodes;
    if (barcodes.isNotEmpty) {
      setState(() {
        _scannedData = barcodes.first.rawValue;
        controller.stop();
      });
    }
  }

  void _shareData() async {
    if (_scannedData != null) {
      await Share.share('Scanned QR code: $_scannedData');
    }
  }

  void _emailData() async {
    if (_scannedData != null) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: '',
        queryParameters: {'subject': 'Scanned QR Code', 'body': 'Scanned data: $_scannedData'},
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email app.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Scan QR Code'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Scan a QR Code',
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.indigo),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: MobileScanner(
                      controller: controller,
                      onDetect: _handleScan,
                      errorBuilder: (context, error, child) {
                        return const Center(child: Text('Camera error. Please try again.'));
                      },
                    ),
                  ),
                ),
                if (_scannedData != null) ...[
                  const SizedBox(height: 16),
                  Card(
                    color: Colors.indigo[50],
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Scanned: $_scannedData',
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: _shareData,
                        icon: const Icon(Icons.share),
                        label: const Text('Share'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: _emailData,
                        icon: const Icon(Icons.email),
                        label: const Text('Email'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  OutlinedButton(
                    onPressed: () {
                      setState(() {
                        _scannedData = null;
                        controller.start();
                      });
                    },
                    child: const Text('Scan Again'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Colors.indigo),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}