library gpu_video_filters;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import 'gpu_video_filters_platform_interface.dart';

part 'src/configurations/gpu_filter_configuration.dart';
part 'src/configurations/gpu_lookup_table.dart';
part 'src/configurations/gpu_monochrome.dart';
part 'src/parameters/color_parameter.dart';
part 'src/parameters/float_parameter.dart';
part 'src/parameters/slider_float_parameter.dart';
part 'src/parameters/bitmap_parameter.dart';
part 'src/gpu_video_preview.dart';

Map<String, GPUFilterConfiguration Function()> availableFilters =
    kDebugMode || Platform.isAndroid
        ? {
            'Monochrome': () => GPUMonochromeConfiguration(),
            'Lookup Table': () => GPULookupTableConfiguration(),
          }
        : {};
