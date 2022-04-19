import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:habitrush/components/custom_card_componet.dart';
import 'package:habitrush/components/transaction_card.dart';
import 'package:habitrush/routes/home_screen.dart';
import 'package:lottie/lottie.dart';

class PurchasesPage extends StatefulWidget {
  const PurchasesPage({Key? key}) : super(key: key);

  @override
  _PurchasesPageState createState() => _PurchasesPageState();
}

class _PurchasesPageState extends State<PurchasesPage>
    with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          "Transactions",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        leading: IconButton(
          icon: Icon(Icons.close),
          tooltip: 'Close',
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: ListView(
          children: const <Widget>[
            TransactionCard("plus member plan", "20 Jan", "99", "INR", "debit"),
            TransactionCard("Daily challenge", "21 Jan", "21", "RC", "credit"),
          ],
        ),
      ),
    );
  }
}
