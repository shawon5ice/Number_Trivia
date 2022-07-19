/// text : "45 is the sapphire wedding anniversary in years of marriage."
/// number : 45
/// found : true
/// type : "trivia"

class NumberTrivia {
  NumberTrivia({
      String? text, 
      int? number, 
      bool? found, 
      String? type,}){
    _text = text;
    _number = number;
    _found = found;
    _type = type;
}

  NumberTrivia.fromJson(dynamic json) {
    _text = json['text'];
    _number = json['number'];
    _found = json['found'];
    _type = json['type'];
  }
  String? _text;
  int? _number;
  bool? _found;
  String? _type;
NumberTrivia copyWith({  String? text,
  int? number,
  bool? found,
  String? type,
}) => NumberTrivia(  text: text ?? _text,
  number: number ?? _number,
  found: found ?? _found,
  type: type ?? _type,
);
  String? get text => _text;
  int? get number => _number;
  bool? get found => _found;
  String? get type => _type;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['text'] = _text;
    map['number'] = _number;
    map['found'] = _found;
    map['type'] = _type;
    return map;
  }

}