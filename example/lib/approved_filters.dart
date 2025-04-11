import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

class FilterItem {
  final String name;
  final GPUFilterConfiguration configuration;

  FilterItem(this.name, this.configuration);

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is FilterItem &&
          runtimeType == other.runtimeType &&
          name == other.name;

  @override
  int get hashCode => name.hashCode;
}

final kFilters = {
  FilterItem(
    'Monochrome',
    FlutterVideoFilters.createFilter<GPUMonochromeConfiguration>(
        displayName: 'Monochrome',
      )
      ..color = Colors.orange
      ..intensity = 0.75,
  ),
}.sorted((a, b) => a.name.compareTo(b.name));
