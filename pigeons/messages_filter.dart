// Copyright 2013 The Flutter Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:pigeon/pigeon.dart';

@ConfigurePigeon(PigeonOptions(
  dartOut: 'lib/src/messages/filter_messages.g.dart',
  javaOut:
      'android/src/main/java/nd/flutter/plugins/gpu_video_filters/FilterMessages.java',
  javaOptions: JavaOptions(
    package: 'nd.flutter.plugins.gpu_video_filters',
  ),
  copyrightHeader: 'pigeons/copyright.txt',
))
class CreateFilterMessage {
  CreateFilterMessage(this.fragmentShader);

  String fragmentShader;
}

class FilterMessage {
  FilterMessage(this.filterId);

  int filterId;
}

class FloatFilterMessage {
  FloatFilterMessage(this.filterId, this.name, this.value);

  int filterId;
  String name;
  double value;
}

class FloatArrayFilterMessage {
  FloatArrayFilterMessage(this.filterId, this.name, this.value);

  int filterId;
  String name;
  List<double?> value;
}

class SourceFilterMessage {
  SourceFilterMessage(this.filterId, this.path, this.asset);

  int filterId;
  String path;
  bool asset;
}

class BitmapFilterMessage {
  BitmapFilterMessage(this.filterId, this.name, this.path, this.asset);

  int filterId;
  String name;
  String path;
  bool asset;
}

class BitmapDataFilterMessage {
  BitmapDataFilterMessage(this.filterId, this.name, this.data);

  int filterId;
  String name;
  Uint8List data;
}

@HostApi()
abstract class FilterApi {
  FilterMessage create(CreateFilterMessage msg);

  void setSource(SourceFilterMessage msg);

  void setFloatParameter(FloatFilterMessage msg);

  void setFloatArrayParameter(FloatArrayFilterMessage msg);

  void setBitmapParameter(BitmapFilterMessage msg);

  void setBitmapDataParameter(BitmapDataFilterMessage msg);

  void dispose(FilterMessage msg);
}
