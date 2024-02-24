import 'package:investment_zone/pages/screens.dart';
import 'package:investment_zone/widget/column_builder.dart';

class SearchResult extends StatefulWidget {
  final String filterCategory;
  final String filterType;
  final String filterInvestment;
  const SearchResult(
      {Key key, this.filterCategory, this.filterType, this.filterInvestment})
      : super(key: key);

  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  String category = 'Equity';
  String type = 'Growth';
  String investment = '<=Rs.500';
  String rated = 'CRISIL';
  String stars = '5';
  bool filterCategory = true;
  bool filterType = true;
  bool filterInvestment = true;

  final fundsList = [
    {
      'color': redColor,
      'title': 'Axis Top Securities',
      'rating': 5,
      'investment': 'Rs.1000',
      'category': 'Equity',
      'returns': '+20.13%',
    },
    {
      'color': purpleColor,
      'title': 'HDFC Securities',
      'rating': 4,
      'investment': 'Rs.1000',
      'category': 'Equity',
      'returns': '+20.13%',
    },
    {
      'color': indigoColor,
      'title': 'ICICI Producial',
      'rating': 3,
      'investment': 'Rs.800',
      'category': 'Equity',
      'returns': '+10.13%',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back),
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
              cursorColor: primaryColor,
              style: black16SemiBoldTextStyle,
              decoration: InputDecoration(
                hintText: 'High return funds',
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
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          heightSpace,
          heightSpace,
          heightSpace,
          heightSpace,
          Wrap(
            children: [
              widthSpace,
              widthSpace,
              filterCategory
                  ? filter(
                      widget.filterCategory,
                      () {
                        setState(() {
                          filterCategory = false;
                        });
                      },
                    )
                  : const SizedBox.shrink(),
              filterType
                  ? filter(
                      widget.filterType,
                      () {
                        setState(() {
                          filterType = false;
                        });
                      },
                    )
                  : const SizedBox.shrink(),
              filterInvestment
                  ? filter(
                      widget.filterInvestment,
                      () {
                        setState(() {
                          filterInvestment = false;
                        });
                      },
                    )
                  : const SizedBox.shrink(),
            ],
          ),
          funds(),
        ],
      ),
    );
  }

  filter(filter, Function ontap) {
    return Padding(
      padding: const EdgeInsets.only(left: fixPadding),
      child: Container(
        constraints: const BoxConstraints(minWidth: 72),
        padding: const EdgeInsets.symmetric(
          horizontal: fixPadding,
          vertical: fixPadding / 2,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: greyColor.withOpacity(0.4)),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              filter,
              textAlign: TextAlign.center,
              style: grey12MediumTextStyle,
            ),
            widthSpace,
            InkWell(
              onTap: ontap,
              child: const Icon(
                Icons.close,
                color: greyColor,
                size: 12,
              ),
            ),
          ],
        ),
      ),
    );
  }

  funds() {
    return ColumnBuilder(
      itemCount: fundsList.length,
      itemBuilder: (context, index) {
        final item = fundsList[index];
        return Padding(
          padding: const EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            fixPadding * 1.5,
            fixPadding * 2.0,
            0,
          ),
          child: InkWell(
            onTap: () => Navigator.push(
              context,
              PageTransition(
                child: FundDetail(
                  color: item['color'],
                  title: item['title'],
                  rating: item['rating'],
                  investment: item['investment'],
                  category: item['category'],
                  returns: item['returns'],
                ),
                type: PageTransitionType.rightToLeft,
              ),
            ),
            child: Container(
              padding: const EdgeInsets.all(fixPadding),
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
                          color: item['color'],
                          shape: BoxShape.circle,
                        ),
                        child: Text(item['title'].toString().substring(0, 1),
                            style: white14BoldTextStyle),
                      ),
                      widthSpace,
                      widthSpace,
                      Expanded(
                        child: Text(
                          item['title'],
                          style: black14MediumTextStyle,
                        ),
                      ),
                      ratingStars(item['rating']),
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
                            item['investment'],
                            style: green14BoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Category',
                            style: grey12RegularTextStyle,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['category'],
                            style: green14BoldTextStyle,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Text(
                            'Returns',
                            style: grey12RegularTextStyle,
                          ),
                          const SizedBox(height: 3),
                          Text(
                            item['returns'],
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
      builder: (context) {
        return Container(
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
                    onTap: () => Navigator.pop(context),
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
            ],
          ),
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
}
