import 'dart:io';
import 'dart:isolate';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:device_info_plus/device_info_plus.dart';

class HandbookPage extends StatefulWidget {
  const HandbookPage({super.key});

  @override
  State<HandbookPage> createState() => _HandbookPageState();
}

class _HandbookPageState extends State<HandbookPage> {
  late InAppWebViewController webViewController;
  bool isLoading = true; 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('คู่มือนักศึกษา'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          InAppWebView(
            initialUrlRequest: URLRequest(
                url: WebUri('http://cs.kmutnb.ac.th/guide-step.jsp')),
            initialOptions: InAppWebViewGroupOptions(
              crossPlatform: InAppWebViewOptions(
                javaScriptEnabled: true,
                useOnDownloadStart: true,
              ),
            ),
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            onLoadStart: (controller, url) {
              setState(() {
                isLoading = true;
              });
            },
            onLoadStop: (controller, url) async {
              await controller.evaluateJavascript(source: '''
                var meta = document.createElement('meta');
                meta.name = 'viewport';
                meta.content = 'width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no';
                document.getElementsByTagName('head')[0].appendChild(meta);

                document.querySelectorAll('nav, footer, .probootstrap-section.probootstrap-section-colored')
                  .forEach(el => el.style.display = 'none');

                document.body.style.backgroundColor = 'white';
              ''');
              setState(() {
                isLoading = false;
              });
            },
            onLoadError: (controller, url, code, message) {
              print("Error loading page: $message");
            },
            onDownloadStartRequest:
                (controller, DownloadStartRequest request) async {
              //todo download catelog here
              FlutterDownloader.registerCallback(downloadCallback);
              final platform = Theme.of(context).platform;
              bool value = await _checkPermission(platform);

              if (value) {
                // await prepareSaveDir();
                // {
                final taskId = await FlutterDownloader.enqueue(
                  url: request.url.toString(),
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
            },
          ),
          if (isLoading)
            const Center(
              child: CircularProgressIndicator(),
            ),
        ],
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