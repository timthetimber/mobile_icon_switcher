import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mobile_icon_switcher/mobile_icon_switcher.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key}) {
    MobileIconSwitcher.setDefaultComponent("com.example.example.MainActivity");
  }

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
            ElevatedButton(
              onPressed: () {
                resetAppIcon();
              },
              child: const Text("Reset Icon"),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> switchAppIcon(String name) async {
    try {
      await MobileIconSwitcher.changeIcon(name,
          'com.example.example.${name[0].toUpperCase()}${name.substring(1).toLowerCase()}');
    } on PlatformException catch (e) {
      print('Error while trying to switch the apps icon');
    }
  }

  Future<void> resetAppIcon() async {
    try {
      await MobileIconSwitcher.resetIcon();
    } on PlatformException catch (e) {
      print('Error while trying to reset the apps icon');
    }
  }
}
