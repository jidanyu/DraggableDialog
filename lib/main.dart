import 'package:drag_window/draggable_dialog.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'DraggableDialog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'DraggableDialog'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: Center(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                showGeneralDialog(
                  context: context,
                  pageBuilder: (BuildContext buildContext,
                      Animation<double> animation,
                      Animation<double> secondaryAnimation) {
                    return DraggableDialog(
                        context: context,
                        onClose: () {
                          Navigator.of(context).pop();
                        });
                  },
                );
              },
              child: const Text('Show DraggableDialog'),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
