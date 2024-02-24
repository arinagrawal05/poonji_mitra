import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/onboarding/onboarding_one.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

class Pan extends StatefulWidget {
  const Pan({Key key}) : super(key: key);

  @override
  _PanState createState() => _PanState();
}

class _PanState extends State<Pan> {
  var _isLoading = false;

  final nameController = TextEditingController(text: '');
  final emailController =
      TextEditingController(text: 'samanthasmith@gmail.com');
  final mobileNumberController = TextEditingController(text: '+91 1234567890');
  final passwordController = TextEditingController(text: 'Samantha Smith');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Onboarding- PAN Details',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 32.0, vertical: 50),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          nameTextField(),
          // emailTextField(),
          //  mobileNumberTextField(),
          //  passwordTextField(),

          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          updateButton(context),
        ],
      ),
    );
  }

  nameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Enter your PAN Card Number',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
              // border: UnderlineInputBorder(
              //     borderSide: BorderSide(color: greyColor)),
              // enabledBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(color: greyColor)),
              // focusedBorder: UnderlineInputBorder(
              //     borderSide: BorderSide(color: greyColor)),
            ),
          ),
        ],
      ),
    );
  }

  emailTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Email Address',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.emailAddress,
            controller: emailController,
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
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Mobile Number',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.number,
            controller: mobileNumberController,
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

  passwordTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Password',
            style: grey14MediumTextStyle,
          ),
          TextField(
            obscureText: true,
            controller: passwordController,
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

//API Call

  Future<bool> checKYCStatus(String mobileNumber) async {
    print('here');
    var body = {
      "pan": nameController.text,
    };
    final prefs = await SharedPreferences.getInstance();
    var tkn = prefs.getString('token');
    Map<String, String> headers = {'authorization': 'Bearer $tkn'};

    var response = await http.post(
        Uri.parse('https://api.fintechprimitives.com/api/kyc/check'),
        headers: headers,
        body: body);
    var jsonData = jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });

    if (response.statusCode == 400) {
      Fluttertoast.showToast(
        msg: 'Invalid Pan Details',
        backgroundColor: blackColor,
        textColor: whiteColor,
      );
    }

    if (response.statusCode == 401) {
      setState(() {
        _isLoading = true;
      });

      var updatedToken = await UpdateToken();

      Map<String, String> headers = {'authorization': 'Bearer $updatedToken'};

      var response = await http.post(
          Uri.parse('https://api.fintechprimitives.com/api/kyc/check'),
          headers: headers,
          body: body);
      var jsonData = jsonDecode(response.body);
      setState(() {
        _isLoading = false;
      });

      if (response.statusCode == 400) {
        Fluttertoast.showToast(
          msg: 'Invalid Pan Details',
          backgroundColor: blackColor,
          textColor: whiteColor,
        );
      }

      if (jsonData["status"]) {
        saveData(nameController.text);
        return true;
      }
    }

    if (jsonData["status"]) {
      saveData(nameController.text);
      return true;
    }
    return false;
    // return jsonData["auth"];
    // return false;
  }

  // END API CALL

  //Save Data
  Future<void> saveData(pan) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('pan', pan);
  }

  updateButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () async {
            currentIndex = 0;
            setState(() {
              _isLoading = true;
            });
            bool name = await checKYCStatus(nameController.text);
            if (name) {
              Navigator.push(
                context,
                PageTransition(
                  child: OnboardingOne(),
                  type: PageTransitionType.rightToLeft,
                ),
              );
            } else {
              Fluttertoast.showToast(
                msg: 'You are not KYC Compliant. Please complete your KYC',
                backgroundColor: blackColor,
                textColor: whiteColor,
              );
            }
          },
          child: _isLoading
              ? const CircularProgressIndicator(
                  color: primaryColor,
                )
              : Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: fixPadding * 3.0,
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
                    'Check KYC Status',
                    style: white16BoldTextStyle,
                  ),
                ),
        ),
      ],
    );
  }

  Future<String> UpdateToken() async {
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
}
