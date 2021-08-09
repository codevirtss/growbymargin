import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:growbymargin/Screens/DownloadAlert.dart';
import 'package:growbymargin/Utils/constanst.dart';
import 'package:growbymargin/helper/Downloadhelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

class PurchaseHelper {
  var dlDB = DownloadsDB();
  // Entry? entry;
  // bool downloaded = false;

  // addDownload(Map body) async {
  //   await dlDB.removeAllWithId({'id': entry!.toString()});
  //   await dlDB.add(body);
  //   checkDownload();
  // }

  // check if book has been downloaded before
  // checkDownload() async {
  //   List downloads = await dlDB.check({'id': entry.id.t.toString()});
  //   if (downloads.isNotEmpty) {
  //     // check if book has been deleted
  //     String path = downloads[0]['path'];
  //     print(path);
  //     if (await File(path).exists()) {
  //       setDownloaded(true);
  //     } else {
  //       setDownloaded(false);
  //     }
  //   } else {
  //     setDownloaded(false);
  //   }
  // }

  void setDownloaded(value) {
    // downloaded = value;
  }

  Future downloadFile(BuildContext context, String url, String fileName) async {
    PermissionStatus permission = await Permission.storage.status;

    if (permission != PermissionStatus.granted) {
      await Permission.storage.request();
      startDownload(context, url, fileName);
    } else {
      startDownload(context, url, fileName);
    }
  }

  startDownload(BuildContext context, String url, String filename) async {
    Directory? appDocDir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    if (Platform.isAndroid) {
      Directory(appDocDir!.path.split('Andrpid')[0] + '.${Constants.appName}')
          .createSync();
    }

    String path = Platform.isIOS
        ? appDocDir!.path + '/$filename.epub'
        : appDocDir!.path.split('Android')[0] +
            '.${Constants.appName}/$filename.epub';

    print("Path: " + path);
    File file = File(path);
    if (!await file.exists()) {
      await file.exists();
    } else {
      await file.delete();
      await file.create();
    }

    // showDialog(
    //   barrierDismissible: false,
    //   context: context,
    //   builder: (context) => DownloadAlert(
    //     url: url,
    //     path: path,
    //   ),
    // ).then((v) {
    //   // When the download finishes, we then add the book
    //   // to our local database
    //   if (v != null) {
    //     addDownload(
    //       {
    //         'id': entry.id.t.toString(),
    //         'path': path,
    //         'image': '${entry.link[1].href}',
    //         'size': v,
    //         'name': entry.title.t,
    //       },
    //     );
    //   }
    // });
  }
}
