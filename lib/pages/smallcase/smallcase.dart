import 'package:investment_zone/pages/screens.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class Smallcase extends StatefulWidget {
  final String category;
  const Smallcase({Key key, this.category = 'Small Case'}) : super(key: key);

  @override
  State<Smallcase> createState() => _SmallCapCategoryState();
}

class _SmallCapCategoryState extends State<Smallcase> {
  String category = 'Equity';
  String type = 'Growth';
  String investment = '<=Rs.500';
  String rated = 'CRISIL';
  String stars = '5';

  final String imageFolder = 'assets/smallcase/';
  final fundsList = [
    {
      'title': 'Wright 🌱 Smallcaps',
      'description':
          'Choice smallcaps to participate in the high growth smallcap rally. Rec Amt: 1-20 lac',
      'code': 'WRTMO_0007',
    },
    {
      'title': 'Wright 🌱 Smallcaps [AUM based pricing]',
      'description':
          'Choice smallcaps to participate in the high growth smallcap rally Rec Amt: 1-10 lac',
      'code': 'WRTMO_0009'
    },
    {
      'title': 'Balanced - Multi Factor Tactical',
      'description':
          'Stable out-performance in all markets, powered by quantitative research. Rec > 1 lac',
      'code': 'WRTMO_0003'
    },
    {
      'title': 'Smallcap Compounders (AUM Plan)',
      'description':
          'Invests in Small-Cap stocks which have potential to generate multifold returns in coming years',
      'code': 'GPRMO_0007'
    },
    {
      'title': 'Balanced - Multi Factor Tactical',
      'description':
          'Stable out-performance in all markets, powered by quantitative research. Rec Amt: > 1 lac',
      'code': 'WRTMO_0001'
    },
    {
      'title': 'Growth - Multi Factor Tactical',
      'description':
          'Stable out-performance in all markets, for the high risk investor. Rec Amt: > 1 lac',
      'code': 'WRTMO_0004'
    },
    {
      'title': 'Conservative - Multi Factor Tactical',
      'description':
          'Stable out-performance in all markets, for the low risk investor. Rec Amt: 2-20 lac',
      'code': 'WRTMO_0005'
    },
    {
      'title': 'High Quality Right Price (AUM Plan)',
      'description':
          'Invest in stocks that will benefit from Aatma Nirbhar Bharat and China Plus One investment theme!',
      'code': 'GPRMO_0005'
    },
    {
      'title': 'SmartNIFTY Index (AUM Plan)',
      'description':
          'This portfolio invests in the best 25 NIFTY Index companies which helps you outperform the Index',
      'code': 'GPRET_0003'
    },
    {
      'title': 'High Dividend Yield and Capital Appreciation (AUM)',
      'description':
          'Invest in companies with High Dividend Yield and Opportunities of Capital Appreciation',
      'code': 'GPRNM_0002'
    },
    {
      'title': 'Wright ⚡️Momentum [AUM based Fee]',
      'description':
          'Momentum investing! Invest in trending stocks. [Fee calculated as a % of AUM] Rec Amt > 1 lac',
      'code': 'WRTMO_0008'
    },
    {
      'title': 'Wright 🤖 ETFs',
      'description':
          'This is a dynamic medium-risk portfolio that allocates to equity, bonds, gold and international ETFs',
      'code': 'WRTET_0001'
    },
    {
      'title': 'Multinational Companies (MNC) Advantage (AUM Plan)',
      'description':
          'Invests in Best MNC\'s following our High Quality Right Price philosophy',
      'code': 'GPRNM_0003'
    },
    {
      'title': 'Wright 💎 Quality',
      'description':
          'High quality stocks - based on profitability, growth in profitability and safety. Rec Amt > 1 lac',
      'code': 'WRTMO_0010'
    },
  ];
  String selected;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
        ),
        title: Text(
          '${widget.category}',
          style: white18BoldTextStyle,
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(70),
          child: Container(
            margin: const EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              0,
              fixPadding * 2.0,
              fixPadding * 2.0,
            ),
            decoration: BoxDecoration(
              color: blackColor,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                  color: whiteColor.withOpacity(0.1),
                  spreadRadius: 1.5,
                  blurRadius: 1.5,
                ),
              ],
            ),
            child: TextField(
              cursorColor: primaryColor,
              style: white16BoldTextStyle,
              decoration: InputDecoration(
                hintText: 'Search here',
                hintStyle: grey16RegularTextStyle,
                prefixIcon: const Icon(
                  Icons.search,
                  color: greyColor,
                  size: 20,
                ),
                suffixIcon: IconButton(
                  onPressed: () => bottomsheet(context),
                  icon: const Icon(
                    Icons.filter_alt_rounded,
                    color: greyColor,
                    size: 15,
                  ),
                ),
                border: const UnderlineInputBorder(borderSide: BorderSide.none),
              ),
            ),
          ),
        ),
      ),
      body: funds(),
    );
  }

  funds() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: fundsList.length,
      itemBuilder: (context, index) {
        final item = fundsList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            index == 0 ? fixPadding * 2.0 : 0,
            fixPadding * 2.0,
            fixPadding * 1.5,
          ),
          child: InkWell(
            onTap: () {
              _launchURL(
                  'https://wrightresearch.smallcase.com/smallcase/${item['code']}?rmId=5fb78363f3e47cadeb81f87f&distributor=nikhil-gupta&showSubscription=true');
            },
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
              decoration: BoxDecoration(
                color: blackColor,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: whiteColor.withOpacity(0.1),
                    spreadRadius: 1.5,
                    blurRadius: 1.5,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                        ),
                        child: Image.asset('$imageFolder${item['code']}.png'),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Column(children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              item['title'],
                              style: white14RegularTextStyle,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          heightSpace,
                          Text(
                            item['description'],
                            style: grey12RegularTextStyle,
                          )
                        ]),
                      )
                      // ratingStars(item['rating']),
                    ],
                  ),
                  const SizedBox(height: 13),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  ratingStars(int rating) {
    return Row(
      children: [
        if (rating == 5 ||
            rating == 4 ||
            rating == 3 ||
            rating == 2 ||
            rating == 1)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4 || rating == 3 || rating == 2)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4 || rating == 3)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5 || rating == 4)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
        if (rating == 5)
          const Icon(Icons.star_rounded, size: 18, color: yellowColor),
      ],
    );
  }

  bottomsheet(context) {
    return showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Wrap(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: fixPadding * 2.0,
                vertical: 9,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Filters',
                    style: black18SemiBoldTextStyle,
                  ),
                  heightSpace,
                  heightSpace,
                  fundCategory(),
                  const SizedBox(height: 7),
                  fundType(),
                  const SizedBox(height: 7),
                  minimumInvestment(),
                  const SizedBox(height: 7),
                  ratedBy(),
                  const SizedBox(height: 7),
                  rating(),
                  heightSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: () {
                          Navigator.pop(context);
                          Navigator.push(
                            context,
                            PageTransition(
                              child: SearchResult(
                                filterCategory: category,
                                filterType: type,
                                filterInvestment: investment,
                              ),
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
                          ),
                          child: Text(
                            'SHOW RESULTS',
                            style: white16BoldTextStyle,
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          'Clear All',
                          style: grey12SemiBoldTextStyle,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).padding.top),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  fundCategory() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fund Category',
            style: grey14SemiBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Wrap(
            children: [
              filters(
                selected: category,
                filter: 'Equity',
                ontap: () {
                  setState(() {
                    category = 'Equity';
                  });
                },
                child: Text(
                  'Equity',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: category == 'Equity' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: category,
                filter: 'Balanced',
                ontap: () {
                  setState(() {
                    category = 'Balanced';
                  });
                },
                child: Text(
                  'Balanced',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: category == 'Balanced' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: category,
                filter: 'Tax Saver',
                ontap: () {
                  setState(() {
                    category = 'Tax Saver';
                  });
                },
                child: Text(
                  'Tax Saver',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: category == 'Tax Saver' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: category,
                filter: 'Debt Fund',
                ontap: () {
                  setState(() {
                    category = 'Debt Fund';
                  });
                },
                child: Text(
                  'Debt Fund',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: category == 'Debt Fund' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  fundType() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Fund Type',
            style: grey14SemiBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Wrap(
            children: [
              filters(
                selected: type,
                filter: 'Growth',
                ontap: () {
                  setState(() {
                    type = 'Growth';
                  });
                },
                child: Text(
                  'Growth',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: type == 'Growth' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: type,
                filter: 'Devident',
                ontap: () {
                  setState(() {
                    type = 'Devident';
                  });
                },
                child: Text(
                  'Devident',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: type == 'Devident' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  minimumInvestment() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Minimum Investment',
            style: grey14SemiBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Wrap(
            children: [
              filters(
                selected: investment,
                filter: '<=Rs.500',
                ontap: () {
                  setState(() {
                    investment = '<=Rs.500';
                  });
                },
                child: Text(
                  '<=Rs.500',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: investment == '<=Rs.500' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: investment,
                filter: 'Rs.501 - Rs.2000',
                ontap: () {
                  setState(() {
                    investment = 'Rs.501 - Rs.2000';
                  });
                },
                child: Text(
                  'Rs.501 - Rs.2000',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: investment == 'Rs.501 - Rs.2000'
                        ? whiteColor
                        : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: investment,
                filter: '>=Rs.2000',
                ontap: () {
                  setState(() {
                    investment = '>=Rs.2000';
                  });
                },
                child: Text(
                  '>=Rs.2000',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: investment == '>=Rs.2000' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  ratedBy() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rated By',
            style: grey14SemiBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Wrap(
            children: [
              filters(
                selected: rated,
                filter: 'CRISIL',
                ontap: () {
                  setState(() {
                    rated = 'CRISIL';
                  });
                },
                child: Text(
                  'CRISIL',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: rated == 'CRISIL' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: rated,
                filter: 'Marningstar',
                ontap: () {
                  setState(() {
                    rated = 'Marningstar';
                  });
                },
                child: Text(
                  'Marningstar',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: rated == 'Marningstar' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              filters(
                selected: rated,
                filter: 'Value Research',
                ontap: () {
                  setState(() {
                    rated = 'Value Research';
                  });
                },
                child: Text(
                  'Value Research',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: rated == 'Value Research' ? whiteColor : greyColor,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  rating() {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Rating',
            style: grey14SemiBoldTextStyle,
          ),
          const SizedBox(height: 7),
          Wrap(
            children: [
              filters(
                selected: stars,
                filter: '5',
                ontap: () {
                  setState(() {
                    stars = '5';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '5',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: stars == '5' ? whiteColor : greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
              filters(
                selected: stars,
                filter: '4',
                ontap: () {
                  setState(() {
                    stars = '4';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '4',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: stars == '4' ? whiteColor : greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
              filters(
                selected: stars,
                filter: '3',
                ontap: () {
                  setState(() {
                    stars = '3';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '3',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: stars == '3' ? whiteColor : greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
              filters(
                selected: stars,
                filter: '2',
                ontap: () {
                  setState(() {
                    stars = '2';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '2',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: stars == '2' ? whiteColor : greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
              filters(
                selected: stars,
                filter: '1',
                ontap: () {
                  setState(() {
                    stars = '1';
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '1',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: stars == '1' ? whiteColor : greyColor,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(width: 3),
                    const Icon(
                      Icons.star_rounded,
                      color: yellowColor,
                      size: 15,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      );
    });
  }

  filters({String filter, Function ontap, String selected, Widget child}) {
    return Padding(
      padding: const EdgeInsets.only(
        right: 8.1,
        bottom: fixPadding,
      ),
      child: InkWell(
        onTap: ontap,
        child: Container(
          constraints: BoxConstraints(minWidth: selected == stars ? 62 : 72),
          padding: const EdgeInsets.symmetric(
            horizontal: fixPadding,
            vertical: fixPadding / 2,
          ),
          decoration: BoxDecoration(
            color: selected == filter ? primaryColor : Colors.transparent,
            border: Border.all(
                color: selected == filter
                    ? primaryColor
                    : greyColor.withOpacity(0.4)),
            borderRadius: BorderRadius.circular(5),
          ),
          child: child,
        ),
      ),
    );
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
