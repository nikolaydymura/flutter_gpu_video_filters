library flutter_gpu_video_filters;

import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/src/messages/filter_messages.g.dart';

import 'gpu_video_filters_platform_interface.dart';
import 'src/messages/preview_messages.g.dart';

part 'src/configurations/gpu_filter_configuration.dart';
part 'src/configurations/gpu_lookup_table.dart';
part 'src/configurations/gpu_monochrome.dart';
part 'src/configurations/gpu_bilateral.dart';
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
            'Bilateral Configuration':()=> GPUBilateralConfiguration(),
          }
        : {};
