import 'dart:core';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/services.dart' show rootBundle;

class Signin extends StatefulWidget {
  const Signin({Key key}) : super(key: key);

  @override
  _SigninState createState() => _SigninState();
}

class _SigninState extends State<Signin> {
  double height;
  String isSelected = 'signin';
  bool visible = false;
  bool psw = false;
  bool confirmPsw = false;
  DateTime currentBackPressTime;
  String _firstName = "", _lastName = "";
  final _signupMobileNumberController = TextEditingController();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _signupPANNumberController = TextEditingController();
  final _emailController = TextEditingController();

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
        backgroundColor: blackColor,
        body: ListView(
          children: [
            Container(
              height: height - statusBarHeight,
              padding: const EdgeInsets.only(top: fixPadding * 3.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabBar(),
                  welcomeText(),
                  Expanded(
                    child: Container(
                      margin: const EdgeInsets.only(top: fixPadding * 3.0),
                      padding: const EdgeInsets.fromLTRB(
                        fixPadding * 2.0,
                        fixPadding * 2.5,
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
                      child: isSelected == 'signin'
                          ? signinDetail()
                          : signupDetail(),
                    ),
                  ),
                ],
              ),
            ),
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

  tabBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Row(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'signin';
              });
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: fixPadding / 2),
              decoration: BoxDecoration(
                border: isSelected == 'signin'
                    ? const Border(bottom: BorderSide(color: limeColor))
                    : const Border(),
              ),
              child: Text(
                'Sign in',
                style: TextStyle(
                  color: isSelected == 'signin'
                      ? whiteColor
                      : Colors.grey.shade300,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          widthSpace,
          InkWell(
            onTap: () {
              setState(() {
                isSelected = 'signup';
              });
            },
            child: Container(
              padding: const EdgeInsets.only(bottom: fixPadding / 2),
              decoration: BoxDecoration(
                border: isSelected == 'signup'
                    ? const Border(bottom: BorderSide(color: limeColor))
                    : const Border(),
              ),
              child: Text(
                'Sign up',
                style: TextStyle(
                  color: isSelected != 'signup'
                      ? whiteColor
                      : Colors.grey.shade300,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
            isSelected == 'signin'
                ? 'Welcome back,'
                : 'One Step away for amazing journey,',
            style: white18BoldTextStyle,
          ),
          Text(
            isSelected == 'signin'
                ? 'Sign in to continue'
                : 'Create your account',
            style: white14RegularTextStyle,
          ),
        ],
      ),
    );
  }

  signinDetail() {
    return Column(
      children: [
        mobileNumberTextField(),
        signinButton(),
        // otherOptions(),

        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Don’t have an account? ',
              style: grey16MediumTextStyle,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSelected = 'signup';
                });
              },
              child: Text(
                'Sign Up',
                style: primaryColor16SemiBoldTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  signupDetail() {
    return Column(
      children: [
        firstNameTextField(),
        lastNameTextField(),
        emailAddressTextField(),
        mobileNumberTextField(),
        panTextField(),
        signupButton(),
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Have an account? ',
              style: grey16MediumTextStyle,
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isSelected = 'signin';
                });
              },
              child: Text(
                'Sign In',
                style: primaryColor16SemiBoldTextStyle,
              ),
            ),
          ],
        ),
      ],
    );
  }

  emailTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Email Address',
          style: grey14MediumTextStyle,
        ),
        TextField(
          keyboardType: TextInputType.emailAddress,
          controller: _emailController,
          cursorColor: primaryColor,
          style: black16MediumTextStyle,
          decoration: const InputDecoration(
            isDense: true,
            border:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
          ),
        ),
      ],
    );
  }

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: grey14MediumTextStyle,
          ),
          SizedBox(
            height: 35,
            child: TextField(
              obscureText: !visible,
              cursorColor: primaryColor,
              style: black16MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      visible = !visible;
                    });
                  },
                  child: Icon(
                    visible ? Icons.visibility : Icons.visibility_off,
                    color: blackColor,
                    size: 16,
                  ),
                ),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
          heightSpace,
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              'Forget password?',
              style: primaryColor14MediumTextStyle,
            ),
          ),
        ],
      ),
    );
  }

  firstNameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'First Name',
          style: grey14MediumTextStyle,
        ),
        TextField(
          keyboardType: TextInputType.name,
          controller: _firstNameController,
          cursorColor: primaryColor,
          style: black16MediumTextStyle,
          decoration: const InputDecoration(
            isDense: true,
            border:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
            enabledBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
            focusedBorder:
                UnderlineInputBorder(borderSide: BorderSide(color: greyColor)),
          ),
        ),
      ],
    );
  }

  lastNameTextField() {
    return Padding(
        padding: const EdgeInsets.only(top: fixPadding * 2),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Last Name',
              style: grey14MediumTextStyle,
            ),
            TextField(
              keyboardType: TextInputType.name,
              controller: _lastNameController,
              cursorColor: primaryColor,
              style: black16MediumTextStyle,
              decoration: const InputDecoration(
                isDense: true,
                border: UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ],
        ));
  }

  emailAddressTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
            ),
          ),
        ],
      ),
    );
  }

  mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mobile Number',
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.black.withOpacity(0.7)),
          ),
          TextField(
            controller: _signupMobileNumberController,
            keyboardType: TextInputType.phone,
            maxLength: 13,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              prefixIcon: Container(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 9),
                child: Text(
                  "+91 ",
                  style: TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                      fontWeight: FontWeight.w500),
                ),
              ),
              isDense: true,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
            ),
          ),
        ],
      ),
    );
  }

  panTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'PAN Number',
            style: grey14MediumTextStyle,
          ),
          TextField(
            controller: _signupPANNumberController,
            keyboardType: TextInputType.name,
            maxLength: 10,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
              focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: greyColor)),
            ),
          ),
        ],
      ),
    );
  }

  createPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Create Password',
            style: grey14MediumTextStyle,
          ),
          SizedBox(
            height: 35,
            child: TextField(
              obscureText: !psw,
              cursorColor: primaryColor,
              style: black16MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      psw = !psw;
                    });
                  },
                  child: Icon(
                    psw ? Icons.visibility : Icons.visibility_off,
                    color: blackColor,
                    size: 16,
                  ),
                ),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  confirmPasswordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Confirm Password',
            style: grey14MediumTextStyle,
          ),
          SizedBox(
            height: 35,
            child: TextField(
              obscureText: !confirmPsw,
              cursorColor: primaryColor,
              style: black16MediumTextStyle,
              decoration: InputDecoration(
                isDense: true,
                suffixIcon: InkWell(
                  onTap: () {
                    setState(() {
                      confirmPsw = !confirmPsw;
                    });
                  },
                  child: Icon(
                    confirmPsw ? Icons.visibility : Icons.visibility_off,
                    color: blackColor,
                    size: 16,
                  ),
                ),
                border: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                enabledBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
                focusedBorder: const UnderlineInputBorder(
                    borderSide: BorderSide(color: greyColor)),
              ),
            ),
          ),
        ],
      ),
    );
  }

  signinButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: fixPadding * 2.0,
        top: fixPadding * 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              currentIndex = 0;
              List<String> name = await isRegisteredUser(
                  "+91" + _signupMobileNumberController.text);
              name.length == 2
                  ? Navigator.push(
                      context,
                      PageTransition(
                        child: OtpForm(
                            phoneNumber:
                                "+91" + _signupMobileNumberController.text,
                            firstName: name[0],
                            lastName: name[1]),
                        type: PageTransitionType.rightToLeft,
                      ),
                    )
                  : Fluttertoast.showToast(
                      msg: 'User does not Exist. Please sign up.',
                      backgroundColor: blackColor,
                      textColor: whiteColor,
                    );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 6.0,
                vertical: fixPadding * 1.5,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
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
                'SIGN IN',
                style: white16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  signupButton() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: fixPadding * 2.0,
        top: fixPadding * 2.0,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () async {
              currentIndex = 0;
              await isNewUser("+91" + _signupMobileNumberController.text)
                  ? Navigator.push(
                      context,
                      PageTransition(
                        child: OtpForm(
                            phoneNumber:
                                "+91" + _signupMobileNumberController.text,
                            firstName: _firstNameController.text,
                            lastName: _lastNameController.text),
                        type: PageTransitionType.rightToLeft,
                      ),
                    )
                  : Fluttertoast.showToast(
                      msg: 'User already Exists. Please sign in.',
                      backgroundColor: blackColor,
                      textColor: whiteColor,
                    );
            },
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 6.0,
                vertical: fixPadding * 1.5,
              ),
              decoration: BoxDecoration(
                color: Colors.black,
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
                'SIGN UP',
                style: white16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<List<String>> isRegisteredUser(String mobileNumber) async {
    String uri = "http://api.poonjimitra.com/api/customer";
    var body = {
      "phone": "+91" + _signupMobileNumberController.text,
    };
    var response = await http
        .post(Uri.http('api.poonjimitra.com', 'api/custlogin'), body: body);
    var jsonData = jsonDecode(response.body);
    List<String> name = [];
    if (jsonData["auth"]) {
      String fn = jsonData["data"]["firstName"],
          ln = jsonData["data"]["lastName"];
      name.add(fn);
      name.add(ln);
      var token = await getToken();
      saveData(
          jsonData["data"]["firstName"].toString(),
          jsonData["data"]["phone"].toString(),
          jsonData["data"]["email"].toString(),
          token,
          jsonData["data"]["investorId"].toString(),
          jsonData["data"]["investmentAccountId"].toString(),
          jsonData["data"]["bankAccountId"].toString(),
          jsonData["data"]["mandateId"].toString(),
          jsonData["data"]["kycStatus"].toString(),
          jsonData["data"]["pan"].toString());
    }
    return name;
  }

  Future<String> getToken() async {
    var body = {"isProduction": "1"};

    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http.post(
        Uri.parse('http://api.poonjimitra.com/api/token'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);

    if (jsonData["token"] != null) {
      return jsonData["token"].toString();
    }
    return '0';
  }

  //Save Data
  Future<void> saveData(name, mobile, email, token, investorId,
      investmentAccountId, bankAccountId, mandateId, kycStatus, pan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('mobile', mobile);
    await prefs.setString('email', email);
    await prefs.setString('token', token);
    await prefs.setString('panNumber', pan);

    await prefs.setString('investorId', investorId);
    await prefs.setString('investmentAccountId', investmentAccountId);
    await prefs.setString('bankAccountId', bankAccountId);
    await prefs.setString('mandateId', mandateId);
    await prefs.setString('kycStatus', kycStatus);

    await prefs.setString('token', token);
  }

  Future<bool> isNewUser(String mobileNumber) async {
    String uri = "http://api.poonjimitra.com/api/customer";
    var body = {
      "firstName": _firstNameController.text.trimRight(),
      "lastName": _lastNameController.text.trimRight(),
      "email": _emailController.text.trimRight(),
      "phone": "+91" + _signupMobileNumberController.text,
      "isPhoneVerified": "false",
      "investorId": "0",
      "investmentAccountId": "0",
      "deviceId": "App",
      "deviceType": "android",
      "ip": "",
      "city": "",
      "state": "",
      "country": "India",
      "kycStatus": "false",
      "bankAccountId": "0",
      "isEmailVerified": "",
      "pan": _signupPANNumberController.text.trimRight(),
    };
    var response = await http
        .post(Uri.http('api.poonjimitra.com', 'api/customer'), body: body);
    var jsonData = jsonDecode(response.body);

    await sendWelcomeEmail();
    // return false;
    return jsonData["status"] == "Successful" ? true : false;
    // return false;
  }

  Future<String> _read() async {
    String text;
    try {
      final Directory directory = await getApplicationDocumentsDirectory();
      final File file = File('${directory.path}/assets/Welcome.html');
      text = await file.readAsString();
    } catch (e) {
      print("Couldn't read file");
    }
    return text;
  }

  Future<String> sendWelcomeEmail() async {
    var htmlData = await _read();
    var body = {
      "to": [
        {
          "email": _emailController.text.trimRight(),
          "name": _firstNameController.text.trimRight()
        }
      ],
      "cc": [],
      "bcc": [],
      "from": {"email": "info@poonjimitra.com", "name": "Poonji Mitra"},
      "subject": "Welcome to Poonji Mitra",
      "html": htmlData,
      "text": "Congratulations on your signup",
      "attachments": [],
      "category": "App Signup Welcome Email"
    };

    Map<String, String> headers = {
      'Api-Token': '3484963a10b9b33ad383668afa74a985'
    };

    var response = await http.post(
        Uri.parse('https://send.api.mailtrap.io/api/send'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);

    // return false;
    return jsonData.toString();
    // return false;
  }

  otherOptions() {
    return Column(
      children: [
        Text(
          'Or Connect With',
          style: grey16MediumTextStyle,
        ),
        heightSpace,
        heightSpace,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(
                color: Color(0xff4267b2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/facebook.png',
                height: 18,
                width: 18,
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            widthSpace,
            Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(
                color: Color(0xff1da1f2),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/twitter.png',
                height: 18,
                width: 18,
              ),
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            widthSpace,
            Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xffF09433),
                    Color(0xffE6683C),
                    Color(0xffDC2743),
                    Color(0xffCC2366),
                    Color(0xffBC1888),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/icons/insta.png',
                color: whiteColor,
                height: 18,
                width: 18,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
