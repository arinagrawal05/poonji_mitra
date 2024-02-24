import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:investment_zone/pages/screens.dart';

class Category extends StatefulWidget {
  final String category;
  const Category({Key key, this.category}) : super(key: key);

  @override
  State<Category> createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  @override
  void initState() {
    super.initState();
    getFundsList();
  }

  String category = '';
  String type = 'Growth';
  String investment = '<=Rs.500';
  String rated = 'CRISIL';
  String stars = '5';

  var new_fundList = [];

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
          color: Colors.white,
        ),
        title: Text(
          '${widget.category} Funds',
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
                hintText: 'Search funds',
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
      itemCount: new_fundList.length,
      itemBuilder: (context, index) {
        final item = new_fundList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            index == 0 ? fixPadding * 2.0 : 0,
            fixPadding * 2.0,
            fixPadding * 1.5,
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                child: FundDetail(
                    color: indigoColor,
                    title: item['fundName'],
                    rating: 5,
                    investment: 'Rs ' + item['minimumSIP'],
                    category: item['nav'],
                    returns: item['fiveYearCAGR'],
                    isin: item['isin'],
                    jsonString: jsonEncode(item).toString()),
                type: PageTransitionType.rightToLeft,
              ),
            ),
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
                        height: 30,
                        width: 30,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: Colors.indigo,
                          shape: BoxShape.circle,
                        ),
                        child: Text(item['fundName'].toString().substring(0, 1),
                            style: white14BoldTextStyle),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Text(
                          item['fundName'],
                          style: white14RegularTextStyle,
                        ),
                      ),
                      ratingStars(5),
                    ],
                  ),
                  const SizedBox(height: 13),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          Text(
                            'Min Investment',
                            style: grey12RegularTextStyle,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            'Rs ' + item['minimumSIP'],
                            style: green14BoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Nav',
                            style: grey12RegularTextStyle,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['nav'],
                            style: green14BoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Returns 5Y',
                            style: grey12RegularTextStyle,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['fiveYearCAGR'],
                            style: red14BoldTextStyle,
                          ),
                        ],
                      ),
                    ],
                  ),
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

  Future<void> getFundsList() async {
    Map<String, String> headers = {'Content-Type': 'application/json'};

    var response = await http.get(
        Uri.parse('http://api.poonjimitra.com/api/fund'),
        headers: headers);
    var jsonData = jsonDecode(response.body);
    var nnew_fundList = await jsonData;

    setState(() {
      for (var items in nnew_fundList) {
        if (items['categoryID'] == widget.category) {
          new_fundList.add(items);
        }
      }
    });

    // new_fundList = nnew_fundList.w((item) => item.categoryID != category);
  }
}
