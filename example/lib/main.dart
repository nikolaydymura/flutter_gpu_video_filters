import 'dart:io' show File;

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter/material.dart' hide Rect;
import 'package:flutter_gpu_video_filters/flutter_gpu_video_filters.dart';
import 'package:flutter_gpu_filters_interface/flutter_gpu_filters_interface.dart';

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
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: CustomScrollView(
          slivers: [
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                },
                childCount: kFailedFilters.length,
              ),
              itemExtent: 64,
            ),
            SliverFixedExtentList(
              delegate: SliverChildBuilderDelegate(
                    (context, index) {
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
                },
                childCount: kFilters.length,
              ),
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
  late final GPUVideoPreviewController controller;
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
    await widget.configuration.apply();
    previewParams = await GPUVideoPreviewParams.create(widget.configuration);
    previewParamsReady = true;
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
          _exportVideo();
        },
        tooltip: 'Export video',
        child: const Icon(Icons.save),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          child: previewParamsReady
              ? GPUVideoNativePreview(
            params: previewParams,
            configuration: widget.configuration,
            onViewCreated: (controller, outputSizeStream) async {
              this.controller = controller;
              final picker = ImagePicker();
              final v =
              await picker.pickVideo(source: ImageSource.gallery);
              await this.controller.setVideoFile(File(v!.path));
              // controller.setVideoAsset(_assetPath);
              await for (final _ in outputSizeStream) {
                setState(() {});
              }
            },
          )
              : const Center(
            child: CircularProgressIndicator(),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

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
