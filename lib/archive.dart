import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';

class archive extends StatefulWidget {
  final ValueChanged<bool> onThemeChanged;

  archive({required this.onThemeChanged});

  @override
  _archiveState createState() => _archiveState();
}

class _archiveState extends State<archive> {
  late Directory _archiveDirectory;
  List<FileSystemEntity>? _files;

  @override
  void initState() {
    super.initState();
    getArchiveDirectory();
  }

  Future<void> getArchiveDirectory() async {
    _archiveDirectory = Directory('/storage/emulated/0/Download/Archive');
    final dirExists = await _archiveDirectory.exists();
    if (!dirExists) {
      await _archiveDirectory.create();
    }
    setState(() {
      _files = _archiveDirectory.listSync().where((element) => element is File).toList();
    });
  }

  Future<void> removeFromArchive(FileSystemEntity file) async {
    try {
      if (file is File) {
        await file.delete();
      }
      getArchiveDirectory();
    } catch (e) {
      print('Failed to remove file from archive: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Archive'),
      ),
      body: _files != null
          ? ListView.builder(
        itemCount: _files!.length,
        itemBuilder: (BuildContext context, int index) {
          final FileSystemEntity file = _files![index];
          return ListTile(
            leading: Icon(Icons.insert_drive_file),
            onTap: () => OpenFile.open(file.path),
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
                  child: Text("Remove from Archive"),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  OpenFile.open(file.path);
                } else if (value == 2) {
                  removeFromArchive(file);
                }
              },
            ),
          );
        },
      )
          : Center(child: Text('Nothing saved in the Archives')),
      // ... rest of your code ...
    );
  }
}
