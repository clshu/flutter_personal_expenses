import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

import './widgets/chart.dart';
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
        // primarySwatch: Colors.purple,
        // accentColor: Colors.amber,
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.purple,
          accentColor: Colors.amber,
        ),
        fontFamily: 'Quicksand',
        textTheme: TextTheme(
            // title
            headline6: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
            // body2
            bodyText1: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
            // body
            bodyText2: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 12,
            )),
        appBarTheme: AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'OpenSans',
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
          // textTheme: ThemeData.light().textTheme.copyWith(
          //   title: TextStyle(
          //   fontFamily: 'OpenSans',
          //   fontWeight: FontWeight.bold,
          //   fontSize: 20,
          // ),
        ),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _userTransactions = [
    // Transaction(
    //   id: '001',
    //   title: 'New Shoes',
    //   amount: 99.7,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: '002',
    //   title: 'Lunch',
    //   amount: 17.5,
    //   date: DateTime.now(),
    // ),
  ];

  bool _showChart = false;

  List<Transaction> get _recentTransactions {
    return _userTransactions.where((tx) {
      return tx.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(String title, double amount, DateTime date) {
    final now = DateTime.now();
    final newTx = Transaction(
      id: now.toString(),
      title: title,
      amount: amount,
      date: date,
    );

    setState(() {
      _userTransactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransactions.removeWhere((tx) => tx.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => NewTransaction(_addNewTransaction),
    );
  }

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final _isLandscape = mediaQuery.orientation == Orientation.landscape;
    print(_isLandscape);
    final _appBar = AppBar(
      title: Text('Personal Expenses'),
      actions: [
        IconButton(
          onPressed: () => _startAddNewTransaction(context),
          icon: Icon(Icons.add),
        ),
      ],
    );

    Widget _renderChart(double heightFactor) {
      // mediaQuery.padding.top is
      // the height of the status bar
      return Container(
          height: (mediaQuery.size.height -
                  _appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              heightFactor,
          child: Chart(_recentTransactions));
    }

    Widget _renderTransactionList(double heightFactor) {
      // mediaQuery.padding.top is
      // the height of the status bar
      return Container(
          height: (mediaQuery.size.height -
                  _appBar.preferredSize.height -
                  mediaQuery.padding.top) *
              heightFactor,
          child: TransactionList(_userTransactions, _deleteTransaction));
    }

    return Scaffold(
      appBar: _appBar,
      body: SingleChildScrollView(
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            if (_isLandscape)
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Show Chart',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Switch(
                      activeColor: Theme.of(context).colorScheme.primary,
                      value: _showChart,
                      onChanged: (val) {
                        setState(() {
                          _showChart = val;
                        });
                      })
                ],
              ),
            if (!_isLandscape) _renderChart(0.3),
            if (!_isLandscape) _renderTransactionList(0.7),
            if (_isLandscape)
              _showChart ? _renderChart(0.7) : _renderTransactionList(0.7),
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => _startAddNewTransaction(context),
      ),
    );
  }
}
