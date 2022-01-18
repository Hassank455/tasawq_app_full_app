
class DeliverOrder {
  DeliverOrder({
    required this.status,
    required this.errNum,
    required this.msg,
    required this.order,
  });
  bool? status;
  String? errNum;
  String? msg;
  Order2? order;

  DeliverOrder.fromJson(Map<String, dynamic> json){
    status = json['status'];
    errNum = json['errNum'];
    msg = json['msg'];
   // order = Order2.fromJson(json['order']);
    order = json['order'] == null ? null : Order2.fromJson(json['order']);
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

class Order2 {
  Order2({
    required this.id,
    required this.captainId,
    required this.fromId,
    required this.fromAddress,
    required this.toId,
    required this.toAddress,
    this.orderTime,
    required this.readyTime,
    this.pickTime,
    required this.deliveryTime,
    required this.price,
    required this.paidPrice,
    required this.paid,
    required this.netPaid,
    required this.remain,
    required this.createdAt,
    required this.updatedAt,
    this.details,
    this.notes,
    required this.status,
    required this.reason,
    required this.priceRequest,
    this.fromMobile,
    this.toMobile,
    required this.remainClient,
    required this.remainCaptain,
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
  String? fromMobile;
  String? toMobile;
  String? remainClient;
  int? remainCaptain;

  Order2.fromJson(Map<String, dynamic> json){
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
    paidPrice = json['paid_price'];
    paid = json['paid'];
    netPaid = json['net_paid'];
    remain = json['remain'];
   // remain = json['remain'] == null ? null : json['remain'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    details = json['details'];
    notes = json['notes'];
    status = json['status'];
    reason = json['reason'];
    priceRequest = json['price_request'];
    fromMobile = json['from_mobile'];
    toMobile = json['to_mobile'];
    remainClient = json['remain_client'];
    remainCaptain = json['remain_captain'];
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
    _data['remain_client'] = remainClient;
    _data['remain_captain'] = remainCaptain;
    return _data;
  }
}
