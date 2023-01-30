// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(
  PigeonOptions(
    dartOut: 'lib/src/messages/preview_messages.g.dart',
    javaOut:
        'android/src/main/java/nd/flutter/plugins/gpu_video_filters/PreviewMessages.java',
    javaOptions: JavaOptions(
      package: 'nd.flutter.plugins.gpu_video_filters',
    ),
    copyrightHeader: 'pigeons/copyright.txt',
  ),
)
class SourcePreviewMessage {
  SourcePreviewMessage(this.textureId, this.path, this.asset);

  int textureId;
  String path;
  bool asset;
}

@HostApi()
abstract class VideoPreviewApi {
  int create();

  void connect(int textureId, int filterId);

  void disconnect(int textureId);

  void setSource(SourcePreviewMessage msg);

  void resume(int textureId);

  void pause(int textureId);

  void dispose(int textureId);
}
