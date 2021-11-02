import 'package:flutter/material.dart';

class ConfirmDialog extends StatelessWidget {
  const ConfirmDialog({
    Key? key,
    this.message = 'Are you sure?',
    this.yesButton = 'Yes',
    this.noButton = 'No',
  }) : super(key: key);

  final String message;
  final String yesButton;
  final String noButton;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        width: 300,
        height: 100,
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            Text(message),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                  child: Text(noButton),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop(true);
                  },
                  child: Text(yesButton),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
