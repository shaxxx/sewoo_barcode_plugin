import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sewoo_barcode_plugin/sewoo_barcode_plugin_method_channel.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  SewooBarcodePlugin platform = SewooBarcodePlugin();
  const MethodChannel channel = MethodChannel('sewoo_barcode_plugin/methods');

  setUp(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, (MethodCall methodCall) async {
          if (methodCall.method == '') return 21;
          return '42';
        });
  });

  tearDown(() {
    TestDefaultBinaryMessengerBinding.instance.defaultBinaryMessenger
        .setMockMethodCallHandler(channel, null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
