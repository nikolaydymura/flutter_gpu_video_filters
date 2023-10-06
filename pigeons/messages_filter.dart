// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages/filter_messages.g.dart',
    kotlinOut:
        'android/src/main/kotlin/nd/flutter/plugins/gpu_video_filters/FilterMessages.g.kt',
    kotlinOptions: KotlinOptions(package: 'nd.flutter.plugins.gpu_video_filters'),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
@HostApi()
abstract class FilterApi {
  int create(
    String vertexShader,
    String fragmentShader,
    Map<String, double> defaults,
    Map<String, Float64List> arrays,
    String? texture,
  );

  int exportVideoFile(
    int filterId,
    bool asset,
    String input,
    String output,
    String format,
    int period,
  );

  void setFloatParameter(int filterId, String key, double value);

  void setFloatArrayParameter(int filterId, String key, Float64List value);

  void setBitmapParameter(int filterId, String key, Uint8List data);

  void setBitmapSourceParameter(
    int filterId,
    String key,
    bool asset,
    String path,
  );

  void dispose(int filterId);
}

@HostApi()
abstract class VideoPreviewApi {
  int create();

  void connect(int textureId, int filterId, bool embedded);

  void disconnect(int textureId, bool embedded);

  void setSource(int textureId, String path, bool asset, bool embedded);

  void resume(int textureId, bool embedded);

  void pause(int textureId, bool embedded);

  void dispose(int textureId, bool embedded);
}
