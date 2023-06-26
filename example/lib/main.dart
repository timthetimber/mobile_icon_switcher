import 'package:app_icon_switcher/app_icon_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Icon Switcher Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Change the Apps Icon:',
            ),
            ElevatedButton(
              onPressed: () {
                switchAppIcon("first");
              },
              child: const Text("First Icon"),
            ),
            ElevatedButton(
              onPressed: () {
                switchAppIcon("second");
              },
              child: const Text("Second Icon"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> switchAppIcon(String name) async {
    try {
      await AppIconSwitcher.changeIcon(name);
    } on PlatformException catch (e) {
      print('Error while trying to switch the apps icon');
    }
  }
}
