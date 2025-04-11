//ignore_for_file: use_build_context_synchronously
import 'dart:io' show File;

import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' hide Rect;
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';
import 'package:photo_manager/photo_manager.dart';

import 'approved_filters.dart';
import 'filters.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filters Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.green,
      ),
      home: const ListPage(),
    );
  }
}

class ListPage extends StatelessWidget {
  const ListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Filters')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = kFailedFilters[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FilterPage(
                              configuration: item.configuration,
                            );
                          },
                        ),
                      );
                    },
                    title: Text(item.name),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).colorScheme.error,
                    ),
                  ),
                );
              }, childCount: kFailedFilters.length),
              itemExtent: 64,
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate((context, index) {
                final item = kFilters[index];
                return Card(
                  child: ListTile(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return FilterPage(
                              configuration: item.configuration,
                            );
                          },
                        ),
                      );
                    },
                    title: Text(item.name),
                    trailing: Icon(
                      Icons.arrow_forward,
                      color: Theme.of(context).primaryColor,
                    ),
                  ),
                );
              }, childCount: kFilters.length),
              itemExtent: 64,
            ),
          ],
        ),
      ),
    );
  }
}

class FilterPage extends StatefulWidget {
  final GPUFilterConfiguration configuration;

  const FilterPage({super.key, required this.configuration});

  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late final VideoPreviewController controller;
  late final GPUVideoPreviewParams previewParams;
  bool previewParamsReady = false;
  static const _videoAsset = 'videos/demo.mp4';

  @override
  void initState() {
    super.initState();
    _prepare().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    widget.configuration.dispose();
    super.dispose();
  }

  Future<void> _prepare() async {
    await widget.configuration.prepare();
    previewParams = await GPUVideoPreviewParams.create(widget.configuration);
    previewParamsReady = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          _exportVideo().catchError(
            (e) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString()))),
          );
        },
        tooltip: 'Export video',
        child: const Icon(Icons.save),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child:
                  previewParamsReady
                      ? GPUVideoSurfacePreview(
                        configuration: widget.configuration,
                        onViewCreated: (controller, outputSizeStream) async {
                          this.controller = controller;
                          await controller.setVideoSource(
                            AssetInputSource(_videoAsset),
                          );
                          await widget.configuration.update();
                          await for (final _ in outputSizeStream) {
                            setState(() {});
                          }
                        },
                      )
                      : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  controller.pause();
                },
                child: const Text('Pause'),
              ),
              TextButton(
                onPressed: () {
                  controller.play();
                },
                child: const Text('Play'),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
    final processStream = widget.configuration.exportVideoFile(
      VideoExportConfig(
        latestFile == null
            ? AssetInputSource(asset)
            : FileInputSource(latestFile!),
        output,
      ),
    );
    await for (final progress in processStream) {
      debugPrint('_exportVideo: Exporting file ${(progress * 100).toInt()}%');
    }
    debugPrint(
      '_exportVideo: Exporting file took ${watch.elapsedMilliseconds} milliseconds',
    );
    await _saveFile(output);
    latestFile = output;
    debugPrint('_exportVideo: Exported: ${output.absolute}');
  }
}

class FilterPage2 extends StatefulWidget {
  final GPUFilterConfiguration configuration;

  const FilterPage2({super.key, required this.configuration});

  @override
  State<FilterPage2> createState() => _FilterPageState2();
}

class _FilterPageState2 extends State<FilterPage2> {
  late final VideoPreviewController controller;
  bool previewParamsReady = false;
  static const _videoAsset = 'videos/demo.mp4';

  @override
  void initState() {
    super.initState();
    _prepare().whenComplete(() => setState(() {}));
  }

  @override
  void dispose() {
    controller.dispose();
    widget.configuration.dispose();
    super.dispose();
  }

  Future<void> _prepare() async {
    await widget.configuration.prepare();
    controller = await GPUVideoPreviewController.initialize();
    await controller.connect(widget.configuration);
    await controller.setVideoSource(AssetInputSource(_videoAsset));
    previewParamsReady = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Preview')),
      floatingActionButton: FloatingActionButton(
        heroTag: null,
        onPressed: () {
          _exportVideo().catchError(
            (e) => ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString()))),
          );
        },
        tooltip: 'Export video',
        child: const Icon(Icons.save),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child:
                  previewParamsReady
                      ? VideoPreview(controller: controller)
                      : const Center(child: CircularProgressIndicator()),
            ),
          ),
          Row(
            children: [
              TextButton(
                onPressed: () {
                  controller.pause();
                },
                child: const Text('Pause'),
              ),
              TextButton(
                onPressed: () {
                  controller.play();
                },
                child: const Text('Play'),
              ),
            ],
          ),
        ],
      ), // This trailing comma makes auto-formatting nicer for build methods.
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
    final processStream = widget.configuration.exportVideoFile(
      VideoExportConfig(
        latestFile == null
            ? AssetInputSource(asset)
            : FileInputSource(latestFile!),
        output,
      ),
    );
    await for (final progress in processStream) {
      debugPrint('_exportVideo: Exporting file ${(progress * 100).toInt()}%');
    }
    debugPrint(
      '_exportVideo: Exporting file took ${watch.elapsedMilliseconds} milliseconds',
    );
    await _saveFile(output);
    latestFile = output;
    debugPrint('_exportVideo: Exported: ${output.absolute}');
  }
}

Future<void> _saveFile(File input) async {
  try {
    final status = await PhotoManager.requestPermissionExtend(
      requestOption: const PermissionRequestOption(
        androidPermission: AndroidPermission(
          type: RequestType.video,
          mediaLocation: false,
        ),
      ),
    );
    if (status.isAuth || status.hasAccess) {
      await PhotoManager.editor.saveVideo(
        input,
        title: input.uri.pathSegments.last,
      );
    }
  } catch (e, s) {
    debugPrint('Error saving file to gallery: $e');
    debugPrintStack(stackTrace: s);
    rethrow;
  }
}
