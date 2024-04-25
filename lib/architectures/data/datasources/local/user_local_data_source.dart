import 'package:fluttersosmed/architectures/data/datasources/local/DbHelper.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserSearch.dart';

class UserLocalDataSource {
  static Future<UserProfile> getUser(int id) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.getUser(UserSearch(
      userId: id,
    ));

    await Future.delayed(Duration(seconds: 1));
    return feedList[0];
    //end of komoditasList
  }

  static Future<List<UserProfile>> getAllUser(UserSearch userSearch) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.getUser(userSearch);

    await Future.delayed(Duration(seconds: 1));
    return feedList;
    //end of komoditasList
  }

  static Future<void> toggleFollow(int userId, bool follow) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.toggleFollow(userId, follow);

    await Future.delayed(Duration(seconds: 1));
    return feedList;
    //end of komoditasList
  }
}
