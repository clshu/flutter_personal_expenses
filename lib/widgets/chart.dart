import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  // const Chart({Key? key}) : super(key: key);

  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupTransactionValues {
    return List.generate(
      7,
      (index) {
        final weekDay = DateTime.now().subtract(Duration(days: index));

        var totalSum = 0.0;

        for (var i = 0; i < recentTransactions.length; i++) {
          final recentDay = recentTransactions[i].date;

          if (recentDay.year == weekDay.year &&
              recentDay.month == weekDay.month &&
              recentDay.day == weekDay.day) {
            totalSum += recentTransactions[i].amount;
          }
        }
        print(DateFormat.E(weekDay));
        print(totalSum);
        return {'day': DateFormat.E(weekDay), 'amount': totalSum};
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Card(
        child: Row(
          children: [],
        ),
      ),
    );
  }
}
