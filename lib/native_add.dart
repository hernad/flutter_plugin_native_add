import 'dart:async';
import 'dart:ffi'; // For FFI
import 'dart:io'; // For Platform.isX

import 'package:flutter/services.dart';

final DynamicLibrary nativeAddLib = Platform.isAndroid
    ? DynamicLibrary.open("libnative_add.so")
    : DynamicLibrary.process();

class NativeAdd {
  static const MethodChannel _channel = const MethodChannel('native_add');

  static Future<String?> get platformVersion async {
    final String? version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  //final int Function(int x, int y) nativeAdd = nativeAddLib
  //    .lookup<NativeFunction<Int32 Function(Int32, Int32)>>("native_add")
  //    .asFunction();

  static Future<int?> myadd(int x, int y) async {
    final int? sum =
        await _channel.invokeMethod('native_add', <String, dynamic>{
      'x': x,
      'y': y,
    });
    return sum;
  }

  //static Future<void> play(Song song, double volume) async {
  //  // Errors occurring on the platform side cause invokeMethod to throw
  //  // PlatformExceptions.
  //  try {
  //    return _channel.invokeMethod('play', <String, dynamic>{
  //      'song': song.id,
  //      'volume': volume,
  //    });
  //  } on PlatformException catch (e) {
  //    throw 'Unable to play ${song.title}: ${e.message}';
  //  }
  //}
}
