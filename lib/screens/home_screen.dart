import 'package:flutter/material.dart';
import 'bill_list_screen.dart';
import 'bill_form_screen.dart'; // Import BillFormScreen
import 'statistics_screen.dart'; // Import StatisticsScreen

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      _isDarkMode = !_isDarkMode;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bill Manager'),
        actions: [
          IconButton(
            icon: Icon(_isDarkMode ? Icons.wb_sunny : Icons.nights_stay),
            onPressed: _toggleTheme,
          ),
        ],
      ),
      body: Center(
        child: GridView.count(
          padding: EdgeInsets.all(16.0),
          crossAxisCount: 2,
          children: [
            _buildCard(
              context,
              'View Bills',
              Icons.receipt,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BillListScreen()),
                );
              },
            ),
            _buildCard(
              context,
              'Add New Bill',
              Icons.add,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BillFormScreen()),
                );
              },
            ),
            _buildCard(
              context,
              'View Statistics',
              Icons.bar_chart,
                  () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => StatisticsScreen()),
                );
              },
            ),
            _buildCard(
              context,
              'Logout',
              Icons.logout,
                  () {
                // Handle logout functionality here
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Logged out successfully!')),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData icon, VoidCallback onTap) {
    return Card(
      margin: EdgeInsets.all(8.0),
      child: InkWell(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 40.0),
              SizedBox(height: 10.0),
              Text(
                title,
                style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
