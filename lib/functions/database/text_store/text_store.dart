import 'package:sembast/sembast.dart';
import 'package:sembast/utils/value_utils.dart';
import 'package:textify_core/models/text_model.dart';
import 'package:textify_core/textify_core.dart';

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
    var key = await _folder.add(await _db, textModel.toMap());
    var record = _folder.record(key);

    record.put(await _db, {"index": "key"}, merge: true);

    final TextModel _model = textModel;
    _model.index = key;

    return _model;
  }

  static Future<TextModel> update(TextModel textModel) async {
    var record = _folder.record(textModel.index);

    record.put(await _db, textModel.toMap(), merge: true);
    return textModel;
  }

  static Future delete(int index) async {
    await _folder.delete(await _db, finder: Finder(filter: Filter.equals("index", index)));
  }
}