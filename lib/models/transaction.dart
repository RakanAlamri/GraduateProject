class Transaction {
  final String id;
  final String ProductDescription;
  final String ProductName;
  final double ProductPrice;
  final String owner;
  final int date;
  final int ExpiredDate;

  Transaction(
      {required this.id,
      required this.ProductName,
      required this.ProductDescription,
      required this.ProductPrice,
      required this.date,
      required this.owner,
      required this.ExpiredDate});
}
