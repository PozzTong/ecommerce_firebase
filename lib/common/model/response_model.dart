// class ResponseModel {
//   final bool _status;
//   final String _message;
//   final String _responseJson;
//   ResponseModel(this._status, this._message, this._responseJson);

//   bool get status => _status;
//   String get message => _message;
//   String get responseJson => _responseJson;
// }

// class FirebaseResponseModel {
//   FirebaseResponseModel({
//     String? kind,
//     String? localId,
//     String? email,
//     String? displayName,
//     String? idToken,
//     bool? registered,
//   }) {
//     _kind = kind;
//     _localId = localId;
//     _email = email;
//     _displayName = displayName;
//     _idToken = idToken;
//     _registered = registered;
//   }
//   FirebaseResponseModel.fromJson(dynamic json) {
//     _kind = json['kind'].toString();
//     _localId = json['localId'].toString();
//     _email = json['email'].toString();
//     _displayName = json['displayName'].toString();
//     _idToken = json['idToken'].toString();
//     _registered = json['registered'];
//   }
//   String? _kind;
//   String? _localId;
//   String? _email;
//   String? _displayName;
//   String? _idToken;
//   bool? _registered;

//   String? get kind => _kind;
//   String? get localId => _localId;
//   String? get email => _email;
//   String? get displayName => _displayName;
//   String? get idToken => _idToken;
//   bool? get registered => _registered;

//   Map<String, dynamic> toJson() {
//     final map = <String, dynamic>{};
//     map['kind'] = _kind;
//     map['localId'] = _localId;
//     map['email'] = _email;
//     map['displayName'] = _displayName;
//     map['idToken'] = _idToken;
//     map['registered'] = _registered;
//     return map;
//   }
// }
