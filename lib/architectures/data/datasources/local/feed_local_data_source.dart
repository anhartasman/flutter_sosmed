import 'package:faker/faker.dart';
import 'package:fluttersosmed/architectures/data/datasources/local/DbHelper.dart';
import 'package:fluttersosmed/architectures/domain/entities/FeedSearch.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserFeed.dart';
import 'package:fluttersosmed/helpers/util_int.dart';

class FeedLocalDataSource {
  static Future<List<UserFeed>> userFeed(FeedSearch feedSearch) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.getUserFeed(id: feedSearch.userId);

    return feedList;
    //end of komoditasList
  }
}
