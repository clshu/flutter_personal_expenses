import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function setData;

  NewTransaction(this.setData);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titelController = TextEditingController();

  final _amountController = TextEditingController();

  bool _dateChosen = false;
  DateTime _selectedDate = DateTime.now();

  void _onSubmittedData() {
    final submittedTitle = _titelController.text;
    final submittedAmount = _amountController.text.isEmpty
        ? -1
        : num.parse(_amountController.text).toDouble();

    if (submittedTitle.isEmpty || submittedAmount < 0 || !_dateChosen) {
      return;
    }
    // print('title: ${submittedTitle} amount: ${submittedAmount}');
    widget.setData(submittedTitle, submittedAmount, _selectedDate);

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _dateChosen = true;
        _selectedDate = pickedDate;
      });
    });
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
              controller: _titelController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _onSubmittedData(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _amountController,
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              onSubmitted: (_) => _onSubmittedData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Text(
                    !_dateChosen
                        ? 'No Date Chosen!'
                        : DateFormat.yMd().format(_selectedDate),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: Text(
                      'Choose Date',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
                onPressed: _onSubmittedData,
                child: Text(
                  'Add Transaction',
                ))
          ],
        ),
      ),
    );
  }
}
