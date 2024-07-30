import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({super.key});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late final VideoPreviewController controller;
  late final GPUVideoPreviewParams previewParams;
  bool previewParamsReady = false;
  static const _videoAsset = 'videos/video.mp4';

  @override
  void initState() {
    super.initState();
    _prepare().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    configuration.dispose();
    super.dispose();
  }

  late GPURGBConfiguration configuration;

  Future<void> _prepare() async {
    Color colr = Colors.green;
    configuration = GPURGBConfiguration()
      ..red = colr.red.toDouble()
      ..blue = colr.blue.toDouble()
      ..green = colr.green.toDouble();

    await configuration.prepare();
    previewParams = await GPUVideoPreviewParams.create(configuration);
    previewParamsReady = true;
    _exportVideo().catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Preview'),
      ),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          _exportVideo()
              .catchError((e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))));
        },
        tooltip: 'Export video',
        child: const Icon(Icons.save),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: previewParamsReady
                  ? GPUVideoSurfacePreview(
                      configuration: configuration,
                      onViewCreated: (controller, outputSizeStream) async {
                        // this.controller = controller;
                        // await controller.setVideoSource(AssetInputSource(_videoAsset));
                        // await configuration.update();
                        // await for (final _ in outputSizeStream) {
                        //   setState(() {});
                        // }
                      },
                    )
                  : const Center(
                      child: CircularProgressIndicator(),
                    ),
            ),
          ),
          Row(
            children: [
              TextButton(
                  onPressed: () {
                    controller.pause();
                  },
                  child: const Text('Pause')),
              TextButton(
                  onPressed: () {
                    controller.play();
                  },
                  child: const Text('Play')),
            ],
          )
        ],
      ),
    );
  }

  File? latestFile;

  Future<void> _exportVideo() async {
    const asset = _videoAsset;
    final root = await getTemporaryDirectory();
    final output = File(
      '${root.path}/${DateTime.now().millisecondsSinceEpoch}.${asset.split('.').last}',
    );
    final watch = Stopwatch();
    watch.start();
    final processStream = configuration.exportVideoFile(
      VideoExportConfig(
        latestFile == null ? AssetInputSource(asset) : FileInputSource(latestFile!),
        output,
      ),
    );
    await for (final progress in processStream) {
      debugPrint('_exportVideo: Exporting file ${(progress * 100).toInt()}%');
    }
    debugPrint('_exportVideo: Exporting file took ${watch.elapsed.inSeconds} Seconds');
    await GallerySaver.saveVideo(output.absolute.path);
    latestFile = output;
    debugPrint('_exportVideo: Exported: ${output.absolute}');
  }
}
