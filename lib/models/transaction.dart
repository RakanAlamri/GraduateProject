class Transaction {
  final String id;
  final String ProductDescription;
  final String ProductName;
  final double ProductPrice;

  final DateTime date;

  Transaction({
    required this.id,
    required this.ProductName,
    required this.ProductDescription,
    required this.ProductPrice,
    required this.date,
  });
}
