import 'package:example/filter_page.dart';
import 'package:flutter/material.dart' hide Rect;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Filters Demo',
      theme: ThemeData(primarySwatch: Colors.green),
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
        child: ListView(
          children: [
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FilterPage(filterType: FilterType.color);
                      },
                    ),
                  );
                },
                title: const Text('Color Filter'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
            Card(
              child: ListTile(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) {
                        return const FilterPage(filterType: FilterType.image);
                      },
                    ),
                  );
                },
                title: const Text('Image Filter'),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
