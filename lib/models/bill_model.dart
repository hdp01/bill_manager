class Bill {
  final String description;  // Description of the bill
  final String category;     // Category of the bill (e.g., Utilities, Rent)
  final double amount;       // Amount of the bill
  final DateTime dueDate;    // Due date for the bill
  final String status;       // Status of the bill (e.g., Paid, Unpaid)
  final dynamic uploadedFile; // Can hold file or image temporarily

  Bill({
    required this.description,
    required this.category,
    required this.amount,
    required this.dueDate,
    required this.status,
    this.uploadedFile,
  });
}
