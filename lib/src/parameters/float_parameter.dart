part of flutter_gpu_video_filters;

mixin _NumberParameter on NumberParameter {
  double get floatValue => value.toDouble();
}

class _FloatParameter extends NumberParameter with _NumberParameter {
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

class _IntParameter extends NumberParameter with _NumberParameter {
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
  double get floatValue => value.toInt().toDouble();
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

  double get floatValue => value ? 1.0 : 0.0;
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
