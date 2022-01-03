import 'package:flutter/material.dart';

import '../models/transaction.dart';
import './new_traction.dart';
import './transaction_list.dart';

class UserTransaction extends StatefulWidget {
  @override
  _UserTransactionState createState() => _UserTransactionState();
}

class _UserTransactionState extends State<UserTransaction> {
  String _titleInput = '';
  String _amountInput = '';

  final List<Transaction> _userTransactions = [
    Transaction(
        id: '001', title: 'New Shoes', amount: 99.7, date: DateTime.now()),
    Transaction(id: '002', title: 'Lunch', amount: 17.5, date: DateTime.now()),
  ];

  void setData({String titleInput = '', String amountInput = ''}) {
    _titleInput = titleInput;
    _amountInput = amountInput;
    print('title: ${_titleInput} amount: ${_amountInput}');
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        NewTransaction(setData),
        TransactionList(_userTransactions),
      ],
    );
  }
}
