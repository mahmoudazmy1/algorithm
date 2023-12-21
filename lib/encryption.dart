import 'package:algorithm/main.dart';
import 'package:flutter/material.dart';

class encryption extends StatelessWidget {
  const encryption({super.key});

  static const String routeName = 'incryption';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Affine Encryption Example'),
      ),
      body: Center(
        child: AffineEncryptionWidget(),
      ),
    );
  }
}

class AffineEncryptionWidget extends StatefulWidget {
  @override
  _AffineEncryptionWidgetState createState() => _AffineEncryptionWidgetState();
}

class _AffineEncryptionWidgetState extends State<AffineEncryptionWidget> {
  TextEditingController _inputController = TextEditingController();
  String _encryptedText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _inputController,
            decoration: InputDecoration(labelText: 'Enter a word to encrypt'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String inputText = _inputController.text.toUpperCase();
              if (inputText.isNotEmpty) {
                // Use arbitrary keys for demonstration, you might want to handle key input differently.
                int a = 5; // Key 'a'
                int b = 8; // Key 'b'
                String encryptedText = encrypt(inputText, a, b);
                setState(() {
                  _encryptedText = encryptedText;
                });
              }
            },
            child: Text('Encrypt'),
          ),
          SizedBox(height: 20),
          Text(
            'Encrypted Text: $_encryptedText',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String encrypt(String plaintext, int a, int b) {
    StringBuffer ciphertext = StringBuffer();
    final int m = 26; // Size of the English alphabet
    for (int i = 0; i < plaintext.length; i++) {
      if (plaintext[i] != ' ') {
        int charIndex = (plaintext.codeUnitAt(i) - 'A'.codeUnitAt(0));
        int encryptedChar = (a * charIndex + b) % m;
        ciphertext
            .write(String.fromCharCode(encryptedChar + 'A'.codeUnitAt(0)));
      } else {
        ciphertext.write(' ');
      }
    }
    return ciphertext.toString();
  }
}
