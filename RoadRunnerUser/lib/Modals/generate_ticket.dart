/// code : 0
/// msg : "Generate Successfully"

class GenerateTicket {
  GenerateTicket({
      int code, 
      String msg,}){
    _code = code;
    _msg = msg;
}

  GenerateTicket.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }
  GenerateTicket.withError(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
  }

  int _code;
  String _msg;

  int get code => _code;
  String get msg => _msg;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    return map;
  }

}