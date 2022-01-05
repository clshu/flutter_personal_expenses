import 'package:flutter/material.dart';
import '../helpers/double_extension.dart';

class NewTransaction extends StatefulWidget {
  final Function setData;

  NewTransaction(this.setData);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titelController = TextEditingController();

  final amountController = TextEditingController();

  void onSubmittedData() {
    final submittedTitle = titelController.text;
    final submittedAmount = amountController.text.isEmpty
        ? -1
        : double.parse(amountController.text).roundedPrecision(2);

    if (submittedTitle.isEmpty || submittedAmount < 0) {
      return;
    }
    // print('title: ${submittedTitle} amount: ${submittedAmount}');
    widget.setData(submittedTitle, submittedAmount);

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titelController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => onSubmittedData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => onSubmittedData(),
            ),
            TextButton(
                onPressed: onSubmittedData,
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.purple),
                ))
          ],
        ),
      ),
    );
  }
}
