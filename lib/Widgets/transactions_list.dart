import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deleteTx;

  TransactionList(this.transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: transactions.isEmpty
          ? LayoutBuilder(
              builder: (ctx, constraints) {
                return Column(
                  children: <Widget>[
                    Text(
                      'No transactions is added yet!',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Image.asset('assets/images/waiting.png'),
                      height: constraints.maxHeight * 0.75,
                    ),
                  ],
                );
              },
            )
          : ListView.builder(
              itemBuilder: (ctx, index) {
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  elevation: 5,
                  child: ListTile(
                    leading: FittedBox(
                      child: CircleAvatar(
                        radius: 50,
                        child: Padding(
                          padding: EdgeInsets.all(5),
                          child: FittedBox(
                            child: Text(
                              'Rs ${transactions[index].amount.toStringAsFixed(0)}',
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    title: Text(
                      transactions[index].title,
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    subtitle: Text(
                      DateFormat.yMMMd().format(transactions[index].date),
                    ),
                    trailing: MediaQuery.of(context).size.width > 460
                        ? FlatButton.icon(
                            onPressed: () => deleteTx(transactions[index].id),
                            icon: Icon(Icons.delete),
                            label: Text('Delete'),
                            textColor: Theme.of(context).errorColor,
                          )
                        : IconButton(
                            icon: Icon(Icons.delete),
                            color: Theme.of(context).errorColor,
                            onPressed: () => deleteTx(transactions[index].id),
                          ),
                  ),
                );
              },
              itemCount: transactions.length,
            ),
    );
  }
}
