import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class QRGenerateScreen extends StatefulWidget {
  const QRGenerateScreen({super.key});

  @override
  _QRGenerateScreenState createState() => _QRGenerateScreenState();
}

class _QRGenerateScreenState extends State<QRGenerateScreen> {
  final TextEditingController _controller = TextEditingController();
  String? _qrData;

  void _generateQR() {
    setState(() {
      _qrData = _controller.text.isNotEmpty ? _controller.text : null;
    });
  }

  void _shareQR() async {
    if (_qrData != null) {
      await Share.share('Check out this QR code: $_qrData');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generate a QR code first!')),
      );
    }
  }

  void _emailQR() async {
    if (_qrData != null) {
      final Uri emailUri = Uri(
        scheme: 'mailto',
        path: '',
        queryParameters: {
          'subject': 'QR Code from QR Genie',
          'body': 'Here is your QR code data: $_qrData'
        },
      );
      if (await canLaunchUrl(emailUri)) {
        await launchUrl(emailUri);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Could not launch email app.')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Generate a QR code first!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Generate QR Code'),
        backgroundColor: Colors.indigo,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text(
                  'Create Your QR Code',
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.indigo),
                ),
                const SizedBox(height: 16),
                TextField(
                  controller: _controller,
                  decoration: InputDecoration(
                    labelText: 'Enter text or URL',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    prefixIcon: const Icon(Icons.link),
                  ),
                  onSubmitted: (_) => _generateQR(),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: _generateQR,
                  child: const Text('Generate'),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                ),
                const SizedBox(height: 24),
                if (_qrData != null)
                  Column(
                    children: [
                      PrettyQrView.data(
                        data: _qrData!,
                        decoration: const PrettyQrDecoration(
                          shape: PrettyQrSmoothSymbol(color: Colors.indigo),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton.icon(
                            onPressed: _shareQR,
                            icon: const Icon(Icons.share),
                            label: const Text('Share'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                          ElevatedButton.icon(
                            onPressed: _emailQR,
                            icon: const Icon(Icons.email),
                            label: const Text('Email'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
