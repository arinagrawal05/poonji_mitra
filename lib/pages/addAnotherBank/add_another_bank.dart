import 'package:investment_zone/pages/screens.dart';

import '../../components/easyCard.dart';

class AddAnotherBank extends StatelessWidget {
  const AddAnotherBank({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Manage My Wealth',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: <Widget>[],
      ),
    );
  }

  nameTextField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Name of Beneficiary',
          style: grey14MediumTextStyle,
        ),
        TextField(
          keyboardType: TextInputType.name,
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

  bankNameTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Name of Bank',
            style: grey14MediumTextStyle,
          ),
          TextField(
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

  accountNumberTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Account Number',
            style: grey14MediumTextStyle,
          ),
          TextField(
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

  codeTextField() {
    return Padding(
      padding: const EdgeInsets.only(top: fixPadding * 2.5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'IFSC Code',
            style: grey14MediumTextStyle,
          ),
          TextField(
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

  addButton(context) {
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
              'ADD ANOTHER BANK',
              style: white16BoldTextStyle,
            ),
          ),
        ),
      ],
    );
  }
}
