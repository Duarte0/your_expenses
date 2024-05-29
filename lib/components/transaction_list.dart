
import 'package:expenses/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transaction;
  final Function(String) onRemove;

  const TransactionList(
    this.transaction,
    this.onRemove, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 355,
        child: transaction.isEmpty
            ? Column(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Nenhuma Transação Cadastrada!',
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 200,
                    child: Image.asset(
                      'assets/images/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  )
                ],
              )
            : ListView.builder(
                itemCount: transaction.length,
                itemBuilder: (context, index) {
                  final tr = transaction[index];
                  return Card(
                    elevation: 5,
                    margin: const EdgeInsets.symmetric(
                      horizontal: 5, 
                      vertical: 8
                    ),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Theme.of(context).primaryColor,
                        radius: 30,
                        child: Padding(
                          padding: const EdgeInsets.all(6),
                          child: FittedBox(
                            child: Text(
                              'R\$${tr.value}',
                              style: const TextStyle(
                                color: Colors.white
                              ),
                            ),
                          ),
                        ),
                      ),
                      title: Text(
                        tr.title,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      subtitle: Text(
                        DateFormat('d MMM y').format(tr.date)
                      ),
                      trailing: IconButton(
                        onPressed: () => onRemove(tr.id),
                        icon: const Icon(Icons.delete),
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  );
                },
              ));
  }
}
