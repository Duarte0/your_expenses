import 'dart:math';

import 'package:expenses/components/chart.dart';
import 'package:expenses/components/transaction_form.dart';
import 'package:expenses/components/transaction_list.dart';
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';

void main(List<String> args) {
  runApp(const ExpensesApp());
}

class ExpensesApp extends StatelessWidget {
  const ExpensesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const MyHomePage(),
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.black,
            primary: const Color(0xFF395886),
            secondary: const Color(0xFFB1C9EF)),
        textTheme: const TextTheme(
            titleSmall: TextStyle(
          fontFamily: 'RobotoMono',
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        )),
        fontFamily: 'RobotoMono',
        appBarTheme: const AppBarTheme(
            color: Color(0xFF395886),
            centerTitle: true,
            titleTextStyle: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'RobotoMono',
            )),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final List<Transaction> _transactions = [];

  List<Transaction> get _recentTransactions {
    return _transactions.where((tr) {
      return tr.date.isAfter(DateTime.now().subtract(const Duration(days: 7)));
    }).toList();
  }

  _addTransaction(String title, double value, DateTime date) {
    final newTransaction = Transaction(
      id: Random().nextDouble().toString(),
      title: title,
      value: value,
      date: date,
    );

    setState(() {
      _transactions.add(newTransaction);
    });

    Navigator.of(context).pop();
  }

  _openTransactionFormModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) {
        return TransactionForm(_addTransaction);
      },
    );
  }

  _removeTransaction(String id) {
    setState(() {
      _transactions.removeWhere((tr) {
        return tr.id == id;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Despesas Pessoais'),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () => _openTransactionFormModal(context),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(children: <Widget>[
          Chart(_recentTransactions),
          TransactionList(_transactions, _removeTransaction)
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),
        backgroundColor: Theme.of(context).colorScheme.secondary,
        onPressed: () => _openTransactionFormModal(context),
        child: const Icon(
          Icons.add,
          size: 30,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
