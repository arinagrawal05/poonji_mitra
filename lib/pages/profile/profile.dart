import 'package:investment_zone/pages/screens.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Profile extends StatefulWidget {
  final String firstName, lastName;
  const Profile({Key key, this.firstName, this.lastName}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  var name = '';
  var mobile = '';
  var email = '';

  Future<void> getData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      name = prefs.getString('name');
      email = prefs.getString('email');
      mobile = prefs.getString('mobile').substring(3);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: blackColor,
        automaticallyImplyLeading: false,
        title: Text(
          ' My Profile',
          style: white18BoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          profile(),
          divider(),
          balance(context),
          profileOption(context),
        ],
      ),
    );
  }

  profile() {
    return Padding(
      padding: const EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                image: AssetImage('assets/users/user.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome',
                style: white14RegularTextStyle,
              ),
              const SizedBox(height: 2),
              Text(
                '${name}',
                style: white16BoldTextStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }

  balance(context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        0,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(fixPadding * 2.0),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(10),
                topRight: Radius.circular(10),
              ),
              boxShadow: [
                BoxShadow(
                  color: whiteColor.withOpacity(0.1),
                  spreadRadius: 1.5,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: Row(
              children: [
                Image.asset(
                  'assets/icons/wallet.png',
                  height: 24,
                  width: 24,
                  color: Colors.white,
                ),
                widthSpace,
                widthSpace,
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'sPenny Wallet Balance',
                      style: white16BoldTextStyle,
                    ),
                    Text(
                      'Rs. 0.00',
                      style: white14RegularTextStyle,
                    ),
                  ],
                ),
              ],
            ),
          ),
          InkWell(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            // onTap: () =>
            // Navigator.push(
            //   context,
            //   PageTransition(
            //     child: const AddMoney(),
            //     type: PageTransitionType.rightToLeft,
            //   ),
            // ),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(fixPadding),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(10),
                  bottomRight: Radius.circular(10),
                ),
                boxShadow: [
                  BoxShadow(
                    color: whiteColor.withOpacity(0.2),
                    spreadRadius: 2,
                    blurRadius: 2,
                  ),
                ],
              ),
              child: Text(
                'Money that will be invested',
                style: black16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }

  profileOption(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: AccountDetail(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/user.png',
          title: 'Account Details',
          color: whiteColor,
        ),
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: BankAndAutoPay(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/bank.png',
          title: 'Mandate',
          color: whiteColor,
        ),
        // options(
        //   ontap: () => Navigator.push(
        //     context,
        //     PageTransition(
        //       child: const Watchlist(),
        //       type: PageTransitionType.rightToLeft,
        //     ),
        //   ),
        //   image: 'assets/icons/list.png',
        //   title: 'Watchlist',
        //   color: blackColor,
        // ),

        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const Notifications(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/bell.png',
          title: 'Notifications',
          color: whiteColor,
        ),
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const InvestmentCart(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/shopping_cart.png',
          title: 'Offers',
          color: whiteColor,
        ),
        // options(
        //   ontap: () => Navigator.push(
        //     context,
        //     PageTransition(
        //       child: const SIPDelayCalculator(),
        //       type: PageTransitionType.rightToLeft,
        //     ),
        //   ),
        //   image: 'assets/icons/calculator.png',
        //   title: 'SIP Delay Calculator',
        //   color: blackColor,
        // ),

        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const Saved(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/bookmark.png',
          title: 'Saved',
          color: whiteColor,
        ),
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const InviteFriends(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/users.png',
          title: 'Invite Friends',
          color: whiteColor,
        ),
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const Support(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/support.png',
          title: 'Support',
          color: whiteColor,
        ),
        options(
          ontap: () => Navigator.push(
            context,
            PageTransition(
              child: const TermsAndCondition(),
              type: PageTransitionType.rightToLeft,
            ),
          ),
          image: 'assets/icons/document.png',
          title: 'Terms and Conditions',
          color: whiteColor,
        ),
        options(
          ontap: () => logoutDialog(context),
          image: 'assets/icons/sign_out.png',
          title: 'Logout',
          color: whiteColor,
        ),
      ],
    );
  }

  options({Function ontap, image, title, Color color}) {
    return InkWell(
      onTap: ontap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding * 2.0,
          vertical: fixPadding,
        ),
        child: Row(
          children: [
            Image.asset(
              image,
              color: color,
              height: 16,
              width: 16,
            ),
            widthSpace,
            widthSpace,
            widthSpace,
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: color,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  logoutDialog(context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          elevation: 5,
          insetPadding:
              const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          child: Wrap(
            children: [
              Padding(
                padding: const EdgeInsets.all(fixPadding * 1.5),
                child: Column(
                  children: [
                    Text(
                      'Sure you want to logout?',
                      style: black16SemiBoldTextStyle,
                    ),
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    heightSpace,
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Container(
                              padding: const EdgeInsets.all(fixPadding * 1.5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: whiteColor,
                                border: Border.all(color: Colors.transparent),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: blackColor.withOpacity(0.1),
                                    spreadRadius: 1.5,
                                    blurRadius: 1.5,
                                  ),
                                ],
                              ),
                              child: Text(
                                'CANCEL',
                                style: primaryColor16BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        widthSpace,
                        Expanded(
                          child: InkWell(
                            onTap: () => Navigator.push(
                              context,
                              PageTransition(
                                child: const Signin(),
                                type: PageTransitionType.rightToLeft,
                              ),
                            ),
                            child: Container(
                              padding: const EdgeInsets.all(fixPadding * 1.5),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: primaryColor,
                                border: Border.all(color: primaryColor),
                                borderRadius: BorderRadius.circular(30),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.2),
                                    spreadRadius: 2,
                                    blurRadius: 2,
                                  ),
                                ],
                              ),
                              child: Text(
                                'LOGOUT',
                                style: white16BoldTextStyle,
                              ),
                            ),
                          ),
                        ),
                      ],
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

  divider() {
    return Container(
      margin: const EdgeInsets.fromLTRB(
        fixPadding * 2.0,
        0,
        fixPadding * 2.0,
        fixPadding * 2.0,
      ),
      color: greyColor.withOpacity(0.4),
      height: 1,
      width: double.infinity,
    );
  }
}
