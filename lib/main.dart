import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Affine Encryption/Decryption Example'),
        ),
        body: Center(
          child: AffineEncryptionWidget(),
        ),
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
  String _decryptedText = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            controller: _inputController,
            decoration:
                InputDecoration(labelText: 'Enter a word to encrypt/decrypt'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              String inputText = _inputController.text.toUpperCase();
              if (inputText.isNotEmpty) {
                // Use arbitrary keys for demonstration, you might want to handle key input differently.
                int a = 5; // Key 'a'
                int b = 8; // Key 'b'

                // Encrypt
                String encryptedText = encrypt(inputText, a, b);

                // Decrypt
                String decryptedText = decrypt(encryptedText, a, b);

                setState(() {
                  _encryptedText = encryptedText;
                  _decryptedText = decryptedText;
                });
              }
            },
            child: Text('Encrypt/Decrypt'),
          ),
          SizedBox(height: 20),
          Text(
            'Encrypted Text: $_encryptedText',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(height: 10),
          Text(
            'Decrypted Text: $_decryptedText',
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

  String decrypt(String ciphertext, int a, int b) {
    StringBuffer decryptedText = StringBuffer();
    final int m = 26; // Size of the English alphabet

    int aInverse = modInverse(a, m);

    for (int i = 0; i < ciphertext.length; i++) {
      if (ciphertext[i] != ' ') {
        int charIndex = (ciphertext.codeUnitAt(i) - 'A'.codeUnitAt(0));
        int decryptedChar = (aInverse * (charIndex - b + m)) % m;
        decryptedText
            .write(String.fromCharCode(decryptedChar + 'A'.codeUnitAt(0)));
      } else {
        decryptedText.write(' ');
      }
    }

    return decryptedText.toString();
  }

  int modInverse(int a, int m) {
    for (int i = 1; i < m; i++) {
      if ((a * i) % m == 1) {
        return i;
      }
    }
    return -1; // Inverse does not exist
  }
}
