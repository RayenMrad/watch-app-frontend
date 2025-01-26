class Sales {
  final String id;
  int quantity;
  double totalprice;
  final String userId;
  final String variantId;

  Sales(
      {required this.id,
      required this.quantity,
      required this.totalprice,
      required this.userId,
      required this.variantId});
}
