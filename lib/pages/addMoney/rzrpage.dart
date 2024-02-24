import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class RzrPage extends StatefulWidget {
  const RzrPage({Key key}) : super(key: key);
  @override
  WebViewExampleState createState() => WebViewExampleState();
}

class WebViewExampleState extends State<RzrPage> {
  static const platform = const MethodChannel("razorpay_flutter");
  Razorpay _razorpay;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Add Money'),
        ),
        body: Center(
            child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
              ElevatedButton(
                  onPressed: () => createOrder(), child: Text('Add Money'))
            ])),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

//API Call

  Future createOrder() async {
    final int Amount = 10 * 100;
    // Map<String, String> headers = {
    //   'authorization':
    //       'Bearer eyJhbGciOiJIUzI1NiJ9.eyJzdWIiOiIyMCIsInNjb3BlcyI6WyJ0ZW5hbnQiXSwidGVuYW50IjoiYW51cGFtZmluY28iLCJhcGlfa2V5X2lkIjoxLCJpc3MiOiJjeWJyaWxsYS1hdXRoIiwiaWF0IjoxNjU3MjI2ODAzLCJleHAiOjE2NTcyMjg2MDN9.0DRiPCfu5crfLa8RP5pDVIY_babJ3yvKd6mOMUbBAyg'
    // };

    var response =
        await http.post(Uri.parse('https://api.razorpay.com/v1/orders'),
            headers: {
              "Content-Type": "application/json",
              "Authorization":
                  "Basic ${base64Encode(utf8.encode('rzp_live_uP0vhVEgm4SV11:NK48bW1TLg9xNbu5uppNkMxA'))} "
            },
            body: json.encode({
              "amount": Amount,
              "currency": "INR",
              "bank_account": {
                "account_number": "239001517462",
                "name": "Amey Vartak",
                "ifsc": "PYTM0123456"
              }
            }));
    var jsonData = jsonDecode(response.body);

    openCheckout(jsonData["id"]);
    // return jsonData["auth"];
    // return false;
  }

  // END API CALL

  // createOrderId() async {
  //   final int Amount = 10 * 100;
  //   http.Response response = await http.post(
  //       Uri.parse(
  //         "https://api.razorpay.com/v1/orders",
  //       ),
  //       headers: {
  //         "Content-Type": "application/json",
  //         "Authorization":
  //             "Basic ${base64Encode(utf8.encode('rzp_live_uP0vhVEgm4SV11:NK48bW1TLg9xNbu5uppNkMxA'))} "
  //       },
  //       body: json.encode({"amount": Amount, "currency": "INR"}));
  //   if (response.statusCode == 200) {
  //     var data = jsonDecode(response.body);
  //     openCheckout(data["id"]);
  //   }
  //   print(response.body);
  // }

  void openCheckout(id) async {
    var options = {
      'key': 'rzp_live_uP0vhVEgm4SV11',
      'amount': 1000,
      'order_id': id,
      'name': 'Poonji Mitra',
      'description': 'Add Money',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');
    /*Fluttertoast.showToast(
        msg: "SUCCESS: " + response.paymentId!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
    /* Fluttertoast.showToast(
        msg: "ERROR: " + response.code.toString() + " - " + response.message!,
        toastLength: Toast.LENGTH_SHORT); */
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
    /* Fluttertoast.showToast(
        msg: "EXTERNAL_WALLET: " + response.walletName!,
        toastLength: Toast.LENGTH_SHORT); */
  }
}
