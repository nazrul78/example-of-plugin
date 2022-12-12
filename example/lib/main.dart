import 'dart:developer';

import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:test_plugin/test_plugin.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _platformVersion = 'Unknown';
  List<String> nameList = [];
  final _testPlugin = TestPlugin();

  // @override
  // void initState() {
  //   super.initState();
  //   //  initPlatformState();
  // }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      platformVersion = await _testPlugin.getPlatformVersion();
      log('$platformVersion');
      // await _testPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  Future<void> getListOfName() async {
    List<String>? listOfName;
    // Platform messages may fail, so we use a try/catch PlatformException.
    // We also handle the message potentially returning null.
    try {
      listOfName = await _testPlugin.getListOfName();
      log('$listOfName');
      // await _testPlugin.getPlatformVersion() ?? 'Unknown platform version';
    } on PlatformException {
      log('Failed to get platform version.');
      // platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      nameList.addAll(listOfName!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Running on: $_platformVersion\n'),
              TextButton(
                  onPressed: () {
                    initPlatformState();
                  },
                  child: const Text('GET ANDROID VERSION')),
              const SizedBox(
                height: 20,
              ),
              if (nameList.isNotEmpty)
                ListView.builder(
                  shrinkWrap: true,
                  itemCount: nameList.length,
                  itemBuilder: (context, i) {
                    return ListTile(
                      title: Text(nameList[i]),
                    );
                  },
                ),
              const SizedBox(
                height: 20,
              ),
              TextButton(
                  onPressed: () {
                    getListOfName();
                  },
                  child: const Text('GET LIST OF NAME'))
            ],
          ),
        ),
      ),
    );
  }
}
