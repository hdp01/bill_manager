import '../models/bill_model.dart';

class BillService {
  static List<Bill> bills = [];

  static bool addBill(Bill bill) {
    if (bill != null) {
      bills.add(bill);
      return true; // Success
    }
    return false; // Failure
  }

  static List<Bill> getAllBills() {
    return List.unmodifiable(bills); // Return an unmodifiable list
  }

  static bool deleteBill(int index) {
    if (index >= 0 && index < bills.length) {
      bills.removeAt(index);
      return true; // Success
    }
    return false; // Failure
  }

  static bool updateBill(Bill oldBill, String description, String category, double amount, DateTime dueDate) {
    int index = bills.indexOf(oldBill);
    if (index != -1) {
      bills[index] = Bill(
        description: description,
        category: category,
        amount: amount,
        dueDate: dueDate,
        status: oldBill.status, // Keep the existing status
        uploadedFile: oldBill.uploadedFile, // Preserve uploaded file
      );
      return true; // Success
    }
    return false; // Failure
  }

  // Additional search/filter method
  static List<Bill> searchBills(String query) {
    return bills.where((bill) => bill.description.toLowerCase().contains(query.toLowerCase())).toList();
  }
}
