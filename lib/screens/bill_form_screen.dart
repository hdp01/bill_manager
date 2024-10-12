import 'package:flutter/material.dart';
import 'package:file_picker/file_picker.dart';
import 'package:intl/intl.dart';
import '../models/bill_model.dart';
import '../services/bill_service.dart';

class BillFormScreen extends StatefulWidget {
  @override
  _BillFormScreenState createState() => _BillFormScreenState();
}

class _BillFormScreenState extends State<BillFormScreen> {
  final _formKey = GlobalKey<FormState>();
  String? description;
  String? category;
  double? amount;
  DateTime? dueDate;
  String status = 'Unpaid';
  dynamic uploadedFile;

  final List<String> categories = ['Utilities', 'Rent', 'Groceries', 'Others'];

  Future<void> _pickFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      setState(() {
        uploadedFile = result.files.first;
      });
    }
  }

  Future<void> _pickDueDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
    );
    if (picked != null && picked != dueDate)
      setState(() {
        dueDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add New Bill'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Description'),
                onSaved: (value) => description = value,
                validator: (value) => value!.isEmpty ? 'Enter description' : null,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(labelText: 'Category'),
                items: categories.map((String category) {
                  return DropdownMenuItem(value: category, child: Text(category));
                }).toList(),
                onChanged: (value) {
                  category = value as String?;
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSaved: (value) => amount = double.tryParse(value!),
                validator: (value) =>
                value!.isEmpty ? 'Enter amount' : null,
              ),
              ListTile(
                title: Text(dueDate == null
                    ? 'Select Due Date'
                    : DateFormat.yMMMd().format(dueDate!)),
                trailing: Icon(Icons.calendar_today),
                onTap: () => _pickDueDate(context),
              ),
              ListTile(
                title: Text(uploadedFile == null
                    ? 'Upload Bill'
                    : 'File Selected: ${uploadedFile.name}'),
                trailing: Icon(Icons.attach_file),
                onTap: _pickFile,
              ),
              SizedBox(height: 20),
              ElevatedButton(
                child: Text('Save'),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _formKey.currentState!.save();
                    BillService.addBill(
                      Bill(
                        description: description!,
                        category: category!,
                        amount: amount!,
                        dueDate: dueDate!,
                        status: status,
                        uploadedFile: uploadedFile,
                      ),
                    );
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
