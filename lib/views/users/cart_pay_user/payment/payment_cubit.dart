import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gaza_shop/views/users/cart_pay_user/payment/pyment_requst_model.dart';
import 'package:gaza_shop/views/users/cart_pay_user/payment/state.dart';

import '../../../../core/utils/constant.dart';
import 'auth_requst.dart';
import 'dio.dart';
import 'order_reg.dart';


class PaymentCubit extends Cubit<PaymentStates> {
  PaymentCubit() : super(PaymentInitialStates());
  static PaymentCubit get(context) => BlocProvider.of(context);
  AuthenticationRequestModel? authTokenModel;
  Future<void> getAuthToken() async {
    emit(PaymentAuthLoadingStates());
    DioHelperPayment.postData(url: ConstantStayles.getAuthToken, data: {
      'api_key': ConstantStayles.paymentApiKey,
    }).then((value) {
      authTokenModel = AuthenticationRequestModel.fromJson(value.data);
      ConstantStayles.paymentFirstToken = authTokenModel!.token;
      print('The token 🍅');
      emit(PaymentAuthSuccessStates());
    }).catchError((error) {
      print('Error in auth token 🤦‍♂️');
      emit(
        PaymentAuthErrorStates(error.toString()),
      );
    });
  }

  Future getOrderRegistrationID({
    required String price,
    required String firstName,
    required String lastName,
    required String email,
    required String phone,
  }) async {
    emit(PaymentOrderIdLoadingStates());
    DioHelperPayment.postData(url: ConstantStayles.getOrderId, data: {
      'auth_token': ConstantStayles.paymentFirstToken,
      "delivery_needed": "false",
      "amount_cents": price,
      "currency": "EGP",
      "items": [],
    }).then((value) {
      OrderRegistrationModel orderRegistrationModel =
      OrderRegistrationModel.fromJson(value.data);
      ConstantStayles.paymentOrderId = orderRegistrationModel.id.toString();
      getPaymentRequest(price, firstName, lastName, email, phone);
      print('The order id 🍅 =${ConstantStayles.paymentOrderId}');
      emit(PaymentOrderIdSuccessStates());
    }).catchError((error) {
      print('Error in order id 🤦‍♂️');
      emit(
        PaymentOrderIdErrorStates(error.toString()),
      );
    });
  }

  // for final request token

  Future<void> getPaymentRequest(
      String priceOrder,
      String firstName,
      String lastName,
      String email,
      String phone,
      ) async {
    emit(PaymentRequestTokenLoadingStates());
    DioHelperPayment.postData(
      url: ConstantStayles.getPaymentRequest,
      data: {
        "auth_token": ConstantStayles.paymentFirstToken,
        "amount_cents": priceOrder,
        "expiration": 3600,
        "order_id": ConstantStayles.paymentOrderId,
        "billing_data": {
          "apartment": "NA",
          "email": email,
          "floor": "NA",
          "first_name": firstName,
          "street": "NA",
          "building": "NA",
          "phone_number": phone,
          "shipping_method": "NA",
          "postal_code": "NA",
          "city": "NA",
          "country": "NA",
          "last_name": lastName,
          "state": "NA"
        },
        "currency": "EGP",
        "integration_id": ConstantStayles.integrationIdCard,
        "lock_order_when_paid": "false"
      },
    ).then((value) {
      PaymentRequestModel paymentRequestModel =
      PaymentRequestModel.fromJson(value.data);
      ConstantStayles.finalToken = paymentRequestModel.token;
      print('Final token 🚀 ${ConstantStayles.finalToken}');
      emit(PaymentRequestTokenSuccessStates());
    }).catchError((error) {
      print('Error in final token 🤦‍♂️');
      emit(
        PaymentRequestTokenErrorStates(error.toString()),
      );
    });
  }

  Future getRefCode() async {
    DioHelperPayment.postData(
      url: ConstantStayles.getRefCode,
      data: {
        "source": {
          "identifier": "AGGREGATOR",
          "subtype": "AGGREGATOR",
        },
        "payment_token": ConstantStayles.finalToken,
      },
    ).then((value) {
      ConstantStayles.refCode = value.data['id'].toString();
      print('The ref code 🍅${ConstantStayles.refCode}');
      emit(PaymentRefCodeSuccessStates());
    }).catchError((error) {
      print("Error in ref code 🤦‍♂️");
      emit(PaymentRefCodeErrorStates(error.toString()));
    });
  }
}