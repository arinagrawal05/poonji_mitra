import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AccountDetail extends StatefulWidget {
  AccountDetail({Key key}) : super(key: key);

  @override
  State<AccountDetail> createState() => _AccountDetailState();
}

class _AccountDetailState extends State<AccountDetail> {
  final prefs = SharedPreferences.getInstance();

  var invName = '';
  var mobile = '';
  var email = '';

  var nameController = TextEditingController(text: '');

  var emailController = TextEditingController(text: '');

  var mobileNumberController = TextEditingController(text: '');

  var passwordController = TextEditingController(text: 'Samantha Smith');

  @override
  void initState() {
    super.initState();
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Account Details',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          profileImage(context),
          nameTextField(),
          emailTextField(),
          mobileNumberTextField(),
          // passwordTextField(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          updateButton(context),
        ],
      ),
    );
  }

  profileImage(context) {
    return Stack(
      children: [
        Center(
          child: InkWell(
            onTap: () => changeProfilePick(context),
            child: Container(
              height: 80,
              width: 80,
              margin: const EdgeInsets.only(bottom: fixPadding / 2),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: AssetImage('assets/users/user.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 187,
          child: InkWell(
            onTap: () => changeProfilePick(context),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: primaryColor,
                shape: BoxShape.circle,
                border: Border.all(color: whiteColor, width: 1.5),
              ),
              child: const Icon(
                Icons.add,
                color: whiteColor,
                size: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  changeProfilePick(context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: whiteColor,
          child: Wrap(
            children: [
              Container(
                padding: const EdgeInsets.all(fixPadding * 2.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        'Choose Option',
                        textAlign: TextAlign.center,
                        style: black18SemiBoldTextStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Take a picture',
                        style: black14MediumTextStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Select from gallery',
                        style: black14MediumTextStyle,
                      ),
                    ),
                    heightSpace,
                    heightSpace,
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Text(
                        'Remove profile picture',
                        style: black14MediumTextStyle,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  nameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name',
            style: grey14MediumTextStyle,
          ),
          TextField(
            keyboardType: TextInputType.name,
            controller: nameController,
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

  updateButton(context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        InkWell(
          borderRadius: BorderRadius.circular(30),
          onTap: () => Navigator.pop(context),
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
              'UPDATE PROFILE',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }

  Future<void> getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      invName = prefs.getString('name');
      email = prefs.getString('email');
      mobile = prefs.getString('mobile');

      nameController = TextEditingController(text: invName);
      emailController = TextEditingController(text: email);
      mobileNumberController = TextEditingController(text: mobile);
    });
  }
}
