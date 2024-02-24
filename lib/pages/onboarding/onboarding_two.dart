import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/onboarding/finalcalls.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class OnboardingTwo extends StatefulWidget {
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<OnboardingTwo> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  var items = ['FATHER', 'SPOUSE'];
  var genderr = ['MALE', 'FEMALE', 'OTHERS'];
  var mStatus = ['SINGLE', 'MARRIED', 'OTHERS'];

  var _isLoading = false;
  var name = '';
  var pan = '';
  var email = '';
  var mobile = '';
  var bankAccountNumber = '';
  var bankAccountIFSC = '';
  var token = '';

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    name = prefs.getString('name');
    pan = prefs.getString('pan');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile').substring(3);
    bankAccountIFSC = prefs.getString('BankAccountIFSC');
    bankAccountNumber = prefs.getString('BankAccountNumnber');
    token = prefs.getString('token');
  }

  final dobController = TextEditingController(text: '');
  final fatherSpouceName = TextEditingController(text: '');
  final kycRelation = TextEditingController(text: '');
  final gender = TextEditingController(text: '');
  final maritialStatus = TextEditingController(text: '');
  final address = TextEditingController(text: '');
  final pincode = TextEditingController(text: '');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Onboarding- Investor Details',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          heightSpace,
          dobTextField(),
          fatherSpouceTextField(),
          kycRelationTextField(),
          genderTextField(),
          maritialStatusTextField(),
          addressTextField(),
          pincodeTextField(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          updateButton(context),
        ],
      ),
    );
  }

  maritialStatusTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Maritial Status',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: maritialStatus,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  maritialStatus.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return mStatus.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  genderTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Gender',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: gender,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  gender.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return genderr.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  dobTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Date Of Birth',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          InkWell(
            child: Container(
              child: TextField(
                keyboardType: TextInputType.text,
                controller: dobController,
                cursorColor: primaryColor,
                style: black16MediumTextStyle,
                decoration: const InputDecoration(
                  isDense: true,
                  border: OutlineInputBorder(),
                ),
                readOnly: true,
                onTap: () async {
                  DateTime pickedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(
                          1940), //DateTime.now() - not to allow to choose before today.
                      lastDate: DateTime(2101));

                  if (pickedDate != null) {
                    print(
                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                    String formattedDate =
                        DateFormat('yyyy-MM-dd').format(pickedDate);
                    print(
                        formattedDate); //formatted date output using intl package =>  2021-03-16
                    //you can implement different kind of Date Format here according to your requirement

                    setState(() {
                      dobController.text =
                          formattedDate; //set output date to TextField value.
                    });
                  } else {
                    print("Date is not selected");
                  }
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  fatherSpouceTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Father/Spouce Name',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: fatherSpouceName,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  kycRelationTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'KYC Relation',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.text,
            controller: kycRelation,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              suffixIcon: PopupMenuButton<String>(
                icon: const Icon(Icons.arrow_drop_down),
                onSelected: (String value) {
                  kycRelation.text = value;
                },
                itemBuilder: (BuildContext context) {
                  return items.map<PopupMenuItem<String>>((String value) {
                    return new PopupMenuItem(
                        child: new Text(value), value: value);
                  }).toList();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  addressTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Correspondence Address',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: address,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  pincodeTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Pincode',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.number,
            controller: pincode,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: const InputDecoration(
              isDense: true,
              border: OutlineInputBorder(),
            ),
          ),
        ],
      ),
    );
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
              //  _isLoading = true;
            });
            await createInvestor();
            // if (id != null) {

            Navigator.push(
              context,
              PageTransition(
                child: FinalCalls(),
                type: PageTransitionType.rightToLeft,
              ),
            );
            // }
            // else {
            //   Fluttertoast.showToast(
            //     msg: 'You are not KYC Compliant. Please complete your KYC',
            //     backgroundColor: blackColor,
            //     textColor: whiteColor,
            //   );
            // }
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
                    'Complete Onboarding',
                    style: white16BoldTextStyle,
                  ),
                ),
        ),
      ],
    );
  }

//API Call

  Future<String> createInvestor() async {
    var body = {
      "display_name": name.trimRight(),
      "perm_addr_is_corres_addr": true,
      "ip_address": "192.168.29.100",
      "bank_accounts": [
        {
          "account_holder_name": name.trimRight(),
          "number": bankAccountNumber,
          "primary_account": true,
          "type": "SAVINGS",
          "ifsc_code": bankAccountIFSC
        }
      ],
      "contact_detail": {"email": email, "isd_code": "91", "mobile": mobile},
      "fatca_detail": {
        "country_of_birth_ansi_code": "IN",
        "no_other_tax_residences": true,
        "source_of_wealth": "business",
        "gross_annual_income": 100000
      },
      "nomination": {"skip_nomination": true},
      "kyc_identity_detail": {
        "pan_number": pan,
        "country_of_citizenship_ansi_code": "IN",
        "date_of_birth": dobController.text,
        "father_or_spouse_name": fatherSpouceName.text,
        "kyc_relation": kycRelation.text,
        "gender": gender.text,
        "marital_status": maritialStatus.text,
        "name": name,
        "occupation": "BUSINESS",
        "residential_status": "resident_individual",
        "pep_exposed": false,
        "pep_related": false
      },
      "correspondence_address": {"line1": address.text, "pincode": pincode.text}
    };

    var encodefund = jsonEncode(body);
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('createInvestorData', encodefund);

    // Map<String, String> headers = {
    //   'authorization': 'Bearer $token',
    //   'Content-Type': 'application/json'
    // };

    // var response = await http.post(
    //     Uri.parse('https://api.fintechprimitives.com/api/onb/investors'),
    //     headers: headers,
    //     body: json.encode(body));
    // var jsonData = jsonDecode(response.body);
    // setState(() {
    //   _isLoading = false;
    // });

    // if (jsonData["id"] != null) {
    //   saveInvestorData(jsonData["id"].toString(),
    //       jsonData["bank_accounts"][0]['id'].toString());

    //   await createInvestmentAccount(jsonData["id"].toString());
    //   return jsonData["id"].toString();
    // }
    // return '0';
  }

  Future<void> saveInvestorData(String id, String bankAccoundID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('investorID', id);
    await prefs.setString('bankAccoundID', bankAccoundID);
  }

  Future<String> createInvestmentAccount(String id) async {
    var body = {"primary_investor_old_id": id, "holding_pattern": "single"};

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse(
            'https://api.fintechprimitives.com/v2/mf_investment_accounts'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });

    if (jsonData["id"] != null) {
      saveInvestmentAccountData(jsonData["id"].toString());
      final prefs = await SharedPreferences.getInstance();
      await createMandate(prefs.getString('bankAccoundID').toString());
      return jsonData["id"].toString();
    }
    return '0';
  }

  // END API CALL

  //Mandate API Call

  Future<String> createMandate(String bankAccountID) async {
    var body = {
      "mandate_type": "E_MANDATE",
      "bank_account_id": bankAccountID,
      "mandate_limit": "10000"
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse('https://api.fintechprimitives.com/api/pg/mandates'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });

    if (jsonData["id"] != null) {
      saveMandateData(jsonData["id"].toString());
      await authorizedMandate(jsonData["id"].toString());
      return jsonData["id"].toString();
    }
    return '0';
  }

  // Authorize Mandate

  Future<String> authorizedMandate(String mandateID) async {
    var body = {
      "mandate_id": mandateID,
      "payment_postback_url": "https://www.poonjimitra.com/mandatereturn.html"
    };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };

    var response = await http.post(
        Uri.parse(
            'https://api.fintechprimitives.com/api/pg/payments/emandate/auth'),
        headers: headers,
        body: json.encode(body));
    var jsonData = jsonDecode(response.body);
    setState(() {
      _isLoading = false;
    });

    if (jsonData["token_url"] != null) {
      _launchURL(jsonData["token_url"].toString());

      return jsonData["id"].toString();
    }
    return '0';
  }

  // SAVE Investment Account

  Future<void> saveInvestmentAccountData(String investmentAccountID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('investmentAccountID', investmentAccountID);
    await prefs.setBool('isOnboardingComplete', true);

    // var response = await http.post(
    //       Uri.parse(
    //           'https://api.fintechprimitives.com/v2/mf_investment_accounts'),
    //       headers: headers,
    //       body: json.encode(body));
    //   var jsonData = jsonDecode(response.body);
  }

  // SAVE Mandate Data

  Future<void> saveMandateData(String mandateID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('investorMandateID', mandateID);
  }

//Launch URL

  _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
