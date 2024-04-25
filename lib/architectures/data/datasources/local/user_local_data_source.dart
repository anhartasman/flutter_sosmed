import 'package:fluttersosmed/architectures/data/datasources/local/DbHelper.dart';
import 'package:fluttersosmed/architectures/domain/entities/UserProfile.dart';

class UserLocalDataSource {
  static Future<UserProfile> getUser(int id) async {
    final DbHelper helper = DbHelper();
    final feedList = await helper.getUser(id);

    return feedList;
    //end of komoditasList
  }
}
