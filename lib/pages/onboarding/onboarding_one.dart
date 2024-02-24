import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingOne extends StatefulWidget {
  @override
  _NextState createState() => _NextState();
}

class _NextState extends State<OnboardingOne> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  final nameController = TextEditingController(text: '');
  final accountNumberController = TextEditingController(text: '');
  final ifscController = TextEditingController(text: '');
  final passwordController = TextEditingController(text: '');

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    nameController.text = prefs.getString('name');
  }

  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Onboarding- Bank Details',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          // profileImage(context),

          nameTextField(),
          emailTextField(),
          mobileNumberTextField(),
          // passwordTextField(),

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
            'Account Holder Name',
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
            'Account Number',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.number,
            controller: accountNumberController,
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

  mobileNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IFSC',
            style: grey14MediumTextStyle,
          ),
          heightSpace,
          heightSpace,
          TextField(
            keyboardType: TextInputType.text,
            controller: ifscController,
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
            await saveData();
            Navigator.push(
              context,
              PageTransition(
                child: OnboardingTwo(),
                type: PageTransitionType.rightToLeft,
              ),
            );
          },
          child: Container(
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
              'Next',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  //Save Data
  Future<void> saveData() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
        'BankAccountNumnber', accountNumberController.text.trimRight());
    await prefs.setString('BankAccountName', nameController.text.trimRight());
    await prefs.setString('BankAccountIFSC', ifscController.text.trimRight());
  }
}
