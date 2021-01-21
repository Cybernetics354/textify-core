part of textify_core;

class TextStoreRepository {
  static final _folderName = "textStoreRepository";
  static final _folder = intMapStoreFactory.store(_folderName);

  static Future<Database> get _db async {
    return await AppDatabase.instance.database;
  }

  static Future<List<TextModel>> getAll() async {
    var res = await _folder.find(await _db);

    return res.map((e) {
      final _copy = cloneMap(e.value);
      return TextModel.fromMap(_copy);
    }).toList();
  }

  static Future<TextModel> insert(TextModel textModel) async {
    await _folder.add(await _db, textModel.toMap());
    return textModel;
  }

  static Future<TextModel> update(TextModel textModel) async {
    _folder.update(await _db, textModel.toMap(), finder: Finder(filter: Filter.equals("uuid", textModel.uuid)));
    return textModel;
  }

  static Future delete(int index) async {
    await _folder.delete(await _db, finder: Finder(filter: Filter.equals("index", index)));
  }
}