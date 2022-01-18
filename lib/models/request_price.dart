class RequestPrice {
  bool? status;
  String? errNum;
  String? msg;

  RequestPrice({
    required this.status,
    required this.errNum,
    required this.msg,
  });

  RequestPrice.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    return _data;
  }
}
