import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';
import '../helpers/double_extension.dart';
import './chart_bar.dart';

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
        // print(DateFormat.E().format(weekDay));
        // print(totalSum);
        return {
          'day': DateFormat.E().format(weekDay).substring(0, 1),
          'amount': totalSum.roundedPrecision(2),
        };
      },
    );
  }

  // getter can not promote the nullable to non nullable
  // Use this wrapper to do the job.
  double getTotalSpending() {
    return groupTransactionValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  get totalSpending {
    return getTotalSpending();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        children: groupTransactionValues
            .map(
              (e) => ChartBar(
                e['day'] as String,
                e['amount'] as double,
                totalSpending == 0.0
                    ? 0.0
                    : (e['amount'] as double) / totalSpending,
              ),
            )
            .toList(),
      ),
    );
  }
}
