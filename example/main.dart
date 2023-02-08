import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';

class PreviewPage extends StatefulWidget {
  const PreviewPage({Key? key}) : super(key: key);

  @override
  State<PreviewPage> createState() => _PreviewPageState();
}

class _PreviewPageState extends State<PreviewPage> {
  late final GPUVideoPreviewController controller;
  late final GPUVideoPreviewParams previewParams;
  late GPUFilterConfiguration configuration;
  bool previewParamsReady = false;
  static const _assetPath = 'demo.mp4';

  @override
  void initState() {
    super.initState();
    configuration = GPUGrayScaleConfiguration();
    _prepare().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  Future<void> _prepare() async {
    previewParams = await GPUVideoPreviewParams.create(configuration);
    previewParamsReady = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: previewParamsReady
              ? GPUVideoNativePreview(
                  params: previewParams,
                  configuration: configuration,
                  onViewCreated: (controller, outputSizeStream) async {
                    controller = controller;
                    controller.setVideoAsset(_assetPath);
                    await for (final size in outputSizeStream) {
                      setState(() {});
                    }
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _exportVideo();
        },
        child: const Icon(Icons.save),
      ),
    );
  }

  Future<void> _exportVideo() async {
    const asset = _assetPath;
    final output = File(
      '${DateTime.now().millisecondsSinceEpoch}.${asset.split('.').last}',
    );
    final watch = Stopwatch();
    watch.start();
    final processStream = configuration.exportVideoFile(
      VideoExportConfig(
        AssetInputSource(asset),
        output,
      ),
    );
    await for (final progress in processStream) {
      debugPrint('Exporting file ${(progress * 100).toInt()}%');
    }
    debugPrint('Exporting file took ${watch.elapsedMilliseconds} milliseconds');
    debugPrint('Exported: ${output.absolute}');
  }
}
