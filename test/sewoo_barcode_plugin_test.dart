import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sewoo_barcode_plugin/sewoo_barcode_plugin.dart';

void main() {
  const MethodChannel channel = MethodChannel('sewoo_barcode_plugin');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await SewooBarcodePlugin().platformVersion, '42');
  });
}
