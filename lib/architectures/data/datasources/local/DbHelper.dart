import 'dart:io';

import 'package:faker/faker.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/queries/FeedQuery.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/queries/UserQuery.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';
import 'package:fluttersosmed/helpers/util_int.dart';
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

  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    String path = "";
    if (kIsWeb) {
      path = 'contact.db';
    } else {
      Directory directory = await getApplicationDocumentsDirectory();
      path = '${directory.path}contact.db';
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
    final userDummy = List.generate(
        30,
        (index) => UserProfile(
              id: index + 1,
              name: faker.person.name(),
              profilePict:
                  "https://picsum.photos/seed/profile${index + 1}/300/300",
              coverPict: "https://picsum.photos/seed/cover${index + 1}/500/300",
              followed: false,
              job: faker.company.position(),
            ));
    List<UserFeed> userFeeds = [];
    for (final dataDummy in userDummy) {
      var userMap = dataDummy.toMap();
      userMap.remove("id");
      userMap["followed"] = 0;
      final userId = await db.insert(UserQuery.TABLE_NAME, userMap);
      for (int i = 0; i < 10; i++) {
        userFeeds.add(UserFeed(
          id: 0,
          userId: userId,
          name: dataDummy.name,
          pict: dataDummy.profilePict,
          feedContent: generatePost(),
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
        ));
      }
    }
    userFeeds.shuffle();
    for (var userFeed in userFeeds) {
      var feedMap = userFeed.toMap();
      feedMap["created"] = userFeed.created.toTanggal("yyyy-MM-dd");
      feedMap["isLiked"] = userFeed.isLiked ? 1 : 0;
      feedMap.remove("tags");
      feedMap.remove("id");
      final insertedFeed = await db.insert(FeedQuery.TABLE_NAME, feedMap);
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

  Future<List<UserFeed>> getUserFeed(FeedSearch feedSearch) async {
    final db = await initDb();
    List<String> whereList = [];
    List<String> argList = [];
    if (feedSearch.userId != null) {
      whereList.add("userId");
      argList.add(feedSearch.userId!.toString());
    }
    if (feedSearch.favourite) {
      whereList.add("isLiked");
      argList.add("1");
    }
    String whereStr = "";
    for (final where in whereList) {
      if (whereStr.isNotEmpty) {
        whereStr = whereStr + "&";
      }
      whereStr = whereStr + "$where=?";
    }
    debugPrint("get post with query $whereStr");
    final result = await db.query(
      FeedQuery.TABLE_NAME,
      where: whereList.isEmpty ? null : whereStr,
      whereArgs: whereList.isEmpty ? null : argList,
      orderBy: 'id',
      limit: feedSearch.limit,
      offset: feedSearch.page,
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

  Future<List<UserProfile>> getUser(UserSearch userSearch) async {
    final db = await initDb();
    List<String> whereList = [];
    List<String> argList = [];
    if (userSearch.userId != null) {
      whereList.add("id");
      argList.add(userSearch.userId!.toString());
    }
    if (userSearch.onlyFriend) {
      whereList.add("followed");
      argList.add("1");
    }
    String whereStr = "";
    for (final where in whereList) {
      if (whereStr.isNotEmpty) {
        whereStr = whereStr + "&";
      }
      whereStr = whereStr + "$where=?";
    }
    debugPrint("get user with query $whereStr");
    final result = await db.query(
      UserQuery.TABLE_NAME,
      where: whereList.isEmpty ? null : whereStr,
      whereArgs: whereList.isEmpty ? null : argList,
      orderBy: 'id',
      limit: userSearch.limit,
      offset: userSearch.page,
    );

    List<UserProfile> theRespon = [];

    for (var theResult in result) {
      var newMap = Map.of(theResult);
      newMap["followed"] = newMap["followed"] == 1;

      var rowAbsen = UserProfile.fromMap(newMap);

      theRespon.add(rowAbsen);
    }
    // if (theRespon.isNotEmpty) {
    //   delete(theRespon[0].id);
    // }

    return theRespon;
  }

  Future<void> toggleFollow(int userId, bool follow) async {
    final db = await initDb();
    int count = await db.update(
        UserQuery.TABLE_NAME,
        {
          "followed": follow ? 1 : 0,
        },
        where: 'id=?',
        whereArgs: [userId]);
  }

  Future<void> toggleLike(int feedId, bool like) async {
    final db = await initDb();
    int count = await db.update(
        FeedQuery.TABLE_NAME,
        {
          "isLiked": like ? 1 : 0,
        },
        where: 'id=?',
        whereArgs: [feedId]);
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

  static String generatePost() {
    final postType = UtilInt.randomRange(0, 8);

    switch (postType) {
      case 0:
        return "Hi, its a good day to enjoy some ${faker.food.dish()} in ${faker.food.restaurant()}";
      case 1:
        return "Just got job in ${faker.company.name()} as ${faker.company.position()}";
      case 2:
        return "Visiting my grandma in ${faker.address.city()}";
      case 3:
        return "Get well soon my friend ${faker.person.name()}";
      case 4:
        return "Need visa to visit ${faker.address.country()}";
      case 5:
        return "Which one you prefer? ${faker.animal.name()} or ${faker.animal.name()}";
      case 6:
        return "Looking for job in ${faker.address.state()}";
      case 7:
        return "Anyone want to buy a ${faker.animal.name()}? meet me at ${faker.address.city()}";
      case 8:
        return "${faker.company.position()} at your service";
      default:
        return "Enjoying dinner in ${faker.food.restaurant()}";
    }
  }
}
