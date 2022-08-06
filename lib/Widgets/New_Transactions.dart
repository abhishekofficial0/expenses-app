import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class NewTransations extends StatefulWidget {
  final Function addTx;

  NewTransations(this.addTx);

  @override
  _NewTransationsState createState() => _NewTransationsState();
}

class _NewTransationsState extends State<NewTransations> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime _selectedDate;

  void _submitData() {
    if (_amountController.text.isEmpty) {
      return;
    }
    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presntDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              right: 10,
              left: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) => _submitData,
              ),
              TextField(
                autofocus: true,
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => _submitData,
              ),
              Container(
                height: 75,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Dates chosen!'
                            : 'Picked Date : ${DateFormat.yMMMd().format(_selectedDate)}',
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                         // color: Colors.blue,
                            child: Text(
                              'Chose date!!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presntDatePicker,
                          )
                        : FlatButton(
                            textColor: Theme.of(context).primaryColor,
                            child: Text(
                              'Chose date!!',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _presntDatePicker,
                          ),
                  ],
                ),
              ),
              RaisedButton(
                child: Text('Add Transaction'),
                color: Theme.of(context).primaryColor,
                textColor: Theme.of(context).textTheme.button.color,
                onPressed: _submitData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
