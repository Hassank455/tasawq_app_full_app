class AddInformationToDialog {
  AddInformationToDialog({
    required this.status,
    required this.errNum,
    required this.msg,
  });
  bool? status;
  String? errNum;
  String? msg;

  AddInformationToDialog.fromJson(Map<String, dynamic> json){
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