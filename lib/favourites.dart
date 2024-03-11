import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

class ThirdRoute extends StatefulWidget {
  const ThirdRoute({Key? key}) : super(key: key);

  @override
  _ThirdRouteState createState() => _ThirdRouteState();
}

class _ThirdRouteState extends State<ThirdRoute> {
  late Directory _favouritesDirectory;
  List<FileSystemEntity>? _files;

  @override
  void initState() {
    super.initState();
    getFavouritesDirectory();
  }

  Future<void> getFavouritesDirectory() async {
    _favouritesDirectory = Directory('/storage/emulated/0/Download/Favourites');
    final dirExists = await _favouritesDirectory.exists();
    if (!dirExists) {
      await _favouritesDirectory.create();
    }
    setState(() {
      _files = _favouritesDirectory.listSync().where((element) => element is File).toList();
    });
  }

  Future<void> removeFromFavourites(FileSystemEntity file) async {
    try {
      if (file is File) {
        await file.delete();
      }
      getFavouritesDirectory();
    } catch (e) {
      print('Failed to remove file from favourites: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favourites'),
      ),
      body: _files != null
          ? ListView.builder(
        itemCount: _files!.length,
        itemBuilder: (BuildContext context, int index) {
          final FileSystemEntity file = _files![index];
          return ListTile(
            leading: Icon(Icons.insert_drive_file),
            title: Text(file.path.split('/').last),
            trailing: PopupMenuButton<int>(
              itemBuilder: (context) =>
              [
                PopupMenuItem(
                  value: 1,
                  child: Text("Open"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Remove from Favourites"),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  OpenFile.open(file.path);
                } else if (value == 2) {
                  removeFromFavourites(file);
                }
              },
            ),
          );
        },
      )
          : Center(child: Text('Nothing saved as Favourites :(')),
    );
  }
}
