import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:investment_zone/pages/portfolio/new_potfolio.dart';
import 'package:investment_zone/pages/screens.dart';

class BottomBar extends StatefulWidget {
  final String firstName, lastName;
  const BottomBar({Key key, this.firstName, this.lastName}) : super(key: key);

  @override
  _BottomBarState createState() => _BottomBarState();
}

int currentIndex = 0;

class _BottomBarState extends State<BottomBar> {
  DateTime currentBackPressTime;

  changeIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async {
          bool backStatus = onWillPop();
          if (backStatus) {
            exit(0);
          }
          return false;
        },
        child: (currentIndex == 0)
            ? Home()
            : (currentIndex == 1)
                ? NewPortfolio()
                : (currentIndex == 2)
                    ? StockList()
                    : Profile(
                        firstName: widget.firstName,
                        lastName: widget.lastName,
                      ),
      ),
      bottomNavigationBar: Container(
        height: 60.0,
        alignment: Alignment.center,
        child: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              getBottomBarItemTile(0, 'assets/icons/home.png', 'Home'),
              getBottomBarItemTile(1, 'assets/icons/vidhya.png', 'Portfolio'),
              getBottomBarItemTile(2, 'assets/icons/briefcase.png', 'Spenny'),
              getBottomBarItemTile(3, 'assets/icons/user.png', 'Profile'),
            ],
          ),
        ),
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime) > const Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: blackColor,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }

  getBottomBarItemTile(int index, String icon, String title) {
    return InkWell(
      focusColor: primaryColor,
      onTap: () {
        changeIndex(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            icon,
            height: 20,
            width: 20,
            color: (currentIndex == index) ? primaryColor : greyColor,
          ),
          heightSpace,
          Text(
            title,
            style: TextStyle(
              color: (currentIndex == index) ? primaryColor : greyColor,
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
