import 'package:tik_laen_taswaq2/models/accept_order.dart';
import 'package:tik_laen_taswaq2/models/cancel_order.dart';
import 'package:tik_laen_taswaq2/models/confirm_receive.dart';
import 'package:tik_laen_taswaq2/models/deliver_order.dart';
import 'package:tik_laen_taswaq2/models/request_price.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingHomeDataState extends ShopStates {}

class ShopSuccessHomeDataState extends ShopStates {}

class ShopErrorHomeDataState extends ShopStates {}

class ShopLoadingTodayOrdersState extends ShopStates {}

class ShopSuccessTodayOrdersState extends ShopStates {}

class ShopErrorTodayOrdersState extends ShopStates {}

class ShopLoadingGetTodayOrderState extends ShopStates {}

class ShopSuccessGetTodayOrderState extends ShopStates {}

class ShopErrorGetTodayOrderState extends ShopStates {}

class ShopLoadingPostStartWorkState extends ShopStates {}

class ShopSuccessPostStartWorkState extends ShopStates {}

class ShopErrorPostStartWorkState extends ShopStates {}

class ShopLoadingPostEndWorkState extends ShopStates {}

class ShopSuccessPostEndWorkState extends ShopStates {}

class ShopErrorPostEndWorkState extends ShopStates {}

class ShopLoadingPostStartBalanceState extends ShopStates {}

class ShopSuccessPostStartBalanceState extends ShopStates {}

class ShopErrorPostStartBalanceState extends ShopStates {}

class ShopLoadingAcceptOrderState extends ShopStates {}

class ShopSuccessAcceptOrderState extends ShopStates {
  final AcceptOrder acceptOrder;

  ShopSuccessAcceptOrderState(this.acceptOrder);
}

class ShopErrorAcceptOrderState extends ShopStates {}

class ShopLoadingCancelOrderState extends ShopStates {}

class ShopSuccessCancelOrderState extends ShopStates {
  final CancelOrder cancelOrder;

  ShopSuccessCancelOrderState(this.cancelOrder);
}

class ShopErrorCancelOrderState extends ShopStates {}

class ShopLoadingConfirmReceiveState extends ShopStates {}

class ShopSuccessConfirmReceiveState extends ShopStates {
  final ConfirmReceive confirmReceive;

  ShopSuccessConfirmReceiveState(this.confirmReceive);
}

class ShopErrorConfirmReceiveState extends ShopStates {}

class ShopLoadingRequestPriceState extends ShopStates {}

class ShopSuccessRequestPriceState extends ShopStates {}

class ShopErrorRequestPriceState extends ShopStates {}

class ShopLoadingBalanceState extends ShopStates {}

class ShopSuccessBalanceState extends ShopStates {}

class ShopErrorBalanceState extends ShopStates {}

class ShopLoadingSaveAddressState extends ShopStates {}

class ShopSuccessSaveAddressState extends ShopStates {}

class ShopErrorSaveAddressState extends ShopStates {}

class ShopLoadingDeliverOrderState extends ShopStates {}

class ShopSuccessDeliverOrderState extends ShopStates {}

class ShopErrorDeliverOrderState extends ShopStates {}

class ShopLoadingProfileState extends ShopStates {}

class ShopSuccessProfileState extends ShopStates {}

class ShopErrorProfileState extends ShopStates {}

class ShopLoadingAddInformationState extends ShopStates {}

class ShopSuccessAddInformationState extends ShopStates {}

class ShopErrorAddInformationState extends ShopStates {}

class ShopLoadingTrackState extends ShopStates {}

class ShopSuccessTrackState extends ShopStates {}

class ShopErrorTrackState extends ShopStates {}

/*
class ShopLoadingDeliverOrderState extends ShopStates {}

class ShopSuccessDeliverOrderState extends ShopStates {
  final DeliverOrder deliverOrder;

  ShopSuccessDeliverOrderState(this.deliverOrder);
}

class ShopErrorDeliverOrderState extends ShopStates {}*/
