/*
class DetailsOrder {
  bool? status;
  String? errNum;
  String? msg;
  Order? order;

  DetailsOrder({
    this.status,
    this.errNum,
    this.msg,
    this.order,
  });



  DetailsOrder.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    order = Order.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['order'] = order!.toJson();
    return _data;
  }
}

class Order {
  int? id;
  int? captainId;
  FromId? fromId;
  String? fromAddress;
  ToId? toId;
  String? toAddress;
  String? orderTime;
  String? readyTime;
  String? pickTime;
  String? deliveryTime;
  String? price;
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

  Order({
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
  });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainId = json['captain_id'];
    fromId = FromId.fromJson(json['from_id']);
    fromAddress = null;
    toId = ToId.fromJson(json['to_id']);
    toAddress = null;
    orderTime = json['order_time'];
    readyTime = json['ready_time'];
    pickTime = null;
    deliveryTime = json['delivery_time'];
    price = json['price'];
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
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['captain_id'] = captainId;
    _data['from_id'] = fromId!.toJson();
    _data['from_address'] = fromAddress;
    _data['to_id'] = toId!.toJson();
    _data['to_address'] = toAddress;
    _data['order_time'] = orderTime;
    _data['ready_time'] = readyTime;
    _data['pick_time'] = pickTime;
    _data['delivery_time'] = deliveryTime;
    _data['price'] = price;
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
    return _data;
  }
}

class FromId {
  int? id;
  String? name;
  String? mobile1;
  String? mobile2;
  String? mobile3;
  String? mobile4;
  String? email;
  String? createdAt;
  String? updatedAt;

  FromId({
    this.id,
    this.name,
    this.mobile1,
    this.mobile2,
    this.mobile3,
    this.mobile4,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  FromId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    mobile3 = json['mobile3'];
    mobile4 = json['mobile4'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return _data;
  }
}

class ToId {
  int? id;
  String? name;
  String? mobile1;
  String? mobile2;
  String? mobile3;
  String? mobile4;
  String? email;
  String? createdAt;
  String? updatedAt;

  ToId({
    this.id,
    this.name,
    this.mobile1,
    this.mobile2,
    this.mobile3,
    this.mobile4,
    this.email,
    this.createdAt,
    this.updatedAt,
  });

  ToId.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    mobile1 = json['mobile1'];
    mobile2 = json['mobile2'];
    mobile3 = json['mobile3'];
    mobile4 = json['mobile4'];
    email = json['email'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
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
    return _data;
  }
}*/
