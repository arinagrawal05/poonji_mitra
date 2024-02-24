import 'package:investment_zone/pages/screens.dart';

class Support extends StatelessWidget {
  const Support({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Support',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          nameTextField(),
          heightSpace,
          heightSpace,
          heightSpace,
          emailTextField(),
          heightSpace,
          heightSpace,
          heightSpace,
          messageTextField(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          submitButton(context),
        ],
      ),
    );
  }

  nameTextField() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.name,
        cursorColor: primaryColor,
        style: black16MediumTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: fixPadding),
          hintText: 'Name',
          hintStyle: grey14MediumTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  emailTextField() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      child: TextField(
        keyboardType: TextInputType.emailAddress,
        cursorColor: primaryColor,
        style: black16MediumTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: fixPadding),
          hintText: 'Email Address',
          hintStyle: grey14MediumTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  messageTextField() {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: blackColor.withOpacity(0.1),
            spreadRadius: 1.5,
            blurRadius: 1.5,
          ),
        ],
      ),
      child: TextField(
        maxLines: 6,
        cursorColor: primaryColor,
        style: black16MediumTextStyle,
        decoration: InputDecoration(
          contentPadding: const EdgeInsets.only(left: fixPadding),
          hintText: 'Write Here',
          hintStyle: grey14MediumTextStyle,
          border: const UnderlineInputBorder(borderSide: BorderSide.none),
        ),
      ),
    );
  }

  submitButton(context) {
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
