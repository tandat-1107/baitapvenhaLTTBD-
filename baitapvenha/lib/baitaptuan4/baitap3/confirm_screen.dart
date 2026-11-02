import 'package:flutter/material.dart';

class ConfirmScreen extends StatelessWidget {
  final String email;
  final String otp;
  final String password;

  const ConfirmScreen({
    super.key,
    required this.email,
    required this.otp,
    required this.password,
  });

  void submit(BuildContext context) {
    Navigator.pop(
      context,
      {
        'email': email,
        'otp': otp,
        'password': password,
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),

      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            const SizedBox(height: 40),

            const Icon(
              Icons.task_alt,
              size: 65,
              color: Colors.blue,
            ),

            const SizedBox(height: 10),

            const Text(
              'SmartTasks',
              style: TextStyle(
                color: Colors.blue,
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),

            const SizedBox(height: 35),

            const Text(
              'Confirm',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              'We are here to help you.',
              style: TextStyle(
                color: Colors.grey,
              ),
            ),

            const SizedBox(height: 25),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: email,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.email_outlined),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              readOnly: true,
              controller: TextEditingController(
                text: otp,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.numbers),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 12),

            TextField(
              readOnly: true,
              obscureText: true,
              controller: TextEditingController(
                text: password,
              ),
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.lock_outline),
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => submit(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Submit'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}