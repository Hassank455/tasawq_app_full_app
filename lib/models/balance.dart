class Balance {
  Balance({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.balance,
  });
  bool? status;
  String? errNum;
  String? msg;
  List<String>? balance;

  Balance.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    balance = List.castFrom<dynamic, String>(json['balance']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['balance'] = balance;
    return _data;
  }
}