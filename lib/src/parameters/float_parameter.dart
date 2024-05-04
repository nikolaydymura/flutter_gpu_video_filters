part of '../../flutter_gpu_video_filters.dart';

/// Float parameter for GPU filters
///
/// This parameter is used to pass floating-point values to the GPU as `uniform float` variables.
@visibleForTesting
class GLFloatParameter extends NumberParameter {
  /// Create a [GLFloatParameter]
  ///
  /// [name] identifies name in GLSL shader source
  /// [displayName] is a human-readable name
  /// [value] is the initial value
  GLFloatParameter(super.name, super.displayName, super.value);

  /// Apply updates to the GPU filter
  ///
  /// [configuration] is the connected GPU filter configuration
  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await configuration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

@visibleForTesting
class GLIntParameter extends GLFloatParameter {
  GLIntParameter(super.name, super.displayName, super.value);

  @override
  double get floatValue => intValue.toDouble();
}

@visibleForTesting
class GLBoolParameter extends BoolParameter {
  GLBoolParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await configuration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

@visibleForTesting
class GLTemperatureParameter extends GLFloatParameter {
  GLTemperatureParameter(
    super.name,
    super.displayName,
    super.value,
  );

  @override
  double get floatValue {
    final temperature = value.toDouble();
    return temperature < 5000
        ? 0.0004 * (temperature - 5000.0)
        : 0.00006 * (temperature - 5000.0);
  }
}

@override
class GLTintParameter extends GLFloatParameter {
  GLTintParameter(
    super.shaderName,
    super.displayName,
    super.value,
  );

  @override
  double get floatValue => value.toDouble() / 100.0;
}

@override
class GLHueParameter extends GLFloatParameter {
  GLHueParameter(
    super.shaderName,
    super.displayName,
    super.value,
  );

  @override
  double get floatValue => (value % 360.0) * pi / 180.0;
}
