import 'package:investment_zone/pages/screens.dart';

class InviteFriends extends StatelessWidget {
  const InviteFriends({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Invite Friends',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/refer_friend.png',
              height: MediaQuery.of(context).size.height * 0.37,
              width: MediaQuery.of(context).size.width - 40,
              fit: BoxFit.cover,
            ),
            heightSpace,
            heightSpace,
            heightSpace,
            heightSpace,
            Text(
              'Earn 100 poonji points for every referral who registers & invest.',
              textAlign: TextAlign.center,
              style: black14RegularTextStyle,
            ),
          ],
        ),
      ),
      bottomNavigationBar: inviteButton(context),
    );
  }

  inviteButton(context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            borderRadius: BorderRadius.circular(30),
            onTap: () => Navigator.pop(context),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 4.5,
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
                'INVITE AND EARN',
                style: white16BoldTextStyle,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
