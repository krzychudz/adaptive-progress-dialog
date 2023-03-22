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

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String? dialogData;

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
            if (dialogData != null)
              Text(
                dialogData!,
                style: const TextStyle(fontSize: 26),
              ),
            const SizedBox(height: 64),
            ElevatedButton(
              onPressed: () async {
                final dialog = AdaptiveProgressDialog<String>(
                  title: 'Progress Dialog',
                  content: 'Do you want to perform async operation?',
                  confirmationButtonLabel: 'Yes',
                  cancelButtonLabel: 'No, close',
                  confirmButtonCallback: () async {
                    await Future.delayed(const Duration(seconds: 5));
                    return "Dialog Result Data";
                  },
                  adaptiveProgressDialogStyle: AdaptiveProgressDialogStyle(
                    confirmButtonTextStyle: const TextStyle(color: Colors.red),
                  ),
                );

                final adaptiveProgressDialogResult = await dialog.show(context);

                switch (adaptiveProgressDialogResult.status) {
                  case DialogStatus.success:
                    setState(() {
                      dialogData = adaptiveProgressDialogResult.data;
                    });
                    break;
                  case DialogStatus.canceled:
                    print("Dialog canceled by pressing on cancel button");
                    break;
                  case DialogStatus.error:
                    print(
                        "Dialog error: ${adaptiveProgressDialogResult.error}");
                    break;
                  case DialogStatus.closed:
                    print("Dialog canceled by pressing outside dialog");
                    break;
                }
              },
              child: const Text("Show adaptive dialog"),
            )
          ],
        ),
      ),
    );
  }
}
