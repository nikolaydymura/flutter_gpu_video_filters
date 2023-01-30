// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages/filter_messages.g.dart',
    javaOut:
        'android/src/main/java/nd/flutter/plugins/gpu_video_filters/FilterMessages.java',
    javaOptions: JavaOptions(
      package: 'nd.flutter.plugins.gpu_video_filters',
    ),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
@HostApi()
abstract class FilterApi {
  int create(String fragmentShader);

  void setInputAsset(int filterId, String path);

  void setInputFile(int filterId, String path);

  void setFloatParameter(int filterId, String key, double value);

  void setFloatArrayParameter(int filterId, String key, List<double?> value);

  void setBitmapParameter(int filterId, String key, Uint8List data);

  void setBitmapSourceParameter(
    int filterId,
    String key,
    bool asset,
    String path,
  );

  void dispose(int filterId);
}
