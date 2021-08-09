import 'dart:io';

import 'package:http/http.dart';
import 'package:objectdb/objectdb.dart';
import 'package:path_provider/path_provider.dart';

class DownloadsDB {
  getPath() async {
    Directory docDirectory = await getApplicationDocumentsDirectory();
    final path = docDirectory.path + "/downloads.d";
    return path;
  }

  //Insertion
  add(Map item) async {
    final db = ObjectDB(await getPath());
    db.insert(item);
    await db.close();
  }

  Future<int> remove(Map item) async {
    final db = ObjectDB(await getPath());
    int val = await db.remove(item);
    await db.close();
    return val;
  }

  Future removeAllWithId(Map item) async {
    final db = ObjectDB(await getPath());
    List val = await db.find({});

    val.forEach((element) {
      db.remove(element);
    });
  }

  Future<List> listAll() async {
    final db = ObjectDB(await getPath());
    List val = await db.find({});

    await db.close();
    return val;
  }

  Future<List> check(Map item) async {
    final db = ObjectDB(await getPath());
    List val = await db.find(item);
    await db.close();
    return val;
  }
}
