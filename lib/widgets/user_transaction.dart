import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_traction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  final List<Transaction> _userTransactions = [
    Transaction(
        id: '001', title: 'New Shoes', amount: 99.7, date: DateTime.now()),
    Transaction(id: '002', title: 'Lunch', amount: 17.5, date: DateTime.now()),
  ];

  void _addNewTransaction(String title, double amount) {
    final now = DateTime.now();
    final newTx = Transaction(
      id: now.toString(),
      title: title,
      amount: amount,
      date: now,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(_addNewTransaction),
        TransactionList(_userTransactions),
      ],
    );
  }
}
