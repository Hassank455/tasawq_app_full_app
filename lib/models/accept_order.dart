class AcceptOrder {
  late final bool status;
  late final String errNum;
  late final String msg;

  AcceptOrder({
    required this.status,
    required this.errNum,
    required this.msg,
  });

  AcceptOrder.fromJson(Map<String, dynamic> json) {
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
