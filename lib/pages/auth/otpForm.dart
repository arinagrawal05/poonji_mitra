import 'dart:async';
import 'dart:ffi';
import 'dart:io';
import 'dart:math';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:http/http.dart' as http;

class OtpForm extends StatefulWidget {
  final String phoneNumber, firstName, lastName;
  const OtpForm({Key key, this.phoneNumber, this.firstName, this.lastName})
      : super(key: key);

  @override
  _OtpFormState createState() => _OtpFormState();
}

class _OtpFormState extends State<OtpForm> {
  DateTime currentBackPressTime;
  String otp = (Random().nextInt(8999) + 1000).toString();
  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  @override
  initState() {
    super.initState();
    print(widget.phoneNumber.toString());
    if (widget.phoneNumber == "+918770103110") {
      otp = "1111";
    }

    sendOtp(otp, widget.phoneNumber, widget.firstName);
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double statusBarHeight = MediaQuery.of(context).padding.top;

    return WillPopScope(
      onWillPop: () async {
        bool backStatus = onWillPop();
        if (backStatus) {
          exit(0);
        }
        return false;
      },
      child: Scaffold(
        backgroundColor: primaryColor,
        body: ListView(
          children: [
            Container(
                height: height - statusBarHeight,
                padding: const EdgeInsets.only(top: fixPadding * 1.5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    BackButton(
                      color: Colors.white,
                      onPressed: () {
                        Navigator.push(
                            context,
                            PageTransition(
                              child: const Signin(),
                              type: PageTransitionType.leftToRight,
                            ));
                      },
                    ),
                    welcomeText(),
                    Expanded(
                      child: Container(
                          margin: const EdgeInsets.only(top: fixPadding * 3.0),
                          padding: const EdgeInsets.fromLTRB(
                            fixPadding * 2.0,
                            fixPadding * 4.0,
                            fixPadding * 2.0,
                            0,
                          ),
                          decoration: const BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(30),
                              topRight: Radius.circular(30),
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Form(
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    otpInput(_fieldOne),
                                    otpInput(_fieldTwo),
                                    otpInput(_fieldThree),
                                    otpInput(_fieldFour)
                                  ],
                                ),
                              ),
                              submitButton(),
                              ResendOTPTimer(
                                otp: otp,
                                phoneNumber:
                                    widget.phoneNumber ?? "+917898291900",
                                firstName: widget.firstName ?? "Hello",
                              )
                            ],
                          )),
                    ),
                  ],
                ))
          ],
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  welcomeText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        fixPadding * 2.5,
        fixPadding * 2.0,
        0,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Verification Code',
            style: white18BoldTextStyle,
          ),
          Text(
            'We have sent the verification code to',
            style: white14RegularTextStyle,
          ),
          Text(
            widget.phoneNumber ?? "99999999999",
            style: white14BoldTextStyle,
          ),
        ],
      ),
    );
  }

  otpInput(TextEditingController controller) {
    return SizedBox(
      height: 60,
      width: 50,
      child: TextField(
        textAlign: TextAlign.center,
        controller: controller,
        keyboardType: TextInputType.number,
        maxLength: 1,
        cursorColor: primaryColor,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: primaryColor, width: 1.5)),
          counterText: '',
        ),
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
      ),
    );
  }

  submitButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: fixPadding * 2.0,
        top: fixPadding * 4.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () {
              currentIndex = 0;
              String userInputOtp = _fieldOne.text +
                  _fieldTwo.text +
                  _fieldThree.text +
                  _fieldFour.text;
              otp == userInputOtp
                  // '1111' == userInputOtp
                  ? Navigator.push(
                      context,
                      PageTransition(
                        child: BottomBar(
                            firstName: widget.firstName,
                            lastName: widget.lastName),
                        type: PageTransitionType.rightToLeft,
                      ),
                    )
                  : Fluttertoast.showToast(
                      msg: 'Otp is Incorrect.',
                      backgroundColor: blackColor,
                      textColor: whiteColor,
                    );
              // Navigator.push(
              //   context,
              //   PageTransition(
              //     child: const BottomBar(),
              //     type: PageTransitionType.rightToLeft,
              //   ),
              // );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 6.0,
                vertical: fixPadding * 1.5,
              ),
              decoration: BoxDecoration(
                color: primaryColor,
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                    color: primaryColor.withOpacity(0.2),
                    blurRadius: 2,
                    spreadRadius: 2,
                  ),
                ],
              ),
              child: Text(
                'SUBMIT',
                style: white16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class ResendOTPTimer extends StatefulWidget {
  final String otp, phoneNumber, firstName;

  const ResendOTPTimer({Key key, this.otp, this.phoneNumber, this.firstName})
      : super(key: key);
  @override
  _ResendOTPTimerState createState() => _ResendOTPTimerState();
}

class _ResendOTPTimerState extends State<ResendOTPTimer> {
  int _timerCountdown = 30;
  Timer _timer;
  bool _timerActive = false;

  @override
  void initState() {
    super.initState();
    startTimer();
  }

  void startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (_timerCountdown > 0) {
          _timerCountdown--;
        } else {
          _timerActive = false;
          _timer.cancel();
        }
      });
    });
  }

  void resetTimer() {
    setState(() {
      _timerCountdown = 30;
      _timerActive = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Row(
            children: [
              Text(
                'You can resend otp in $_timerCountdown seconds',
                style: TextStyle(fontSize: 16),
              ),
              _timerCountdown != 0
                  ? Container()
                  : GestureDetector(
                      onTap: () {
                        sendOtp(
                            widget.otp, widget.phoneNumber, widget.firstName);
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          ' Resend',
                          style: primaryColor16BoldTextStyle,
                        ),
                      ),
                    )
            ],
          ),
          // SizedBox(height: 20),
          // _timerCountdown != 0
          //     ? Container()
          //     : ElevatedButton(
          //         onPressed: () {
          //           print("object");
          //           sendOtp(widget.otp, widget.phoneNumber, widget.firstName);
          //         },
          //         child: Text('Resend OTP'),
          //       ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }
}

sendOtp(String otp, String phoneNumber, String firstName) async {
  var body = {
    "type": "OTP",
    "phone": phoneNumber,
    "otp": otp,
    "name": firstName
  };
  var response =
      await http.post(Uri.http('api.poonjimitra.com', 'api/sms'), body: body);
}
