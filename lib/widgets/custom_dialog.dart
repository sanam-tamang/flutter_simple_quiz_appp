import 'package:flutter/material.dart';

void customDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        content: const Icon(
          Icons.warning,
          color: Colors.red,
          size: 50,
        ),
        title: const Text(
          "Answer must be selected !",
          style: TextStyle(color: Colors.red),
        ),
        actions: [
          ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Ok"),
              ))
        ],
      );
    },
  );
}
