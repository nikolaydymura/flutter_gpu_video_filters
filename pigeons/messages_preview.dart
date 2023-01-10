// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages/preview_messages.g.dart',
  javaOut:
      'android/src/main/java/nd/flutter/plugins/gpu_video_filters/PreviewMessages.java',
  javaOptions: JavaOptions(
    package: 'nd.flutter.plugins.gpu_video_filters',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
))
class BindPreviewMessage {
  BindPreviewMessage(this.textureId, this.filterId);

  int textureId;
  int filterId;
}

class SourcePreviewMessage {
  SourcePreviewMessage(this.textureId, this.path, this.asset);

  int textureId;
  String path;
  bool asset;
}

class PreviewMessage {
  PreviewMessage(this.textureId);

  int textureId;
}

@HostApi()
abstract class VideoPreviewApi {
  PreviewMessage create();

  void connect(BindPreviewMessage msg);

  void disconnect(PreviewMessage msg);

  void setSource(SourcePreviewMessage msg);

  void resume(PreviewMessage msg);

  void pause(PreviewMessage msg);

  void dispose(PreviewMessage msg);
}
