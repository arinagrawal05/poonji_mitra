import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

class FinalCalls extends StatefulWidget {
  final jsondata;

  FinalCalls({Key key, this.jsondata}) : super(key: key);
  @override
  _NextState createState() => _NextState();
}

bool activateButton = false;
var name = '';
var pan = '';
var email = '';
var mobile = '';
var bankAccountNumber = '';
var bankAccountIFSC = '';
var token = '';
var token_url = "";

class _NextState extends State<FinalCalls> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();

    //  createInv = prefs.getString('createInvestorData');
    name = prefs.getString('name');
    pan = prefs.getString('pan');
    email = prefs.getString('email');
    mobile = prefs.getString('mobile').substring(3);
    bankAccountIFSC = prefs.getString('BankAccountIFSC');
    bankAccountNumber = prefs.getString('BankAccountNumnber');
    token = await UpdateToken();

    await createInvestorCall();
  }

  final createInvestor = TextEditingController(text: '');
  final createInvestmentAccount = TextEditingController(text: '');
  final createMandate = TextEditingController(text: '');

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
          createInvestorField(),
          heightSpace,
          heightSpace,
          createInvestmentAccountField(),
          heightSpace,
          heightSpace,
          createMandateField(),
          heightSpace,
          heightSpace,
          authorizeButtonField(),
        ],
      ),
    );
  }

  authorizeButtonField() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0),
      child: Container(
        padding: EdgeInsets.all(20),
        decoration: BoxDecoration(
            color: Colors.deepPurple, borderRadius: BorderRadius.circular(12)),
        child: Center(
            child: Row(
          children: [
            InkWell(
              onTap: () {
                if (activateButton) {
                  authorize();
                } else {
                  Fluttertoast.showToast(
                    msg: 'Please wait till accout setup process completes',
                    backgroundColor: Colors.black,
                    textColor: whiteColor,
                  );
                }
              },
              child: Text('Authorize Mandate',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18)),
            )
          ],
        )),
      ),
    );
  }

  createInvestorField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creating Investor',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: createInvestor,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  // Creating Investment Account

  createInvestmentAccountField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creating Investment Account',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: createInvestmentAccount,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

  // Creating Mandate

  createMandateField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Creating Mandate',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: createMandate,
            cursorColor: primaryColor,
            style: black16MediumTextStyle,
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
          ),
        ],
      ),
    );
  }

//API Calls

  Future<String> createInvestorCall() async {
    // var body = {
    //   "display_name": name,
    //   "perm_addr_is_corres_addr": true,
    //   "ip_address": "192.168.29.100",
    //   "bank_accounts": [
    //     {
    //       "account_holder_name": name,
    //       "number": bankAccountNumber,
    //       "primary_account": true,
    //       "type": "SAVINGS",
    //       "ifsc_code": bankAccountIFSC
    //     }
    //   ],
    //   "contact_detail": {"email": email, "isd_code": "91", "mobile": mobile},
    //   "fatca_detail": {
    //     "country_of_birth_ansi_code": "IN",
    //     "no_other_tax_residences": true,
    //     "source_of_wealth": "business",
    //     "gross_annual_income": 100000
    //   },
    //   "nomination": {"skip_nomination": true},
    //   "kyc_identity_detail": {
    //     "pan_number": pan,
    //     "country_of_citizenship_ansi_code": "IN",
    //     "date_of_birth": dobController.text,
    //     "father_or_spouse_name": fatherSpouceName.text,
    //     "kyc_relation": kycRelation.text,
    //     "gender": gender.text,
    //     "marital_status": maritialStatus.text,
    //     "name": name,
    //     "occupation": "BUSINESS",
    //     "residential_status": "resident_individual",
    //     "pep_exposed": false,
    //     "pep_related": false
    //   },
    //   "correspondence_address": {"line1": address.text, "pincode": pincode.text}
    // };

    Map<String, String> headers = {
      'authorization': 'Bearer $token',
      'Content-Type': 'application/json'
    };
    final prefs = await SharedPreferences.getInstance();

    var createInput = prefs.getString('createInvestorData');
    var encodefund = jsonEncode(createInput);
    var data = jsonDecode(encodefund);
    var dataa = jsonDecode(data);

    var response = await http.post(
        Uri.parse('https://api.fintechprimitives.com/api/onb/investors'),
        headers: headers,
        body: data);
    var jsonData = jsonDecode(response.body);

    setState(() {
      createInvestor.text = "Investor Created";
    });

    if (jsonData["id"] != null) {
      saveInvestorData(jsonData["id"].toString(),
          jsonData["bank_accounts"][0]['id'].toString());

      await createInvestmentAccountt(jsonData["id"].toString());

      return jsonData["id"].toString();
    }
    return '0';
  }

  Future<void> saveInvestorData(String id, String bankAccoundID) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('investorID', id);
    await prefs.setString('bankAccoundID', bankAccoundID);
  }

  Future<String> createInvestmentAccountt(String id) async {
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
      createInvestmentAccount.text = "Investment Account Created :";
    });

    if (jsonData["id"] != null) {
      saveInvestmentAccountData(jsonData["id"].toString());
      final prefs = await SharedPreferences.getInstance();
      await createMandatee(prefs.getString('bankAccoundID').toString());
      return jsonData["id"].toString();
    }
    return '0';
  }

  // END API CALL

  //Mandate API Call

  Future<String> createMandatee(String bankAccountID) async {
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
      createMandate.text = "Mandate created Successfully ";
      activateButton = true;
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
    setState(() {});

    if (jsonData["token_url"] != null) {
      token_url = jsonData["token_url"].toString();
      //_launchURL();

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

  Future<bool> authorize() async {
    if (token_url != "") {
      _launchURL(token_url);
    }
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
