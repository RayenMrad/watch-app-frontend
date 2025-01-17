import 'package:clean_arch/domain/enteties/sales.dart';

class Cart {
  final String id;
  final String userId;
  List<Sales> sales;

  Cart({required this.id, required this.userId, required this.sales});
}
