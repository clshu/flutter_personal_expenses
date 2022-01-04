import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function setData;

  final titelController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.setData);

  void onSubmittedData() {
    final submittedTitle = titelController.text;
    final submittedAmount = amountController.text.isEmpty
        ? -1
        : double.parse(amountController.text);

    if (submittedTitle.isEmpty || submittedAmount < 0) {
      return;
    }

    setData(submittedTitle, submittedAmount);
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
