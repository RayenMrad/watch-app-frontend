class Sales {
  final String id;
  final int quantity;
  final double totalprice;
  final String userId;
  final String variantId;

  const Sales(
      {required this.id,
      required this.quantity,
      required this.totalprice,
      required this.userId,
      required this.variantId});
}
