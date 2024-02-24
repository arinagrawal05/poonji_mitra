import 'package:investment_zone/pages/screens.dart';

class Notifications extends StatefulWidget {
  const Notifications({Key key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  final notificationList = [
    {
      'title': 'Failed!',
      'detail':
          'Your request to verify bank account has been fail. You can try after 2 days!',
      'time': '35 min ago',
    },
    {
      'title': 'Success!',
      'detail':
          'Your bank account successfully verified. Now you are able to set autoPay.',
      'time': '50 min ago',
    },
    {
      'title': 'Success!',
      'detail': 'You successfully purchased Axis Top Securities.',
      'time': '1 h ago',
    },
    {
      'title': 'Great!',
      'detail': 'Your autoPay request has been submitted successfully.',
      'time': '2 h ago',
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
          'Notifications',
          style: black18SemiBoldTextStyle,
        ),
      ),
      body: notificationList.isEmpty ? emptyList() : notifications(),
    );
  }

  emptyList() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Center(
          child: Icon(
            Icons.notifications_off_outlined,
            color: greyColor,
            size: 50,
          ),
        ),
        heightSpace,
        heightSpace,
        Text(
          'Notification List Is Empty',
          style: grey16MediumTextStyle,
        ),
      ],
    );
  }

  notifications() {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      itemCount: notificationList.length,
      itemBuilder: (context, index) {
        final item = notificationList[index];
        return Dismissible(
          key: Key('$item'),
          background: Container(
              margin: const EdgeInsets.only(top: fixPadding * 2.0),
              color: primaryColor),
          onDismissed: (direction) {
            setState(() {
              notificationList.removeAt(index);
            });
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("${item['title']} dismissed")));
          },
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              fixPadding * 2.0,
              fixPadding * 2.0,
              fixPadding * 2.0,
              0,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.all(fixPadding * 1.2),
                  decoration: BoxDecoration(
                    color: primaryColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: whiteColor, width: 2),
                    boxShadow: [
                      BoxShadow(
                        color: blackColor.withOpacity(0.1),
                        spreadRadius: 2,
                        blurRadius: 2,
                      ),
                    ],
                  ),
                  child: Image.asset(
                    'assets/icons/bell.png',
                    height: 20,
                    width: 20,
                    fit: BoxFit.cover,
                    color: whiteColor,
                  ),
                ),
                widthSpace,
                widthSpace,
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        item['title'],
                        style: black16SemiBoldTextStyle,
                      ),
                      Text(
                        item['detail'],
                        style: grey12MediumTextStyle,
                      ),
                      heightSpace,
                      heightSpace,
                      Text(
                        item['time'],
                        style: grey12SemiBoldTextStyle,
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        );
      },
    );
  }
}
