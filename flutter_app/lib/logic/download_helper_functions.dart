// import 'dart:io';
// import 'package:android_path_provider/android_path_provider.dart';
// import 'package:path_provider/path_provider.dart';

// late String localPath;

// Future<void> prepareSaveDir() async {
//   String? path = await findLocalPath();
  
//   if (path == null) {
//     print("Error: Unable to determine storage path.");
//     return;
//   }

//   localPath = path;
//   final savedDir = Directory(localPath);
  
//   if (!await savedDir.exists()) {
//     await savedDir.create(recursive: true);
//   }
// }

// Future<String?> findLocalPath() async {
//   if (Platform.isAndroid) {
//     try {
//       return await AndroidPathProvider.documentsPath;
//     } catch (e) {
//       print("Error getting Android documents path: $e");
//       final directory = await getExternalStorageDirectory();
//       return directory?.path;
//     }
//   } else if (Platform.isIOS) {
//     return (await getApplicationDocumentsDirectory()).path;
//   }
//   return null;
// }
