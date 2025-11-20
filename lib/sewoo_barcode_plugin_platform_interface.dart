import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'sewoo_barcode_plugin_method_channel.dart';

abstract class SewooBarcodePluginPlatform extends PlatformInterface {
  /// Constructs a SewooBarcodePluginPlatform.
  SewooBarcodePluginPlatform() : super(token: _token);

  static final Object _token = Object();

  static SewooBarcodePluginPlatform _instance = SewooBarcodePlugin();

  /// The default instance of [SewooBarcodePluginPlatform] to use.
  ///
  /// Defaults to [SewooBarcodePlugin].
  static SewooBarcodePluginPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [SewooBarcodePluginPlatform] when
  /// they register themselves.
  static set instance(SewooBarcodePluginPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<void> testBarcode() {
    throw UnimplementedError('testBarcode() has not been implemented.');
  }

  Stream<String> get barcodeEventStream {
    throw UnimplementedError('barcodeEventStream has not been implemented.');
  }
}
