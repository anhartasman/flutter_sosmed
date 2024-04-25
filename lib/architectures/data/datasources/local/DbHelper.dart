import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/queries/FeedQuery.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/queries/UserQuery.dart';
import 'package:path_provider/path_provider.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/helpers/extensions/ext_string.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

class DbHelper {
  //membuat method singleton
  static DbHelper _dbHelper = DbHelper._singleton();

  factory DbHelper() {
    return _dbHelper;
  }

  DbHelper._singleton();

  //baris terakhir singleton

  final tables = [
    UserQuery.CREATE_TABLE,
    FeedQuery.CREATE_TABLE,
  ]; // membuat daftar table yang akan dibuat
  final userDummy = [
    UserProfile(
      id: 0,
      name: "Budi Sudianto",
      profilePict: "https://picsum.photos/seed/profile1/300/300",
      coverPict: "https://picsum.photos/seed/cover1/500/300",
    ),
    UserProfile(
      id: 0,
      name: "Tano Rastuti",
      profilePict: "https://picsum.photos/seed/profile2/300/300",
      coverPict: "https://picsum.photos/seed/cover2/500/300",
    ),
    UserProfile(
      id: 0,
      name: "Cintia Solehah",
      profilePict: "https://picsum.photos/seed/profile3/300/300",
      coverPict: "https://picsum.photos/seed/cover3/500/300",
    ),
    UserProfile(
      id: 0,
      name: "Mama Yanti",
      profilePict: "https://picsum.photos/seed/profile4/300/300",
      coverPict: "https://picsum.photos/seed/cover4/500/300",
    ),
    UserProfile(
      id: 0,
      name: "Ucup Siregar",
      profilePict: "https://picsum.photos/seed/profile5/300/300",
      coverPict: "https://picsum.photos/seed/cover5/500/300",
    ),
  ];
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    String path = "";
    if (kIsWeb) {
      path = 'contact.db';
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      path = directory.path + 'contact.db';
    }
    //create, read databases
    late Future<Database> todoDatabase;
    if (kIsWeb) {
      var factory = databaseFactoryFfiWeb;
      todoDatabase = factory.openDatabase(
        path,
        options: OpenDatabaseOptions(
          version: 4,
          onCreate: _createDb,
          onUpgrade: _onUpgradeDB,
        ),
      );
    } else {
      todoDatabase = openDatabase(path,
          version: 4, onCreate: _createDb, onUpgrade: _onUpgradeDB);
    }

    //mengembalikan nilai object sebagai hasil dari fungsinya
    return todoDatabase;
  }

  //buat tabel baru dengan nama contact
  void _createDb(Database db, int version) async {
    for (final table in tables) {
      await db.execute(table).then((value) {
        print("berhasil ");
      }).catchError((err) {
        print("errornya ${err.toString()}");
      });
    }
    int postId = 1;
    for (final dataDummy in userDummy) {
      var userMap = dataDummy.toMap();
      userMap.remove("id");
      final userId = await db.insert(UserQuery.TABLE_NAME, userMap);
      for (int i = 0; i < 5; i++) {
        final userFeed = UserFeed(
          id: postId,
          userId: userId,
          name: dataDummy.name,
          pict: dataDummy.profilePict,
          feedContent: "This is a content",
          created: faker.date.dateTime(
            minYear: 2023,
            maxYear: 2024,
          ),
          isLiked: false,
          tags: [
            "Tag 1",
            "Tag 2",
            "Tag 3",
            "Tag 4",
          ],
        );
        var feedMap = userFeed.toMap();
        feedMap["created"] = userFeed.created.toTanggal("yyyy-MM-dd");
        feedMap["isLiked"] = userFeed.isLiked ? 1 : 0;
        feedMap.remove("tags");
        final insertedFeed = await db.insert(FeedQuery.TABLE_NAME, feedMap);
        postId += 1;
      }
    }
  }

  void _onUpgradeDB(Database db, int oldVersion, int newVersion) async {
    for (final table in tables) {
      await db.execute(table).then((value) {
        print("berhasil ");
      }).catchError((err) {
        print("errornya ${err.toString()}");
      });
    }
  }

  Future<List<UserFeed>> getUserFeed({int? id}) async {
    final db = await initDb();
    final result = await db.query(
      FeedQuery.TABLE_NAME,
      where: id == null ? null : "userId=?",
      whereArgs: id == null ? null : [id],
      orderBy: 'id',
    );

    List<UserFeed> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);
      newMap["created"] =
          DateTime.parse(newMap["created"].toString()).millisecondsSinceEpoch;
      newMap["isLiked"] = newMap["isLiked"] == 1;
      newMap["tags"] = [
        "Tag 1",
        "Tag 2",
        "Tag 3",
        "Tag 4",
      ];
      var rowAbsen = UserFeed.fromMap(newMap);

      theRespon.add(rowAbsen);
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

  Future<UserProfile> getUser(int id) async {
    final db = await initDb();
    final result = await db.query(
      UserQuery.TABLE_NAME,
      where: "id=?",
      whereArgs: [id],
      orderBy: 'id',
    );

    List<UserProfile> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);

      var rowAbsen = UserProfile.fromMap(newMap);

      theRespon.add(rowAbsen);
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon[0];
  }

//create databases
  Future<int> insertUser(UserProfile object) async {
    final db = await initDb();
    var theMap = object.toMap();
    theMap.remove("id");
    int count = await db.insert(UserQuery.TABLE_NAME, theMap);
    return count;
  }

//delete databases
  Future<int> delete(int id) async {
    final db = await initDb();
    int count =
        await db.delete(UserQuery.TABLE_NAME, where: 'id=?', whereArgs: [id]);
    return count;
  }
}
