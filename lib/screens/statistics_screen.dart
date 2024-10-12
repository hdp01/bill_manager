import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import '../services/bill_service.dart';
import '../models/bill_model.dart';

class StatisticsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bills = BillService.getAllBills();

    // Calculate total amount and bills
    double totalAmount = bills.fold(0, (sum, bill) => sum + bill.amount);
    int totalBills = bills.length;

    // Group bills by category
    Map<String, double> categoryTotals = {};
    for (var bill in bills) {
      categoryTotals[bill.category] = (categoryTotals[bill.category] ?? 0) + bill.amount;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Statistics'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Total Bills: $totalBills', style: TextStyle(fontSize: 24)),
            Text('Total Amount: \$${totalAmount.toStringAsFixed(2)}', style: TextStyle(fontSize: 24)),
            SizedBox(height: 20),
            Text('Expenditure by Category', style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _getChartSections(categoryTotals),
                  borderData: FlBorderData(show: false),
                  centerSpaceRadius: 40,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<PieChartSectionData> _getChartSections(Map<String, double> categoryTotals) {
    List<PieChartSectionData> sections = [];
    int i = 0;

    categoryTotals.forEach((category, amount) {
      sections.add(
        PieChartSectionData(
          value: amount,
          title: '\$${amount.toStringAsFixed(2)}',
          color: _getColor(i),
          radius: 30,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      i++;
    });

    return sections;
  }

  Color _getColor(int index) {
    switch (index) {
      case 0:
        return Colors.blue;
      case 1:
        return Colors.red;
      case 2:
        return Colors.green;
      case 3:
        return Colors.orange;
      default:
        return Colors.purple;
    }
  }
}
