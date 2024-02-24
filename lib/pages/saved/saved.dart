import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:investment_zone/pages/screens.dart';

class Saved extends StatefulWidget {
  const Saved({Key key}) : super(key: key);

  @override
  State<Saved> createState() => _SavedState();
}

class _SavedState extends State<Saved> {
  final saveList = [
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
    {
      'color': blueColor,
      'title': 'TATA Index Fund',
      'rating': 3,
      'investment': 'Rs.800',
      'category': 'Equity',
      'returns': '+10.13%',
    },
    {
      'color': cyanColor,
      'title': 'Sun Bank Direct Plan Growth',
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
        title: Text(
          'Saved',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: saveList.isEmpty ? emptyList() : savedList(),
    );
  }

  emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.bookmark_outline,
            color: greyColor,
            size: 50,
          ),
        ),
        heightSpace,
        heightSpace,
        Text(
          'Save List Is Empty',
          style: grey16MediumTextStyle,
        ),
      ],
    );
  }

  savedList() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: saveList.length,
      itemBuilder: (context, index) {
        final item = saveList[index];
        return Slidable(
          actionPane: const SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          secondaryActions: [
            Padding(
              padding: EdgeInsets.only(
                  top: index == 0 ? fixPadding * 2.0 : fixPadding * 1.5),
              child: IconSlideAction(
                caption: 'Delete',
                color: primaryColor,
                icon: Icons.delete,
                foregroundColor: whiteColor,
                onTap: () {
                  setState(() {
                    saveList.removeAt(index);
                  });
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Item Remove From Save List.'),
                  ));
                },
              ),
            ),
          ],
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              index == 0 ? fixPadding * 2.0 : fixPadding * 1.5,
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
}
