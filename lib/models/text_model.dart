part of textify_core;

class TextModel {
  String uuid;
  String title;
  String description;
  DateTime dateTime;
  TextModelContent textModelContent;

  TextModel({
    this.uuid,
    this.title,
    this.description,
    this.dateTime,
    this.textModelContent
  });

  TextModel.fromMap(Map<String, dynamic> map) {
    this.uuid = map["uuid"];
    this.title = map["title"];
    this.description = map["description"];
    this.dateTime = DateTime.parse(map["dateTime"]);
    this.textModelContent = TextModelContent.fromMap(map["textModelContent"]);
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["uuid"] = this.uuid??Uuid().v1();
    map["title"] = this.title;
    map["description"] = this.description;
    map["dateTime"] = this.dateTime;
    map["textModelContent"] = this.textModelContent;

    return map;
  }
}

class TextModelContent {
  List<TextModelInput> inputs;
  String content;

  TextModelContent({
    this.inputs,
    this.content
  });

  TextModelContent.fromMap(Map<String, dynamic> map) {
    List _list = map["inputs"];

    this.inputs = _list.map((e) {
      final TextModelInput _input = TextModelInput.fromMap(e);
      return _input;
    }).toList();
    this.content = map["content"];
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["content"] = this.content;
    map["inputs"] = this.inputs.map((e) {
      final Map<String, dynamic> _input = e.toMap();
      return _input;
    }).toList();

    return map;
  }
}

class TextModelInput {
  String title;
  String description;
  String symbol;

  TextModelInput({
    this.title,
    this.description,
    this.symbol
  });

  TextModelInput.fromMap(Map<String, dynamic> map) {
    this.title = map["title"];
    this.description = map["description"];
    this.symbol = map["symbol"];
  }

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();
    map["title"] = this.title;
    map["description"] = this.description;
    map["symbol"] = this.symbol;

    return map;
  }
}