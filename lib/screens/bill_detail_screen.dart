import 'package:flutter/material.dart';
import '../models/bill_model.dart';

class BillDetailScreen extends StatelessWidget {
  final Bill bill;

  const BillDetailScreen({required this.bill, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Details'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Description: ${bill.description}', style: TextStyle(fontSize: 18)),
            SizedBox(height: 10),
            Text('Category: ${bill.category}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Amount: \$${bill.amount.toStringAsFixed(2)}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Due Date: ${bill.dueDate.toLocal()}', style: TextStyle(fontSize: 16)),
            SizedBox(height: 10),
            Text('Status: ${bill.status}', style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
