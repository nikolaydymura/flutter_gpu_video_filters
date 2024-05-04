library flutter_gpu_video_filters;

import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

import 'src/messages/filter_messages.g.dart';

part 'src/configurations/gpu_3x3_convolution.dart';

part 'src/configurations/gpu_add_blend.dart';

part 'src/configurations/gpu_alpha_blend.dart';

part 'src/configurations/gpu_bilateral.dart';

part 'src/configurations/gpu_box_blur.dart';

part 'src/configurations/gpu_brightness.dart';

part 'src/configurations/gpu_bulge_distortion.dart';

part 'src/configurations/gpu_cga_colorspace.dart';

part 'src/configurations/gpu_chroma_key_blend.dart';

part 'src/configurations/gpu_color_balance.dart';

part 'src/configurations/gpu_color_blend.dart';

part 'src/configurations/gpu_color_burn_blend.dart';

part 'src/configurations/gpu_color_dodge_blend.dart';

part 'src/configurations/gpu_color_invert.dart';

part 'src/configurations/gpu_color_matrix.dart';

part 'src/configurations/gpu_contrast.dart';

part 'src/configurations/gpu_crosshatch.dart';

part 'src/configurations/gpu_darken_blend.dart';

part 'src/configurations/gpu_difference_blend.dart';

part 'src/configurations/gpu_directional_sobel_edge_detection.dart';

part 'src/configurations/gpu_dissolve_blend.dart';

part 'src/configurations/gpu_divide_blend.dart';

part 'src/configurations/gpu_emboss.dart';

part 'src/configurations/gpu_exclusion_blend.dart';

part 'src/configurations/gpu_exposure.dart';

part 'src/configurations/gpu_false_color.dart';

part 'src/configurations/gpu_filter_configuration.dart';

part 'src/configurations/gpu_gamma.dart';

part 'src/configurations/gpu_gaussian_blur.dart';

part 'src/configurations/gpu_glass_sphere.dart';

part 'src/configurations/gpu_gray_scale.dart';

part 'src/configurations/gpu_halftone.dart';

part 'src/configurations/gpu_hard_light_blend.dart';

part 'src/configurations/gpu_haze.dart';

part 'src/configurations/gpu_highlight_shadow.dart';

part 'src/configurations/gpu_hue.dart';

part 'src/configurations/gpu_hue_blend.dart';

part 'src/configurations/gpu_invert.dart';

part 'src/configurations/gpu_kuwahara.dart';

part 'src/configurations/gpu_laplacian.dart';

part 'src/configurations/gpu_levels.dart';

part 'src/configurations/gpu_lighten_blend.dart';

part 'src/configurations/gpu_linear_burn_blend.dart';

part 'src/configurations/gpu_lookup_table.dart';

part 'src/configurations/gpu_luminance.dart';

part 'src/configurations/gpu_luminance_threshold.dart';

part 'src/configurations/gpu_luminosity_blend.dart';

part 'src/configurations/gpu_monochrome.dart';

part 'src/configurations/gpu_multiply_blend.dart';

part 'src/configurations/gpu_non_maximum_suppression.dart';

part 'src/configurations/gpu_normal_blend.dart';

part 'src/configurations/gpu_opacity.dart';

part 'src/configurations/gpu_overlay.dart';

part 'src/configurations/gpu_overlay_blend.dart';

part 'src/configurations/gpu_pixelation.dart';

part 'src/configurations/gpu_posterize.dart';

part 'src/configurations/gpu_rgb.dart';

part 'src/configurations/gpu_saturation.dart';

part 'src/configurations/gpu_saturation_blend.dart';

part 'src/configurations/gpu_screen_blend.dart';

part 'src/configurations/gpu_sepia.dart';

part 'src/configurations/gpu_sepia_tone.dart';

part 'src/configurations/gpu_sharpen.dart';

part 'src/configurations/gpu_sobel_threshold.dart';

part 'src/configurations/gpu_soft_light_blend.dart';

part 'src/configurations/gpu_solarize.dart';

part 'src/configurations/gpu_source_over_blend.dart';

part 'src/configurations/gpu_sphere_refraction.dart';

part 'src/configurations/gpu_subtract_blend.dart';

part 'src/configurations/gpu_swirl.dart';

part 'src/configurations/gpu_tone_curve.dart';

part 'src/configurations/gpu_toon.dart';

part 'src/configurations/gpu_vibrance.dart';

part 'src/configurations/gpu_vignette.dart';

part 'src/configurations/gpu_watermark.dart';

part 'src/configurations/gpu_weak_pixel_inclusion.dart';

part 'src/configurations/gpu_white_balance.dart';

part 'src/configurations/gpu_zoom_blur.dart';

part 'src/configurations/utils/image_2_mixin.dart';

part 'src/configurations/utils/sampling_3x3_mixin.dart';

part 'src/gpu_video_native_preview.dart';

part 'src/gpu_video_texture_preview.dart';

part 'src/parameters/aspect_ratio_parameter.dart';

part 'src/parameters/bitmap_parameter.dart';

part 'src/parameters/color_parameter.dart';

part 'src/parameters/float_parameter.dart';

part 'src/parameters/mat3_parameter.dart';

part 'src/parameters/mat4_parameter.dart';

part 'src/parameters/point_parameter.dart';

part 'src/parameters/slider_float_parameter.dart';

part 'src/parameters/vec3_parameter.dart';

sealed class FlutterVideoFilters {
  /// List of available filters
  static Iterable<String> get availableFilters => _availableFilters.keys;
  static final Map<String, GPUFilterConfiguration Function()>
      _availableFilters = {
    'Bilateral': () => GPUBilateralConfiguration(),
    'Box Blur': () => GPUBoxBlurConfiguration(),
    'Brightness': () => GPUBrightnessConfiguration(),
    'Bulge Distortion Configuration': () => GPUBulgeDistortionConfiguration(),
    'CGA Colorspace': () => GPUCGAColorspaceConfiguration(),
    'Contrast': () => GPUContrastConfiguration(),
    'Crosshatch': () => GPUCrosshatchConfiguration(),
    'Exposure': () => GPUExposureConfiguration(),
    'Gamma': () => GPUGammaConfiguration(),
    'Square Lookup Table': () => GPUSquareLookupTableConfiguration(),
    'HALD Lookup Table': () => GPUHALDLookupTableConfiguration(),
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
    'Opacity': () => GPUOpacityConfiguration(),
    'Overlay': () => GPUOverlayConfiguration(),
    'Pixelation': () => GPUPixelationConfiguration(),
    'Posterize': () => GPUPosterizeConfiguration(),
    'RGB': () => GPURGBConfiguration(),
    'Saturation': () => GPUSaturationConfiguration(),
    'Sepia': () => GPUSepiaConfiguration(),
    'Sharpen': () => GPUSharpenConfiguration(),
    'Solarize': () => GPUSolarizeConfiguration(),
    'Sphere Refraction': () => GPUSphereRefractionConfiguration(),
    'Swirl': () => GPUSwirlConfiguration(),
    'Toon': () => GPUToonConfiguration(),
    'Tone Curve': () => GPUToneCurveConfiguration(),
    'Vibrance': () => GPUVibranceConfiguration(),
    'Vignette': () => GPUVignetteConfiguration(),
    'Watermark': () => GPUWatermarkConfiguration(),
    'Weak Pixel Inclusion': () => GPUWeakPixelInclusionConfiguration(),
    'WhiteBalance': () => GPUWhiteBalanceConfiguration(),
    'Zoom Blur': () => GPUZoomBlurConfiguration(),
    'Add Blend': () => GPUAddBlendConfiguration(),
    'Alpha Blend': () => GPUAlphaBlendConfiguration(),
    'Chroma Key Blend': () => GPUChromaKeyBlendConfiguration(),
    'Color Blend': () => GPUColorBlendConfiguration(),
    'Color Burn Blend': () => GPUColorBurnBlendConfiguration(),
    'Color Dodge Blend': () => GPUColorDodgeBlendConfiguration(),
    'Darken Blend': () => GPUDarkenBlendConfiguration(),
    'Difference Blend': () => GPUDifferenceBlendConfiguration(),
    'Dissolve Blend': () => GPUDissolveBlendConfiguration(),
    'Divide Blend': () => GPUDivideBlendConfiguration(),
    'Hard Light Blend': () => GPUHardLightBlendConfiguration(),
    'Hue Blend': () => GPUHueBlendConfiguration(),
    'Lighten Blend': () => GPULightenBlendConfiguration(),
    'Linear Burn Blend': () => GPULinearBurnBlendConfiguration(),
    'Luminosity Blend': () => GPULuminosityBlendConfiguration(),
    'Multiply Blend': () => GPUMultiplyBlendConfiguration(),
    'Normal Blend': () => GPUNormalBlendConfiguration(),
    'Overlay Blend': () => GPUOverlayBlendConfiguration(),
    'Saturation Blend': () => GPUSaturationBlendConfiguration(),
    'Screen Blend': () => GPUScreenBlendConfiguration(),
    'Soft Light Blend': () => GPUSoftLightBlendConfiguration(),
    'Source Over Blend': () => GPUSourceOverBlendConfiguration(),
    'Subtract Blend': () => GPUSubtractBlendConfiguration(),
    '3x3 Convolution': () => GPU3x3ConvolutionConfiguration(),
    'Color Balance': () => GPUColorBalanceConfiguration(),
    'Color Invert': () => GPUColorInvertConfiguration(),
    'Color Matrix': () => GPUColorMatrixConfiguration(),
    'Directional Sobel Edge Detection': () =>
        GPUDirectionalSobelEdgeDetectionConfiguration(),
    'False Color': () => GPUFalseColorConfiguration(),
    'Glass Sphere': () => GPUGlassSphereConfiguration(),
    'Kuwahara': () => GPUKuwaharaConfiguration(),
    'Laplacian': () => GPULaplacianConfiguration(),
    'Levels': () => GPULevelsConfiguration(),
    'Non Maximum Suppression': () => GPUNonMaximumSuppressionConfiguration(),
    'Sobel Threshold': () => GPUSobelThresholdConfiguration(),
    'Emboss': () => GPUEmbossConfiguration(),
    'Sepia Tone': () => GPUSepiaToneConfiguration(),
  };

  /// Create a [GPUFilterConfiguration] filter by its [displayName]
  ///
  /// Throws an exception if the configuration is not found
  static T createFilter<T extends GPUFilterConfiguration>({
    required String displayName,
  }) {
    final configuration = _availableFilters[displayName]?.call();
    if (configuration == null) {
      throw 'Configuration not found for $displayName';
    }
    return configuration as T;
  }
}
