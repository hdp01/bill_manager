import 'package:flutter/material.dart';
import '../services/bill_service.dart';
import 'bill_detail_screen.dart';
import '../widgets/bill_card.dart';
import '../models/bill_model.dart';

class BillListScreen extends StatefulWidget {
  @override
  _BillListScreenState createState() => _BillListScreenState();
}

class _BillListScreenState extends State<BillListScreen> {
  List<Bill> _bills = [];
  List<Bill> _filteredBills = [];
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _bills = BillService.getAllBills();
    _filteredBills = _bills;
  }

  void _filterBills(String query) {
    if (query.isNotEmpty) {
      setState(() {
        _filteredBills = _bills
            .where((bill) => bill.description.toLowerCase().contains(query.toLowerCase()))
            .toList();
      });
    } else {
      setState(() {
        _filteredBills = _bills;
      });
    }
  }

  void _sortBills() {
    setState(() {
      _filteredBills.sort((a, b) => a.amount.compareTo(b.amount));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill List'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.pushNamed(context, '/addBill');
            },
          ),
          IconButton(
            icon: Icon(Icons.sort),
            onPressed: _sortBills,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: _filterBills,
              decoration: InputDecoration(
                labelText: 'Search Bills',
                border: OutlineInputBorder(),
                suffixIcon: Icon(Icons.search),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _filteredBills.length,
              itemBuilder: (context, index) {
                return BillCard(
                  bill: _filteredBills[index],
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => BillDetailScreen(bill: _filteredBills[index]),
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
