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

import 'src/messages/preview_messages.g.dart';

part 'src/configurations/gpu_bilateral.dart';
part 'src/configurations/gpu_box_blur.dart';
part 'src/configurations/gpu_brightness.dart';
part 'src/configurations/gpu_cga_colorspace.dart';
part 'src/configurations/gpu_contrast.dart';
part 'src/configurations/gpu_crosshatch.dart';
part 'src/configurations/gpu_exposure.dart';
part 'src/configurations/gpu_filter_configuration.dart';
part 'src/configurations/gpu_gamma.dart';
part 'src/configurations/gpu_gaussian_blur.dart';
part 'src/configurations/gpu_gray_scale.dart';
part 'src/configurations/gpu_halftone.dart';
part 'src/configurations/gpu_haze.dart';
part 'src/configurations/gpu_highlight_shadow.dart';
part 'src/configurations/gpu_hue.dart';
part 'src/configurations/gpu_invert.dart';
part 'src/configurations/gpu_lookup_table.dart';
part 'src/configurations/gpu_luminance.dart';
part 'src/configurations/gpu_luminance_threshold.dart';
part 'src/configurations/gpu_monochrome.dart';
part 'src/gpu_video_preview.dart';
part 'src/parameters/bitmap_parameter.dart';
part 'src/parameters/color_parameter.dart';
part 'src/parameters/float_parameter.dart';
part 'src/parameters/slider_float_parameter.dart';

Map<String, GPUFilterConfiguration Function()> availableFilters =
    kDebugMode || Platform.isAndroid
        ? {
            'Bilateral': () => GPUBilateralConfiguration(),
            'Box Blur': () => GPUBoxBlurConfiguration(),
            'Brightness': () => GPUBrightnessConfiguration(),
            'CGA Colorspace': () => GPUCGAColorspaceConfiguration(),
            'Contrast': () => GPUContrastConfiguration(),
            'Crosshatch': () => GPUCrosshatchConfiguration(),
            'Exposure': () => GPUExposureConfiguration(),
            'Gamma': () => GPUGammaConfiguration(),
            'Lookup Table': () => GPULookupTableConfiguration(),
            'Monochrome': () => GPUMonochromeConfiguration(),
            'Gaussian Blur': () => GPUGaussianBlurConfiguration(),
            'Gray Scale': () => GPUGrayScaleConfiguration(),
            'Halftone': () => GPUHalftoneConfiguration(),
            'Haze': () => GPUHazeConfiguration(),
            'Highlight Shadow': () => GPUHighlightShadowConfiguration(),
            'Hue': () => GPUHueConfiguration(),
            'Invert': () => GPUInvertConfiguration(),
            'Luminance': () => GPULuminanceConfiguration(),
            'Luminance Threshold': () => GPULuminanceThresholdConfiguration(),
          }
        : {};
