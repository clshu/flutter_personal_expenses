import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function setData;

  final titelController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction(this.setData);

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
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
            ),
            TextButton(
                onPressed: () {
                  setData(titelController.text,
                      double.tryParse(amountController.text) ?? -1);
                },
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
