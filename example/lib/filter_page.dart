import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:path_provider/path_provider.dart';

enum FilterType { color, image }

class FilterPage extends StatefulWidget {
  final FilterType filterType;
  const FilterPage({super.key, required this.filterType});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  bool previewParamsReady = false;
  static const _videoAsset = 'videos/video.mp4';

  Future<void> _prepareColorFilter() async {
    late GPURGBConfiguration configuration;
    Color colr = Colors.red;
    configuration = GPURGBConfiguration()
      ..red = colr.red.toDouble()
      ..blue = colr.blue.toDouble()
      ..green = colr.green.toDouble();
    await configuration.prepare();
    await GPUVideoPreviewParams.create(configuration);
    previewParamsReady = true;
    print("_exportVideo=============");
    _exportVideo(config: configuration, context: context).catchError(
      (e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))),
    );
  }

  Future<void> _prepareImageFilter() async {
    GPUOverlayConfiguration configuration = GPUOverlayConfiguration()
      ..image2File = File('/data/data/com.example.example/cache/effect3.png');
    await configuration.prepare();
    await GPUVideoPreviewParams.create(configuration);
    previewParamsReady = true;
    _exportVideo(config: configuration, context: context).catchError(
      (e) => ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString()))),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            if (widget.filterType == FilterType.color) {
              _prepareColorFilter().whenComplete(() => setState(() {}));
            } else if (widget.filterType == FilterType.image) {
              _prepareImageFilter().whenComplete(() => setState(() {}));
            }
          },
          child: Text("Apply Filter"),
        ),
      ),
    );
  }

  Future<void> _exportVideo({required config, required BuildContext context}) async {
    const asset = _videoAsset;
    final root = await getTemporaryDirectory();
    final output = File(
      '${root.path}/${DateTime.now().millisecondsSinceEpoch}.${asset.split('.').last}',
    );
    final watch = Stopwatch();
    watch.start();
    final processStream = config.exportVideoFile(
      VideoExportConfig(
        AssetInputSource(asset),
        output,
      ),
    );
    await for (final progress in processStream) {
      debugPrint('_exportVideo: Exporting file ${(progress * 100).toInt()}%');
    }
    debugPrint('_exportVideo: Exporting file took ${watch.elapsed.inSeconds} Seconds');
    await GallerySaver.saveVideo(output.absolute.path);
    debugPrint('_exportVideo: Exported: ${output.absolute}');
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(backgroundColor: Colors.green.shade700, content: Text("Video Save Success${output.path}")),
    );
  }
}
