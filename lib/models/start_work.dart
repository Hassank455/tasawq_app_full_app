class StartWork {

  bool? status;
  String? errNum;
  String? msg;

  StartWork({
     this.status,
     this.errNum,
     this.msg,
  });


  StartWork.fromJson(Map<String, dynamic> json){
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