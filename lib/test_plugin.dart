import 'package:flutter/services.dart';

class TestPlugin {
  final methodChannel = const MethodChannel('test_plugin');

  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  Future<List<String>?> getListOfName() async {
    final list = (await methodChannel.invokeMethod<List>('GET_LIST_OF_NAME'))!
        .cast<String>();

    // var list = ['abc', 'def', 'ghi'];
    return list;
  }
}
