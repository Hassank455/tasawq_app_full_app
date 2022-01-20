class NewOrder {
  NewOrder({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.order2,
  });
  late final bool? status;
  late final String? errNum;
  late final String? msg;
  List<Order4>? order2 = [];

  NewOrder.fromJson(Map<String?, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    //order2 = List.from(json['order']).map((e)=>Order4.fromJson(e)).toList();
    json['order'].forEach((element) {
      order2!.add(Order4.fromJson(element));
    });
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['order'] = order2!.map((e)=>e.toJson()).toList();
    return _data;
  }
}

class Order4 {
  Order4({
     this.id,
     this.captainId,
     this.fromId,
    this.fromAddress,
     this.toId,
     this.toAddress,
    this.orderTime,
     this.readyTime,
     this.pickTime,
     this.deliveryTime,
     this.price,
    this.deliveryPrice,
     this.paidPrice,
     this.paid,
     this.netPaid,
     this.remain,
     this.createdAt,
     this.updatedAt,
    this.details,
     this.notes,
     this.status,
    this.reason,
     this.priceRequest,
     this.fromMobile,
    this.toMobile,
   //  this.remainClient,
   //  this.remainCaptain,
     this.fromBalance,
     this.toBalance,
  });
  int? id;
  int? captainId;
  FromId2? fromId;
  FromAddress? fromAddress;
  ToId? toId;
  ToAddress? toAddress;
  String? orderTime;
  String? readyTime;
  String? pickTime;
  String? deliveryTime;
  String? price;
  int? deliveryPrice;
  String? paidPrice;
  int? paid;
  String? netPaid;
  String? remain;
  String? createdAt;
  String? updatedAt;
  String? details;
  String? notes;
  int? status;
  String? reason;
  int? priceRequest;
  String? fromMobile;
  String? toMobile;
  // String? remainClient;
  // int? remainCaptain;
  late final FromBalance? fromBalance;
  late final ToBalance? toBalance;

  Order4.fromJson(Map<String, dynamic> json){
    id = json['id'];
    captainId = json['captain_id'];
    fromId = json['from_id'] == null ? null : FromId2.fromJson(json['from_id']);
    fromAddress = json['from_address'] == null
        ? null
        : FromAddress.fromJson(json['from_address']);
    toId = json['to_id'] == null ? null : ToId.fromJson(json['to_id']);
    toAddress = json['to_address'] == null
        ? null
        : ToAddress.fromJson(json['to_address']);
    orderTime = json['order_time'];
    readyTime = json['ready_time'];
    pickTime = json['pick_time'];
    deliveryTime = json['delivery_time'];
    price = json['price'];
    deliveryPrice = json['delivery_price'];
    paidPrice = json['paid_price'];
    paid = json['paid'];
    netPaid = json['net_paid'];
    remain = json['remain'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    details = json['details'];
    notes = json['notes'];
    status = json['status'];
    reason = json['reason'];
    priceRequest = json['price_request'];
    fromMobile = json['from_mobile'] == null ? null : json['from_mobile'];
    toMobile = json['to_mobile'] == null ? null : json['to_mobile'];
    //  remainClient = json['remain_client'];
    //  remainCaptain = json['remain_captain'];
    fromBalance = json['from_balance'] == null
        ? null
        : FromBalance.fromJson(json['from_balance']);
    toBalance = json['to_balance'] == null
        ? null
        : ToBalance.fromJson(json['to_balance']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['captain_id'] = captainId;
    _data['from_id'] = fromId!.toJson();
    _data['from_address'] = fromAddress?.toJson();
    _data['to_id'] = toId!.toJson();
    _data['to_address'] = toAddress!.toJson();
    _data['order_time'] = orderTime;
    _data['ready_time'] = readyTime;
    _data['pick_time'] = pickTime;
    _data['delivery_time'] = deliveryTime;
    _data['price'] = price;
    _data['delivery_price'] = deliveryPrice;
    _data['paid_price'] = paidPrice;
    _data['paid'] = paid;
    _data['net_paid'] = netPaid;
    _data['remain'] = remain;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['details'] = details;
    _data['notes'] = notes;
    _data['status'] = status;
    _data['reason'] = reason;
    _data['price_request'] = priceRequest;
    _data['from_mobile'] = fromMobile;
    _data['to_mobile'] = toMobile;
   // _data['remain_client'] = remainClient!;
   // _data['remain_captain'] = remainCaptain;
    _data['from_balance'] = fromBalance!.toJson();
    _data['to_balance'] = toBalance!.toJson();
    return _data;
  }
}

class FromAddress {
  FromAddress({
    this.id,
    this.address,
    this.name,
    this.clientId,
    this.lat,
    this.lng,
    this.mobile,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  String? address;
  String? name;
  int? clientId;
  String? lat;
  String? lng;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  FromAddress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    address = json['address'];
    name = json['name'];
    clientId = json['client_id'];
    lat = json['lat'];
    lng = json['lng'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['address'] = address;
    _data['name'] = name;
    _data['client_id'] = clientId;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['mobile'] = mobile;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}

class FromId2 {
  FromId2({
    required this.id,
    required this.name,
    required this.mobile1,
    this.mobile2,
    this.mobile3,
    this.mobile4,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.groupId,
  });
  int? id;
  String? name;
  String? mobile1;
  String? mobile2;
  String? mobile3;
  String? mobile4;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? groupId;

  FromId2.fromJson(Map<String?, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    mobile3 = json['mobile3'];
    mobile4 = json['mobile4'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupId = json['group_id'];
  }

  Map<String?, dynamic> toJson() {
    final _data = <String?, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile1'] = mobile1;
    _data['mobile2'] = mobile2;
    _data['mobile3'] = mobile3;
    _data['mobile4'] = mobile4;
    _data['email'] = email;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['group_id'] = groupId;
    return _data;
  }
}

class ToId {
  ToId({
    required this.id,
    required this.name,
    required this.mobile1,
    this.mobile2,
    this.mobile3,
    this.mobile4,
    this.email,
    required this.createdAt,
    required this.updatedAt,
    required this.groupId,
  });
  int? id;
  String? name;
  String? mobile1;
  String? mobile2;
  String? mobile3;
  String? mobile4;
  String? email;
  String? createdAt;
  String? updatedAt;
  int? groupId;

  ToId.fromJson(Map<String, dynamic> json){
    id = json['id'];
    name = json['name'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    mobile3 = json['mobile3'];
    mobile4 = json['mobile4'];
    email = json['mobile1'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    groupId = json['group_id'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['name'] = name;
    _data['mobile1'] = mobile1;
    _data['mobile2'] = mobile2;
    _data['mobile3'] = mobile3;
    _data['mobile4'] = mobile4;
    _data['email'] = email;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    _data['group_id'] = groupId;
    return _data;
  }
}

class ToAddress {
  ToAddress({
    required this.id,
    required this.address,
    this.name,
    required this.clientId,
    required this.lat,
    required this.lng,
    this.mobile,
    required this.createdAt,
    required this.updatedAt,
  });
  int? id;
  String? address;
  String? name;
  int? clientId;
  String? lat;
  String? lng;
  String? mobile;
  String? createdAt;
  String? updatedAt;

  ToAddress.fromJson(Map<String?, dynamic> json){
    id = json['id'];
    address = json['address'];
    name = json['name'];
    clientId = json['client_id'];
    lat = json['lat'];
    lng = json['lng'];
    mobile = json['mobile'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['address'] = address;
    _data['name'] = name;
    _data['client_id'] = clientId;
    _data['lat'] = lat;
    _data['lng'] = lng;
    _data['mobile'] = mobile;
    _data['created_at'] = createdAt;
    _data['updated_at'] = updatedAt;
    return _data;
  }
}


class ToBalance {
  ToBalance({
    required this.balance,
  });
  late final int balance;

  ToBalance.fromJson(Map<String, dynamic> json){
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    return _data;
  }
}
class FromBalance {
  FromBalance({
    required this.balance,
  });
  late final int balance;

  FromBalance.fromJson(Map<String, dynamic> json){
    balance = json['balance'];
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['balance'] = balance;
    return _data;
  }
}