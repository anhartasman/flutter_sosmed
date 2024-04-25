import 'package:faker/faker.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/DbHelper.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/helpers/util_int.dart';

class FeedLocalDataSource {
  static Future<List<UserFeed>> userFeed(FeedSearch feedSearch) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.getUserFeed(feedSearch);
    await Future.delayed(Duration(seconds: 1));
    return feedList;
    //end of komoditasList
  }

  static Future<void> toggleLike(int feedId, bool like) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.toggleLike(feedId, like);

    await Future.delayed(Duration(seconds: 1));
    return feedList;
    //end of komoditasList
  }
}
