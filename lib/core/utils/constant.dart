import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ConstantStayles {
  static const Color kPrimColor = Color(0xff27374D);
  static const String kFeatuerdBox = 'featuerd_box';
  static TextStyle style1 =
  GoogleFonts.poppins(color: Colors.black, fontSize: 15);
  static TextStyle styleLight =
  GoogleFonts.poppins(color: Colors.white, fontSize: 15);
  static TextStyle styleDark =
  GoogleFonts.poppins(color: Colors.black, fontSize: 20);

  static TextStyle title =
  GoogleFonts.akayaTelivigala(color: Colors.black, fontSize: 20);
  static TextStyle subTitle = GoogleFonts.poppins(
      color: const Color.fromARGB(255, 61, 58, 58), fontSize: 15);

  static BoxDecoration kMessageContainerDecoration = const BoxDecoration(
    border: Border(
      top: BorderSide(color: Colors.lightBlueAccent, width: 2.0),
    ),
  );

  static InputDecoration kMessageTextFieldDecoration = const InputDecoration(
    contentPadding: EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
    hintText: 'Type your message here...',
    border: InputBorder.none,
  );


  static const kSendButtonTextStyle = TextStyle(
    color: Colors.lightBlueAccent,
    fontWeight: FontWeight.bold,
    fontSize: 18.0,
  );


  static const String baseUrl = 'https://accept.paymob.com/api';
  static const String paymentApiKey = "ENTER_YOUR PAYMENT_API_KEY";
  static const String getAuthToken = '/auth/tokens';
  static const getOrderId = '/ecommerce/orders';
  static const getPaymentRequest = '/acceptance/payment_keys';
  static const getRefCode = '/acceptance/payments/pay';
  static String visaUrl =
      '$baseUrl/acceptance/iframes/424000?payment_token=$finalToken';
  static String paymentFirstToken = '';

  static String paymentOrderId = '';

  static String finalToken = '';

  static const String integrationIdCard = 'ENTER_YOUR_INTEGRATION_ID';
  static const String integrationIdKiosk = 'ENTER_YOUR_INTEGRATION_ID';

  static String refCode = '';
}
  class AppImages {
  static const String refCodeImage =
  "https://cdn-icons-png.flaticon.com/128/4090/4090458.png";
  static const String visaImage =
  "https://cdn-icons-png.flaticon.com/128/349/349221.png";
}
