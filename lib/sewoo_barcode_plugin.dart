import 'dart:async';

import 'package:flutter/services.dart';

class SewooBarcodePlugin {
  /// Initializes the plugin and starts listening for potential platform events.
  factory SewooBarcodePlugin() {
    if (_instance == null) {
      final MethodChannel methodChannel =
          const MethodChannel('sewoo_barcode_plugin/methods');
      final EventChannel eventChannel =
          const EventChannel('sewoo_barcode_plugin/events');
      _instance = SewooBarcodePlugin.private(methodChannel, eventChannel);
    }
    return _instance;
  }

  SewooBarcodePlugin.private(this._methodChannel, this._eventChannel);

  static SewooBarcodePlugin _instance;
  final MethodChannel _methodChannel;
  final EventChannel _eventChannel;
  Stream<String> _eventStream;

  Stream<String> get barcodeEventStream {
    if (_eventStream == null) {
      _eventStream =
          _eventChannel.receiveBroadcastStream().map<String>((value) {
        if (value["event"] == "barcode_scanned") {
          return value["barcode"];
        }
        throw UnimplementedError(value["event"]);
      });
    }
    return _eventStream;
  }

  Future<String> get platformVersion async {
    final String version =
        await _methodChannel.invokeMethod('getPlatformVersion');
    return version;
  }
}
