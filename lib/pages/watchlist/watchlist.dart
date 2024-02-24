import 'package:investment_zone/pages/screens.dart';

class Watchlist extends StatefulWidget {
  const Watchlist({Key key}) : super(key: key);

  @override
  _WatchlistState createState() => _WatchlistState();
}

class _WatchlistState extends State<Watchlist> {
  final watchList = [
    {
      'color': redColor,
      'logoName': 'ASTRAL',
      'companyName': 'Astral Ltd',
      'amount': 'Rs. 2,589,40',
      'currentValue': '1.15%',
      'up': false,
    },
    {
      'color': indigoColor,
      'logoName': 'ATUL',
      'companyName': 'Atul Ltd',
      'amount': 'Rs. 9,250,20',
      'currentValue': '0.10%',
      'up': false,
    },
    {
      'color': purpleColor,
      'logoName': 'DMART',
      'companyName': 'Avenue Supermarts Ltd',
      'amount': 'Rs. 3,394,00',
      'currentValue': '1.18%',
      'up': true,
    },
    {
      'color': cyanColor,
      'logoName': 'BAJAJ',
      'companyName': 'Bajaj Finance Ltd',
      'amount': 'Rs. 3,309,00',
      'currentValue': '0.67%',
      'up': true,
    },
    {
      'color': blueColor,
      'logoName': 'I MART',
      'companyName': 'IndiaMART Intermesh Ltd',
      'amount': 'Rs. 7,509,00',
      'currentValue': '0.41%',
      'up': true,
    },
    {
      'color': greenColor,
      'logoName': 'BAJAJ',
      'companyName': 'Bajaj Auto Ltd',
      'amount': 'Rs. 9,250,20',
      'currentValue': '0.10%',
      'up': false,
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
          'Watchlist',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: watchList.isEmpty ? emptyList() : watchlist(),
    );
  }

  emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.watch_later_outlined,
            color: greyColor,
            size: 50,
          ),
        ),
        heightSpace,
        heightSpace,
        Text(
          'Watchlist Is Empty',
          style: grey16MediumTextStyle,
        ),
      ],
    );
  }

  watchlist() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: watchList.length,
      itemBuilder: (context, index) {
        final item = watchList[index];
        return Padding(
          padding: EdgeInsets.fromLTRB(
            fixPadding * 2.0,
            index == 0 ? fixPadding * 2.0 : 0,
            fixPadding * 2.0,
            fixPadding * 1.5,
          ),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 60,
                          height: 20,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: item['color'],
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            item['logoName'],
                            style: white10BoldTextStyle,
                          ),
                        ),
                        heightSpace,
                        Text(
                          item['companyName'],
                          overflow: TextOverflow.ellipsis,
                          style: black14MediumTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          item['amount'],
                          style: black16SemiBoldTextStyle,
                        ),
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Icon(
                                item['up']
                                    ? Icons.arrow_upward
                                    : Icons.arrow_downward,
                                color: item['up'] ? greenColor : Colors.red,
                                size: 14,
                              ),
                              Expanded(
                                child: Text(
                                  item['currentValue'],
                                  style: item['up']
                                      ? green16SemiBoldTextStyle
                                      : red16SemiBoldTextStyle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            setState(() {
                              watchList.removeAt(index);
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                  content: Text(
                                      '${item['companyName']} Remove From Watchlist')),
                            );
                          },
                          child: const Icon(
                            Icons.close,
                            color: greyColor,
                            size: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              divider(),
            ],
          ),
        );
      },
    );
  }

  divider() {
    return Container(
      margin: const EdgeInsets.only(top: fixPadding),
      color: greyColor.withOpacity(0.4),
      height: 1,
      width: double.infinity,
    );
  }
}
