import 'package:flutter/material.dart';
import '../models/bill_model.dart';

class BillCard extends StatelessWidget {
  final Bill bill;
  final VoidCallback onTap;

  const BillCard({Key? key, required this.bill, required this.onTap}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      elevation: 4,
      child: ListTile(
        title: Text(bill.description, style: TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Category: ${bill.category}'),
            Text('Amount: \$${bill.amount.toStringAsFixed(2)}'),
            Text('Due Date: ${bill.dueDate.toLocal().toString().split(' ')[0]}'), // Format date as needed
            Text('Status: ${bill.status}'),
          ],
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: onTap,
      ),
    );
  }
}
