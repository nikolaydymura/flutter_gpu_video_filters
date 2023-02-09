part of flutter_gpu_video_filters;

class _FloatParameter extends NumberParameter {
  _FloatParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

class _IntParameter extends NumberParameter {
  _IntParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }

  @override
  double get floatValue => intValue.toDouble();
}

class _BoolParameter extends BoolParameter {
  _BoolParameter(super.name, super.displayName, super.value);

  @override
  FutureOr<void> update(covariant GPUFilterConfiguration configuration) async {
    if (!configuration.ready) {
      debugPrint('Invoke `prepare()` before updating parameter $name');
      return;
    }
    await GPUFilterConfiguration._api.setFloatParameter(
      configuration._filterId,
      name,
      floatValue,
    );
  }
}

class _TemperatureParameter extends _FloatParameter {
  _TemperatureParameter(
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

class _TintParameter extends _FloatParameter {
  _TintParameter(
    super.shaderName,
    super.displayName,
    super.value,
  );

  @override
  double get floatValue => value.toDouble() / 100.0;
}
