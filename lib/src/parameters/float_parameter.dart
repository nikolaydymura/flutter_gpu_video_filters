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
      value.toDouble(),
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
      value.toInt().toDouble(),
    );
  }
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
      value ? 1.0 : 0.0,
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
  num get value {
    final temperature = super.value.toDouble();
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
  num get value => super.value.toDouble() / 100.0;
}
