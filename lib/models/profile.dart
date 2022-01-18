class Profile {
  Profile({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.user,
  });
  bool? status;
  String? errNum;
  String? msg;
  User? user;

  Profile.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    user = json['user']  == null ? null : User.fromJson(json['user']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['user'] = user!.toJson();
    return _data;
  }
}

class User {
  User({
    required this.id,
    required this.name,
    required this.email,
    required this.username,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.type,
    required this.status,
    required this.insurance,
    required this.percent,
    this.identity,
    this.marital,
    this.mobile,
    this.urgentName,
    this.urgentType,
    this.urgentMobile,
    required this.startBalance,
    required this.address,
  });
  int? id;
  String? name;
  String? email;
  String? username;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? type;
  int? status;
  String? insurance;
  String? percent;
  String? identity;
  String? marital;
  String? mobile;
  String? urgentName;
  String? urgentType;
  String? urgentMobile;
  String? startBalance;
  String? address;

  User.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    username = json['username'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    status = json['status'];
    insurance = json['insurance'];
    percent = json['percent'];
    identity = json['identity'];
    marital = json['marital'];
    mobile = json['mobile'];
    urgentName = json['urgent_name'];
    urgentType = json['urgent_type'];
    urgentMobile = json['urgent_mobile'];
    startBalance = json['start_balance'];
    address = json['address'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['email'] = email;
    _data['username'] = username;
    _data['email_verified_at'] = emailVerifiedAt;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['type'] = type;
    _data['status'] = status;
    _data['insurance'] = insurance;
    _data['percent'] = percent;
    _data['identity'] = identity;
    _data['marital'] = marital;
    _data['mobile'] = mobile;
    _data['urgent_name'] = urgentName;
    _data['urgent_type'] = urgentType;
    _data['urgent_mobile'] = urgentMobile;
    _data['start_balance'] = startBalance;
    _data['address'] = address;
    return _data;
  }
}