import 'package:flutter/material.dart';

class ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const ErrorView({required this.message, required this.onRetry, super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.error_outline, color: Colors.redAccent, size: 60),
            const SizedBox(height: 8),
            Text(
              '¡Something went wrong!',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.redAccent,
              ),
            ),
            const SizedBox(height: 5),
            Align(
              alignment: Alignment.centerLeft,
              child: Container(
                margin: const EdgeInsets.symmetric(vertical: 7, horizontal: 0),
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 238, 236, 236),
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Text(
                  message,
                  textAlign: TextAlign.left,
                  style: const TextStyle(fontSize: 15, color: Colors.black87),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
