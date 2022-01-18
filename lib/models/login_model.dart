class ShopLoginModel{
  bool? status;
  String? errNum;
  String? msg;
  User? user;

  ShopLoginModel({this.status, this.errNum, this.msg, this.user});

  ShopLoginModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['errNum'] = this.errNum;
    data['msg'] = this.msg;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    return data;
  }
}


class User {
  int? id;
  String? name;
  String? email;
  String? emailVerifiedAt;
  String? createdAt;
  String? updatedAt;
  int? type;
  int? status;
  String? insurance;
  String? percent;
  String? token;

  User(
      {this.id,
        this.name,
        this.email,
        this.emailVerifiedAt,
        this.createdAt,
        this.updatedAt,
        this.type,
        this.status,
        this.insurance,
        this.percent,
        this.token});

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    type = json['type'];
    status = json['status'];
    insurance = json['insurance'];
    percent = json['percent'];
    token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['email'] = this.email;
    data['email_verified_at'] = this.emailVerifiedAt;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['type'] = this.type;
    data['status'] = this.status;
    data['insurance'] = this.insurance;
    data['percent'] = this.percent;
    data['token'] = this.token;
    return data;
  }
}