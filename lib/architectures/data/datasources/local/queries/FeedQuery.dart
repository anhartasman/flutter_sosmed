class FeedQuery {
  static const String TABLE_NAME = "tb_feed";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, userId INTEGER, feedContent TEXT, name TEXT, pict TEXT, created TEXT, isLiked INTEEGER ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
