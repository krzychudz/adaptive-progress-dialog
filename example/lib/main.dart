import 'package:adaptive_progress_dialog/adaptive_progress_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adaptive Progress Dialog Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Demo Home Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            ElevatedButton(
              onPressed: () async {
                await showProgressIndicatorDialog(
                  context,
                  title: 'Dialog title',
                  content:
                      'Do yuo want to perform async operation with progress dialog?',
                  actionButtonLabel: 'Yes',
                  cancelButtonLabel: 'No, close',
                  confirmButtonCallback: () async =>
                      await Future.delayed(const Duration(seconds: 5)),
                  cancelButtonCallback: () async {},
                );
              },
              child: Text("Show adaptive dialog"),
            )
          ],
        ),
      ),
    );
  }
}
