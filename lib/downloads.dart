import 'dart:io';
import 'package:flutter/material.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:file_picker/file_picker.dart';

import 'bin.dart';

class Downloads extends StatefulWidget {
  Downloads({Key? key, required ValueChanged<bool> onThemeChanged}) : super(key: key);

  @override
  _DownloadsState createState() => _DownloadsState();
}

class _DownloadsState extends State<Downloads> {
  late Directory _downloadsDirectory;
  late Directory _trashDirectory; // New directory for "Recycle Bin"
  List<FileSystemEntity>? _files;
  late Directory _favouritesDirectory;
  late Directory _archiveDirectory; // Declare _archiveDirectory here
// Declare _favouritesDirectory here


  @override
  void initState() {
    super.initState();
    getDownloadsDirectory();
    getTrashDirectory();
    getFavouritesDirectory();
    getArchiveDirectory(); // Initialize the "Archive" directory
// Initialize the "Favourites" directory
// Initialize the "Recycle Bin" directory
  }
  Future<void> getArchiveDirectory() async {
    _archiveDirectory = Directory('/storage/emulated/0/Download/Archive');
    final archiveDirExists = await _archiveDirectory.exists();
    if (!archiveDirExists) {
      await _archiveDirectory.create();
    }
  }

  Future<void> addToArchive(FileSystemEntity file) async {
    try {
      if (file is File) {
        await file.copy('${_archiveDirectory.path}/${file.path.split('/').last}');
      }
      getDownloadsDirectory();
    } catch (e) {
      print('Failed to add file to archive: $e');
    }
  }
  Future<void> getDownloadsDirectory() async {
    _downloadsDirectory = Directory('/storage/emulated/0/Download');
    setState(() {
      _files = _downloadsDirectory.listSync().where((element) => element is File).toList();
    });
  }

  Future<void> getTrashDirectory() async {
    _trashDirectory = Directory('/storage/emulated/0/Download/Trash');
    final trashDirExists = await _trashDirectory.exists();
    if (!trashDirExists) {
      await _trashDirectory.create();
    }
  }

  Future<void> moveToTrash(FileSystemEntity file) async {
    try {
      if (file is File) {
        await file.rename('${_trashDirectory.path}/${file.path.split('/').last}');
      }
      getDownloadsDirectory();
    } catch (e) {
      print('Failed to move file: $e');
    }
  }



  Future<void> addFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if(result != null) {
      File file = File(result.files.single.path!);
      final File newFile = File('${_downloadsDirectory.path}/${file.path.split('/').last}');
      await newFile.writeAsBytes(await file.readAsBytes());
      getDownloadsDirectory();
    }
  }
  Future<void> getFavouritesDirectory() async {
    _favouritesDirectory = Directory('/storage/emulated/0/Download/Favourites');
    final favDirExists = await _favouritesDirectory.exists();
    if (!favDirExists) {
      await _favouritesDirectory.create();
    }
  }

  Future<void> addToFavourites(FileSystemEntity file) async {
    try {
      if (file is File) {
        await file.copy('${_favouritesDirectory.path}/${file.path.split('/').last}');
      }
      getDownloadsDirectory();
    } catch (e) {
      print('Failed to add file to favourites: $e');
    }
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Downloads'),
      ),
      body: _files != null
          ? ListView.builder(
        itemCount: _files!.length,
        itemBuilder: (BuildContext context, int index) {
          final FileSystemEntity file = _files![index];
          return ListTile(
            leading: Icon(Icons.insert_drive_file),
            onTap:() =>OpenFile.open(file.path) ,
            title: Text(file.path.split('/').last),
            trailing: PopupMenuButton<int>(
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 1,
                  child: Text("Open"),
                ),
                PopupMenuItem(
                  value: 2,
                  child: Text("Rename"),
                ),
                PopupMenuItem(
                  value: 3,
                  child: Text("Move to Trash"),
                ),
                PopupMenuItem(
                  value: 4,
                  child: Text("Add to Favourites"),
                ),
                PopupMenuItem(
                  value: 5,
                  child: Text("Add to Archive"),
                ),
              ],
              onSelected: (value) {
                if (value == 1) {
                  OpenFile.open(file.path);
                } else if (value == 2) {
                  // ... rename file code ...
                } else if (value == 3) {
                  moveToTrash(file);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SecondRoute(file: file, files: [],)),
                  );
                }
                else if (value == 4) {
                  addToFavourites(file);
                }
                else if (value == 5) {
                  addToArchive(file);
                }
              },
            ),
          );
        },
      )
          : Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        backgroundColor:Colors.red ,
        onPressed: addFile,
        tooltip: 'Add File',
        child: Icon(Icons.add),
      ),
    );
  }
}
