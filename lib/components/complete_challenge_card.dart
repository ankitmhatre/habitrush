import 'package:flutter/material.dart';

class CompletedChallengesCard extends StatelessWidget {
  final String titleText;
  final String dateText;
  final String amountText;
  final String currencyText;

  const CompletedChallengesCard(
      this.titleText, this.dateText, this.amountText, this.currencyText);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        elevation: 8,
        margin: EdgeInsets.all(8),
        child: Container(
          margin: EdgeInsets.only(left: 15, right: 15, top: 8, bottom: 8),
          height: 96.0,
          child: Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Expanded(
                  flex: 10,
                  child: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          titleText,
                          style: const TextStyle(
                              fontWeight: FontWeight.w700, fontSize: 18),
                        ),
                        Card(
                          color: Color.fromARGB(255, 246, 246, 246),
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(20.0),
                            ),
                          ),
                          elevation: 0,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Text(
                              "${amountText} ${currencyText}",
                              style: const TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 12.0,
                                  color: Colors.grey),
                            ),
                          ),
                        ),
                        Text(
                          dateText,
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 12.0,
                              color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ),
                // Expanded(
                //   flex: 2,
                //   child: Container(
                //     child: Column(
                //       crossAxisAlignment: CrossAxisAlignment.center,
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Text(
                //           amountText,
                //           style: TextStyle(
                //               fontWeight: FontWeight.w700,
                //               fontSize: 24.0,
                //               color: transactionTypeText == "credit"
                //                   ? Colors.green
                //                   : Colors.red),
                //         ),
                //         Text(
                //           currencyText,
                //           style: TextStyle(
                //               fontWeight: FontWeight.w500,
                //               fontSize: 18.0,
                //               color: transactionTypeText == "credit"
                //                   ? Colors.green
                //                   : Colors.red),
                //         )
                //       ],
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
