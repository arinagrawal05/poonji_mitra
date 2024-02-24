import 'package:flutter/material.dart';
// import 'package:stock_watchlist/screens/add_stock.dart';
import 'package:investment_zone/classes/stock_class.dart';
import 'package:investment_zone/models/db_helper.dart';
import 'dart:convert';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:permission_handler/permission_handler.dart';

import '../home/home.dart';

List<Stock> favs = [];
final db = StockDataBase();
//  final Permission _permission;
//   PermissionStatus _permissionStatus = PermissionStatus.denied;

void addStockToDb(Stock stock) async {
  await db.addStock(stock);
}

Future<String> loadStockAsset() async {
  return await rootBundle.loadString('assets/stocks.json');
}

class StockList extends StatefulWidget {
  @override
  _StockListState createState() => _StockListState();
}

class _StockListState extends State<StockList> {
  void setupList() async {
    var stocks = await db.fetchAll();
    setState(() {
      favs = stocks;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF7EBE1),
      body: SafeArea(
          child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/banner/spennyBanner.png',
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            Text('sPenny', style: GoogleFonts.bebasNeue(fontSize: 52)),
            const SizedBox(height: 10),
            const Text('Convert your spending',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const Text('into investments',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
            const SizedBox(height: 20),

            Container(
              margin: const EdgeInsets.all(20),
              child: const Text(
                  'Every time make transactions on Major shopping platforms, we calculate the round up and that tiny money is added to poonji wallet. Once the money reaches 500 INR. We automatically invest it for you in liquid funds',
                  style: TextStyle(
                    fontSize: 16,
                  )),
            ),

            const SizedBox(height: 12),

            // Password Field

            const SizedBox(height: 12),

            // Button

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.circular(12)),
                child: Center(
                    child: Row(
                  children: [
                    InkWell(
                      onTap: () {
                        //askPermission();
                        // Navigator.push(
                        //   context,
                        //   MaterialPageRoute(builder: (context) => Home()),
                        // );
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Device not Compatible'),
                          ),
                        );
                      },
                      child: const Text('Enroll Me',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 18)),
                    )
                  ],
                )),
              ),
            ),

            const SizedBox(height: 25),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text('Have some doubts ?',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                const Text(' Contact your Mitra',
                    style: TextStyle(
                        color: Colors.blue, fontWeight: FontWeight.bold))
              ],
            )
          ],
        ),
      )),
    );
  }

  Future<bool> askPermission() async {
    PermissionStatus status = await Permission.sms.request();
    if (status.isDenied == true) {
      askPermission();

      // set up the button
      Widget okButton = TextButton(
        child: const Text("OK"),
        onPressed: () {},
      );

      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("sPenny Enroll"),
        content: const Text("Thank you for opting sPenyy."),
        actions: [
          okButton,
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      // set up the AlertDialog
      AlertDialog alert = const AlertDialog(
        title: Text("sPenny Enroll"),
        content: Text("You are already enrolled."),
        actions: [],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );

      return true;
    }
  }
}
