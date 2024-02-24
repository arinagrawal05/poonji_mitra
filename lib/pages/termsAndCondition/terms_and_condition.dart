import 'package:investment_zone/pages/screens.dart';

class TermsAndCondition extends StatelessWidget {
  const TermsAndCondition({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
        ),
        title: Text(
          'Terms And Conditions',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(fixPadding * 2.0),
        children: [
          policies(),
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          // terms(),
        ],
      ),
    );
  }

  policies() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms & Condition',
          style: black16SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'These terms of use (Terms and Conditions) mandate the terms on which the users (You or Your or User) access and register on ther mobile application PoonjiMitra referred to as, the Platform.',
          style: grey12RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'Please read the Terms of Use and Privacy Policy carefully before registering on the Platform or accessing any material information through the Platform. The Company retains an unconditional right to modify or amend this Terms of Use without any requirement to notify You of the same. It shall be Your responsibility to check these Terms of Use periodically for changes. Accordingly, please continue to review the Terms whenever accessing or using the Platform. Your use of the Platform as defined above, after the posting of modifications to the Terms will constitute your acceptance of the Terms, as modified. Your use of the Platform on a continuous basis shall signify Your confirmation to the changes and the agreement to be legally bound by the same.\n\n1. Platform Services:\n\nYou acknowledge that the Platform allows You to avail the services directly from the Company and/or its group entities and affiliates including their products and services and facilitate communication with them for such services, and other related information. The Company hereby grants You, a limited, non-exclusive, non-transferable, royalty-free license to use the Platform for the purposes of availing the services from the Company and its group entities and affiliates, collectively hereinafter referred to as Platform Services.\n\n',
          style: grey12RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'PoonjiMitra services:\n\nUse of the Platform for facilitating subscription and redemption of mutual fund units and stocks by transmitting money and instructions to the relevant asset management company (AMCs), as per Your instructions\n\nMaintain a record of Your Personal information and financial transactions in a secure and confidential manner. However, they may share Your KYC and other related information with its group/associate/affiliate and You hereby give Your consent for the same\n\n\nWe are an an AMFI registered mutual fund distributor ARN -175447. It is hereby clarified that the we are not rendering the services of mutual fund, and it is merely providing a platform to its users, to facilitate the transaction of investment in mutual funds and stocks. If You buy a regular mutual fund on the Platform, we receives commissions from AMCs, details of which have been provided on the Platform and the default mutual funds available on the Platform are regular mutual funds. Please note that PoonjiMitra only facilitates the sale of direct mutual funds through the Platform and will not be liable in any manner with respect to the mutual fund units allotted to You by the AMC.\n\nWe do not, and is not obliged to, offer all mutual fund schemes for investment or as the case may be, all kind of investment advisory services. By limiting the number of schemes on the Platform, we do not make any representation as to the quality, bona fides or nature of any AMC or mutual fund scheme, or any other representation, warranty or guaranty, expressed or implied in respect of such mutual fund schemes. You hereby agree and acknowledge that the data and information provided on the Platform does not constitute advice by us of any nature whatsoever, and all the investments made in Your account will be merely at Your discretion and shall not be relied upon by You while making investment decisions in mutual funds and stocks and You shall be solely responsible for any investment decisions and for the purchase of any mutual funds and investments/trading in stocks on the Platform. In no event shall PoonjiMitra or any of its Affiliates, group, associate and subsidiary companies be held liable by You for any loss or damage that may cause or arise from or in relation to these Terms of Use and/or due to use of this Platform or due to investments made using this Platform.\n\nAs part of the Platform Services provided to You, after availing such services, You agree to provide honest feedback/review about the concerned Platform Service, if required by the us.\n\nIn case of any dissatisfaction with the Platform Services, You shall first file a formal complaint with the customer service of the Company and/or, as may be applicable, prior to pursuing any other recourse. The complaints can be lodged at [email protected] or [email protected] and upon lodging a complaint You agree to provide complete support to the customer service team with such reasonable information as may be sought by them from You along with necessary documents, emails, screenshots as available with You forming part of the said complaint. The decision of the Company as may be applicable, on the complaints shall be final and You agree to be bound by the same.\n\n\nFor more visit : https://www.poonjimitra.com/terms.html',
          style: grey12RegularTextStyle,
        ),
      ],
    );
  }

  terms() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Terms of Use',
          style: black16SemiBoldTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sem duis aliquet turpis suscipit ac gravida nulla. Arcu quis vel sodales quis pellentesque viverra eu elementum nisi. Gravida amet tortor nec non.',
          style: grey12RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Molestie neque, nisi nulla velit eget habitant arcu egestas aliquet. Turpis tellus nisl neque, morbi arcu ridiculus quis sed. Cras interdum nunc faucibus arcu nisl. Risus, lectus massa enim, felis, amet, sapien. Semper ante blandit augue gravida.',
          style: grey12RegularTextStyle,
        ),
        heightSpace,
        heightSpace,
        Text(
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin amet eget lobortis mauris, velit scelerisque tincidunt.',
          style: grey12RegularTextStyle,
        ),
      ],
    );
  }
}
