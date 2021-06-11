import 'dart:convert';


String intString(int number){
  final map = Map<String, String>();
  map['type'] = 'int';
  map['data'] = number.toString();
  return jsonEncode(map);
}

String doubleString(double number){
  final map = Map<String, String>();
  map['type'] = 'double';
  map['data'] = number.toString();
  return jsonEncode(map);
}

String stringString(String string){
  final map = Map<String, String>();
  map['type'] = 'String';
  map['data'] = string.toString();
  return jsonEncode(map);
}

String boolString(bool boolean){
  final map = Map<String, String>();
  map['type'] = 'bool';
  map['data'] = boolean.toString();
  return jsonEncode(map);
}




