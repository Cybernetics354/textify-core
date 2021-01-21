part of textify_core;

class AppDatabase {
  static final AppDatabase _singleton = AppDatabase._();

  static AppDatabase get instance => _singleton;

  Completer<Database> _dbOpenCompleter;

  AppDatabase._();

  Future<Database> get database async {
    if(_dbOpenCompleter == null) {
      _dbOpenCompleter = Completer();
      _openDatabase();
    }

    return _dbOpenCompleter.future;
  }

  Future _openDatabase() async {
    final appDocumentDir = await getApplicationDocumentsDirectory();
    final dbPath = join(appDocumentDir.path, "database.db");

    final database = await databaseFactoryIo.openDatabase(dbPath);  

    _dbOpenCompleter.complete(database);
  }
}