import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';
import 'package:sewoo_barcode_plugin/sewoo_barcode_plugin_method_channel.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';
  final SewooBarcodePlugin _sewooBarcodePlugin = SewooBarcodePlugin();
  String _barcode = '';
  late StreamSubscription<String> _barcodeSubscription;

  @override
  void initState() {
    super.initState();
    initPlatformState();
    creatBarcodeListener();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    String? platformVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      platformVersion = await SewooBarcodePlugin().getPlatformVersion();
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion ?? 'Unknown';
    });
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> creatBarcodeListener() async {
    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _barcodeSubscription = _sewooBarcodePlugin.barcodeEventStream.listen((
        String barcode,
      ) async {
        setState(() {
          _barcode = barcode;
          print(_barcode);
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(title: const Text('Plugin example app')),
        body: Center(
          child: _barcode.isEmpty
              ? Text('Running on: $_platformVersion\n')
              : Text("Barcode scanned $_barcode"),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _barcodeSubscription.cancel();
  }
}
