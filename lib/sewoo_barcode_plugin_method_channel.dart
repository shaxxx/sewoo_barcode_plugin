import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'sewoo_barcode_plugin_platform_interface.dart';

/// An implementation of [SewooBarcodePluginPlatform] that uses method channels.
class SewooBarcodePlugin extends SewooBarcodePluginPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('sewoo_barcode_plugin/methods');

  @visibleForTesting
  final EventChannel eventChannel = const EventChannel(
    'sewoo_barcode_plugin/events',
  );

  Stream<String>? _eventStream;

  @override
  Future<String?> getPlatformVersion() async {
    final String version = await methodChannel.invokeMethod(
      'getPlatformVersion',
    );
    return version;
  }

  @override
  Future<void> testBarcode() async {
    await methodChannel.invokeMethod('testBarcode');
  }

  @override
  Stream<String> get barcodeEventStream {
    _eventStream ??= eventChannel.receiveBroadcastStream().map<String>((value) {
      if (value["event"] == "barcode_scanned") {
        return value["barcode"];
      }
      throw UnimplementedError(value["event"]);
    });
    return _eventStream!;
  }
}
