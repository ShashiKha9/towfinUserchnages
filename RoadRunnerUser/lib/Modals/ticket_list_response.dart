/// code : 0
/// msg : "Generate Successfully"
/// data : [{"id":"1","user_id":"1","subject":"ticket one","description":"description","status":"open","created_at":"2021-10-14 21:48:25","updated_at":"2021-10-14 21:48:25"},{"id":"2","user_id":"1","subject":"ticket one","description":"description","status":"open","created_at":"2021-10-14 21:55:01","updated_at":"2021-10-14 21:55:01"},{"id":"3","user_id":"1","subject":"ticket one","description":"description","status":"open","created_at":"2021-10-18 04:53:51","updated_at":"2021-10-18 04:53:51"},{"id":"4","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-18 11:08:16","updated_at":"2021-10-18 11:08:16"},{"id":"5","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 06:10:14","updated_at":"2021-10-19 06:10:14"},{"id":"6","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 06:10:16","updated_at":"2021-10-19 06:10:16"},{"id":"7","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 06:10:16","updated_at":"2021-10-19 06:10:16"},{"id":"8","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 06:10:27","updated_at":"2021-10-19 06:10:27"},{"id":"9","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 07:08:39","updated_at":"2021-10-19 07:08:39"},{"id":"10","user_id":"1","subject":"a","description":"b","status":"open","created_at":"2021-10-19 08:27:17","updated_at":"2021-10-19 08:27:17"},{"id":"11","user_id":"1","subject":"rty","description":"hhhjj","status":"open","created_at":"2021-10-19 08:34:29","updated_at":"2021-10-19 08:34:29"},{"id":"12","user_id":"1","subject":"d","description":"c","status":"open","created_at":"2021-10-20 09:32:26","updated_at":"2021-10-20 09:32:26"},{"id":"13","user_id":"1","subject":"rhh","description":"hj b","status":"open","created_at":"2021-10-20 09:37:40","updated_at":"2021-10-20 09:37:40"},{"id":"14","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:38:18","updated_at":"2021-10-20 09:38:18"},{"id":"15","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:43:45","updated_at":"2021-10-20 09:43:45"},{"id":"16","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:43:55","updated_at":"2021-10-20 09:43:55"},{"id":"17","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:45:30","updated_at":"2021-10-20 09:45:30"},{"id":"18","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:46:13","updated_at":"2021-10-20 09:46:13"},{"id":"19","user_id":"1","subject":"hfy","description":"fhchc","status":"open","created_at":"2021-10-20 09:56:45","updated_at":"2021-10-20 09:56:45"}]

class Ticket_list_response {
  Ticket_list_response({
      int code, 
      String msg, 
      List<Data> data,}){
    _code = code;
    _msg = msg;
    _data = data;
}

  Ticket_list_response.fromJson(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  Ticket_list_response.withError(dynamic json) {
    _code = json['code'];
    _msg = json['msg'];
    if (json['data'] != null) {
      _data = [];
      json['data'].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }
  int _code;
  String _msg;
  List<Data> _data;

  int get code => _code;
  String get msg => _msg;
  List<Data> get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['code'] = _code;
    map['msg'] = _msg;
    if (_data != null) {
      map['data'] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

/// id : "1"
/// user_id : "1"
/// subject : "ticket one"
/// description : "description"
/// status : "open"
/// created_at : "2021-10-14 21:48:25"
/// updated_at : "2021-10-14 21:48:25"

class Data {
  Data({
      String id, 
      String userId, 
      String subject, 
      String description, 
      String status, 
      String createdAt, 
      String updatedAt,}){
    _id = id;
    _userId = userId;
    _subject = subject;
    _description = description;
    _status = status;
    _createdAt = createdAt;
    _updatedAt = updatedAt;
}

  Data.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _subject = json['subject'];
    _description = json['description'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _updatedAt = json['updated_at'];
  }
  String _id;
  String _userId;
  String _subject;
  String _description;
  String _status;
  String _createdAt;
  String _updatedAt;

  String get id => _id;
  String get userId => _userId;
  String get subject => _subject;
  String get description => _description;
  String get status => _status;
  String get createdAt => _createdAt;
  String get updatedAt => _updatedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['subject'] = _subject;
    map['description'] = _description;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['updated_at'] = _updatedAt;
    return map;
  }

}