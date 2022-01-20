import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:logger/logger.dart';
import 'package:tik_laen_taswaq2/layout/cubit/states.dart';
import 'package:tik_laen_taswaq2/models/accept_order.dart';
import 'package:tik_laen_taswaq2/models/add_information_to_dialog.dart';
import 'package:tik_laen_taswaq2/models/balance.dart';
import 'package:tik_laen_taswaq2/models/cancel_order.dart';
import 'package:tik_laen_taswaq2/models/confirm_receive.dart';
import 'package:tik_laen_taswaq2/models/deliver_order.dart';
import 'package:tik_laen_taswaq2/models/details_order.dart';
import 'package:tik_laen_taswaq2/models/end_work.dart';
import 'package:tik_laen_taswaq2/models/new_order.dart';
import 'package:tik_laen_taswaq2/models/profile.dart';
import 'package:tik_laen_taswaq2/models/request_price.dart';
import 'package:tik_laen_taswaq2/models/save_address.dart';
import 'package:tik_laen_taswaq2/models/start_balance.dart';
import 'package:tik_laen_taswaq2/models/start_work.dart';
import 'package:tik_laen_taswaq2/models/today_orders.dart';
import 'package:tik_laen_taswaq2/modules/home_screen/home_screen.dart';
import 'package:tik_laen_taswaq2/modules/order_screen.dart';
import 'package:tik_laen_taswaq2/modules/profile_screen.dart';
import 'package:tik_laen_taswaq2/shared/components/constants.dart';
import 'package:tik_laen_taswaq2/shared/network/end_points.dart';
import 'package:tik_laen_taswaq2/shared/network/remote/dio_helper.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);

  int currentIndex = 1;
  List<Widget> widgetOptions = <Widget>[
    ProfileScrren(),
    HomeScreen(),
    OrderScreen(),
  ];

  void changeItem(int value) {
    currentIndex = value;
    emit(ShopChangeBottomNavState());
  }

  TodayOrder? todayOrders;
  Future<void> getTodayOrder() async {
    emit(ShopLoadingTodayOrdersState());
    DioHelper.getData(
      url: TODAY_ORDER,
      token: 'Bearer $token',
    ).then((value) {
   // Logger().e("***********************************");
//Logger().e(value.data);
      //print(value.data);
      todayOrders = TodayOrder.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessTodayOrdersState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorTodayOrdersState());
    });
  }

  NewOrder? newOrders;
  Future<void> getNewOrder() async {
    emit(ShopLoadingNewOrdersState());
    DioHelper.getData(
      url: NEW_ORDER,
      token: 'Bearer $token',
    ).then((value) {
      // Logger().e("***********************************");
//Logger().e(value.data);
      //print(value.data);
      newOrders = NewOrder.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessNewOrdersState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorNewOrdersState());
    });
  }

  StartWork? startWork;

  void postStartWork() {
    emit(ShopLoadingPostStartWorkState());

    DioHelper.postData(
      url: START_WORK,
      token: 'Bearer $token',
    ).then((value) {
      startWork = StartWork.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessPostStartWorkState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorPostStartWorkState());
    });
  }

  EndWork? endWork;

  void postEndWork() {
    emit(ShopLoadingPostEndWorkState());

    DioHelper.postData(
      url: CLOSE_WORK,
      token: 'Bearer $token',
    ).then((value) {
      endWork = EndWork.fromJson(value.data);
      //endWork!.status = false;
      print(value.data.toString());
      emit(ShopSuccessPostEndWorkState());
    }).catchError((error) {
      print('!!!!!!!!!!!!! ${error.toString()}');
      emit(ShopErrorPostEndWorkState());
    });
  }

  StartBalance? startBalance;

  void postStartBalance(String price) {
    emit(ShopLoadingPostStartBalanceState());

    DioHelper.postData(
      url: START_BALANCE,
      token: 'Bearer $token',
      query: {'balance': price},
    ).then((value) {
      startBalance = StartBalance.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessPostStartBalanceState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorPostStartBalanceState());
    });
  }

  AcceptOrder? acceptOrder;

  void postAcceptOrder(int id) {
    emit(ShopLoadingAcceptOrderState());

    DioHelper.postData(
      url: ACCEPT_ORDER,
      token: 'Bearer $token',
      query: {'id': id},
    ).then((value) {
      acceptOrder = AcceptOrder.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessAcceptOrderState(acceptOrder!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAcceptOrderState());
    });
  }

  CancelOrder? cancelOrder;

  void postCancelOrder(int id, String reason) {
    emit(ShopLoadingCancelOrderState());

    DioHelper.postData(
      url: CANCEL_ORDER,
      token: 'Bearer $token',
      query: {
        'id': id,
        'reason': reason,
      },
    ).then((value) {
      cancelOrder = CancelOrder.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessCancelOrderState(cancelOrder!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorCancelOrderState());
    });
  }

  ConfirmReceive? confirmReceive;

  void postConfirmReceive(int id, String price, String paidPrice, int paid, String lat, String lng) {
    emit(ShopLoadingConfirmReceiveState());

    DioHelper.postData(
      url: CONFIRM_RECEIVE,
      token: 'Bearer $token',
      query: {
        'id': id,
        'price': price,
        'paid_price': paidPrice,
        'paid': paid,
        'lat': lat,
        'lng': lng,
      },
    ).then((value) {
      confirmReceive = ConfirmReceive.fromJson(value.data);
      print('33333333333');
      print(value.data.toString());
      emit(ShopSuccessConfirmReceiveState(confirmReceive!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorConfirmReceiveState());
    });
  }

  RequestPrice? requestPrice;

  void getRequestPrice(int id, String notes) {
    emit(ShopLoadingRequestPriceState());
    DioHelper.getData(
      url: REQUEST_PRICE,
      token: 'Bearer $token',
      query: {
        'id': id,
        'notes': notes,
      },
    ).then((value) {
      requestPrice = RequestPrice.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessRequestPriceState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorRequestPriceState());
    });
  }

  Balance? balance;

  void getBalance() {
    emit(ShopLoadingBalanceState());
    DioHelper.getData(
      url: BALANCE,
      token: 'Bearer $token',
    ).then((value) {
      balance = Balance.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessBalanceState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorBalanceState());
    });
  }

  SaveAddress? saveAddress;

  void postSaveAddress(int id, double lat, double lng) {
    emit(ShopLoadingSaveAddressState());

    DioHelper.postData(
      url: SAVE_ADDRESS,
      token: 'Bearer $token',
      query: {
        'id': id,
        'lat': lat,
        'lng': lng,
      },
    ).then((value) {
      saveAddress = SaveAddress.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessSaveAddressState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorSaveAddressState());
    });
  }

  // DeliverOrder? deliverOrder;
  DeliverOrder? deliverOrder;

  void postDeliverOrder(int id, String netPaid, String remainClient,String paidPrice,String lat,String lng) {
    emit(ShopLoadingDeliverOrderState());

    DioHelper.postData(
      url: DELIVERY_ORDER,
      token: 'Bearer $token',
      query: {
        'id': id,
        'net_paid': netPaid,
        'remain_client': remainClient,
        'paid_price': paidPrice,
        'lat': lat,
        'lng': lng,
      },
    ).then((value) {
      deliverOrder = DeliverOrder.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessDeliverOrderState());
    }).catchError((error) {
      print('error###');
      print(error.toString());
      emit(ShopErrorDeliverOrderState());
    });
  }

  Profile? profile;

  void getProfile() {
    emit(ShopLoadingProfileState());
    DioHelper.getData(
      url: PROFILE,
      token: 'Bearer $token',
    ).then((value) {
      //print(value.data);
      profile = Profile.fromJson(value.data);
      print(value.data);
      emit(ShopSuccessProfileState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorProfileState());
    });
  }

  AddInformationToDialog? addInformationToDialog;

  void postAddInformation(
      {int? id, String? name, String? mobile, String? address, String? lat, String? lng}) {
    emit(ShopLoadingAddInformationState());

    DioHelper.postData(
      url: ADD_INFORMATION,
      token: 'Bearer $token',
      query: {
        'order_id': id,
        'name': name,
        'address': address,
        'mobile': mobile,
        'lat': lat,
        'lng': lng,
      },
    ).then((value) {
      addInformationToDialog = AddInformationToDialog.fromJson(value.data);
      print(value.data.toString());
      emit(ShopSuccessAddInformationState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorAddInformationState());
    });
  }


  void postTrackUser(
      {int? id, String? lat, String? lng}) {
    emit(ShopLoadingAddInformationState());

    DioHelper.postData(
      url: TRACK,
      token: 'Bearer $token',
      query: {
        'order_id': id,
        'lat': lat,
        'lng': lng,
      },
    ).then((value) {
      print(value.data.toString());
      emit(ShopSuccessTrackState());
    }).catchError((error) {
      print(error.toString());
       emit(ShopErrorTrackState());
    });
  }


  Future<void> postUserTrack(
      ) async {
    emit(ShopLoadingTrackState());

    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    DioHelper.postData(
      url: User_LOCATION,
      token: 'Bearer $token',
      query: {
        'lat': position.latitude,
        'lng': position.longitude,
      },
    ).then((value)  {
      print('the position is ');
      print(position);
      print(value.data.toString());
      emit(ShopSuccessTrackState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopErrorTrackState());
    });
  }

}
