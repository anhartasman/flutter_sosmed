class UserQuery {
  static const String TABLE_NAME = "tb_user";
  static const String CREATE_TABLE =
      " CREATE TABLE IF NOT EXISTS $TABLE_NAME ( id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, profilePict TEXT, coverPict TEXT, followed INTEGER, job TEXT ) ";
  static const String SELECT = "select * from $TABLE_NAME";
}
