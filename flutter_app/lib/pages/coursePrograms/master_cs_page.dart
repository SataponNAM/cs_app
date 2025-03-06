import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_app/models/programs_model.dart';
import '../../services/course_service.dart';

class MasterCsPage extends StatefulWidget {
  const MasterCsPage({super.key});

  @override
  State<MasterCsPage> createState() => _MasterCsPageState();
}

class _MasterCsPageState extends State<MasterCsPage> {
  final CourseHttp _courseHttp = CourseHttp();
  CourseCollection? _courseCollection;
  bool _isLoading = true;
  String _errorMessage = '';

  @override
  void initState() {
    super.initState();
    _initializeDownloader();
    _fetchPrograms();
  }

  Future<void> _initializeDownloader() async {
    await FlutterDownloader.initialize(
      debug: true, // optional: set to false in production
    );
  }

  Future<void> _fetchPrograms() async {
    try {
      setState(() {
        _isLoading = true;
      });

      final programs = await _courseHttp.fetchCourseProgramCollection(
          strUrl:
              'http://202.44.40.179/Data_From_Chiab/json/master_cs.json');

      setState(() {
        _courseCollection = programs;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'Failed to load courses. Please try again.';
        _isLoading = false;
      });
    }
  }

  Future<void> _downloadFile(String url) async {
    //print("Url: $url");

    FlutterDownloader.registerCallback(downloadCallback);
    final platform = Theme.of(context).platform;
    bool value = await _checkPermission(platform);

    if (value) {
      // await prepareSaveDir();
      // {
      final taskId = await FlutterDownloader.enqueue(
        url: url,
        savedDir: "/storage/emulated/0/Download",
        showNotification:
            true, // show download progress in status bar (for Android)
        openFileFromNotification:
            true, // click on notification to open downloaded file (for Android)
        saveInPublicStorage:
            true, // show download progress in status bar (for Android)
      );
      //}
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Colors.deepPurple.shade800),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'ปริญญาโท (วิทยาการคอมพิวเตอร์)',
          style: TextStyle(color: Colors.deepPurple.shade800),
        ),
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return Center(
        child: CircularProgressIndicator(
          color: Colors.deepPurple.shade800,
        ),
      );
    }

    if (_errorMessage.isNotEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              color: Colors.red,
              size: 60,
            ),
            SizedBox(height: 16),
            Text(
              _errorMessage,
              style: TextStyle(fontSize: 16),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchPrograms,
              child: Text('Retry'),
            )
          ],
        ),
      );
    }

    if (_courseCollection == null || _courseCollection!.courses.isEmpty) {
      return Center(
        child: Text(
          'No courses available',
          style: TextStyle(fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.all(16),
      itemCount: _courseCollection!.courses.length,
      itemBuilder: (context, index) {
        final program = _courseCollection!.courses[index];
        return _buildProgramCard(program);
      },
    );
  }

  Widget _buildProgramCard(CourseProgram program) {
    return Card(
      margin: EdgeInsets.only(bottom: 16),
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: ExpansionTile(
        title: Text(
          program.title,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.deepPurple.shade800,
          ),
        ),
        subtitle: Text(
          program.category,
          style: TextStyle(color: Colors.grey),
        ),
        children: program.links
            .map((link) => ListTile(
                  title: Text(link.name),
                  trailing:
                      Icon(Icons.download, color: Colors.deepPurple.shade800),
                  onTap: () {
                    _downloadFile(link.url);
                  },
                ))
            .toList(),
      ),
    );
  }

  Future<bool> _checkPermission(platform) async {
    if (Platform.isIOS) return true;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (platform == TargetPlatform.android &&
        androidInfo.version.sdkInt! <= 28) {
      final status = await Permission.storage.status;
      // final status2 = await Permission.manageExternalStorage.status;
      if (status != PermissionStatus.granted) {
        final result = await Permission.storage.request();
        // final result2 = await Permission.manageExternalStorage.request();
        if (result == PermissionStatus.granted) {
          return true;
        }
      } else {
        return true;
      }
    } else {
      return true;
    }

    return false;
  }

  static void downloadCallback(String id, int status, int progress) {
    final SendPort? send =
        IsolateNameServer.lookupPortByName('downloader_send_port');
    if (send != null) {
      send.send([id, status, progress]);
    }

    if (status == DownloadTaskStatus.running.index) {
      print("Downloading... $progress%");
    } else if (status == DownloadTaskStatus.complete.index) {
      print("Download completed successfully: Task ID $id");
    } else if (status == DownloadTaskStatus.failed.index) {
      print("Download failed: Task ID $id");
    }
  }
}
