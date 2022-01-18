/*
class ConfirmReceive {
  bool? status;
  String? errNum;
  String? msg;
  OrderConfirm? orderConfirm;

  ConfirmReceive({
    this.status,
    this.errNum,
    this.msg,
    this.orderConfirm,
  });

  ConfirmReceive.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    orderConfirm = OrderConfirm.fromJson(json['order']);
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['status'] = status;
    _data['errNum'] = errNum;
    _data['msg'] = msg;
    _data['order'] = orderConfirm!.toJson();
    return _data;
  }
}

class OrderConfirm {
  int? id;
  int? captainId;
  int? fromId;
  int? fromAddress;
  int? toId;
  int? toAddress;
  String? orderTime;
  String? readyTime;
  String? pickTime;
  String? deliveryTime;
  String? price;
  int? deliveryPrice;
  String? paidPrice;
  String? paid;
  String? netPaid;
  int? remain;
  String? createdAt;
  String? updatedAt;
  String? details;
  String? notes;
  int? status;
  String? reason;
  int? priceRequest;

  OrderConfirm({
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
  });

  OrderConfirm.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    captainId = json['captain_id'];
    fromId = json['from_id'];
    fromAddress = json['from_address'];
    toId = json['to_id'];
    toAddress = json['to_address'];
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
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['captain_id'] = captainId;
    _data['from_id'] = fromId;
    _data['from_address'] = fromAddress;
    _data['to_id'] = toId;
    _data['to_address'] = toAddress;
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
    return _data;
  }
}
*/


class ConfirmReceive {
  ConfirmReceive({
    this.status,
    this.errNum,
    this.msg,
    this.order,
  });
  bool? status;
  String? errNum;
  String? msg;
  Order3? order;

  ConfirmReceive.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
    order = json['order'] == null ? null : Order3.fromJson(json['order']);
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

class Order3 {
  Order3({
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
  });
  int? id;
  int? captainId;
  int? fromId;
  int? fromAddress;
  int? toId;
  int? toAddress;
  String? orderTime;
  String? readyTime;
  String? pickTime;
  String? deliveryTime;
  String? price;
  int? deliveryPrice;
  String? paidPrice;
  String? paid;
  String? netPaid;
  String? remain;
  String? createdAt;
  String? updatedAt;
  String? details;
  String? notes;
  int? status;
  String? reason;
  int? priceRequest;

  Order3.fromJson(Map<String, dynamic> json){
    id = json['id'];
    captainId = json['captain_id'];
    fromId = json['from_id'];
    fromAddress = json['from_address'];
    toId = json['to_id'];
    toAddress = json['to_address'];
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
  }

  Map<String, dynamic> toJson() {
    final _data = <String, dynamic>{};
    _data['id'] = id;
    _data['captain_id'] = captainId;
    _data['from_id'] = fromId;
    _data['from_address'] = fromAddress;
    _data['to_id'] = toId;
    _data['to_address'] = toAddress;
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
    return _data;
  }
}