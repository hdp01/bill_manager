import 'package:flutter/material.dart';
import '../models/bill_model.dart';
import '../services/bill_service.dart';

class EditBillScreen extends StatefulWidget {
  final Bill bill;

  const EditBillScreen({required this.bill, Key? key}) : super(key: key);

  @override
  _EditBillScreenState createState() => _EditBillScreenState();
}

class _EditBillScreenState extends State<EditBillScreen> {
  final _formKey = GlobalKey<FormState>();
  late String description;
  late String category;
  late double amount;
  late DateTime dueDate;

  @override
  void initState() {
    super.initState();
    description = widget.bill.description;
    category = widget.bill.category;
    amount = widget.bill.amount;
    dueDate = widget.bill.dueDate;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Bill'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                initialValue: description,
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value!,
              ),
              TextFormField(
                initialValue: category,
                decoration: InputDecoration(labelText: 'Category'),
                onSaved: (value) => category = value!,
              ),
              TextFormField(
                initialValue: amount.toString(),
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => amount = double.parse(value!),
              ),
              // Add Date Picker and File Picker as before
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save Changes'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    BillService.updateBill(widget.bill, description, category, amount, dueDate);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
