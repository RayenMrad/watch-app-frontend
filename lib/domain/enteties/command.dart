import 'package:clean_arch/domain/enteties/sales.dart';

class Command {
  final String id;
  final String adresse;
  final String reference;
  final double commandTotalPrice;
  final DateTime commandDate;
  final String commandStatus;
  final String userId;
  final List<Sales> sales;

  const Command(
      {required this.id,
      required this.adresse,
      required this.reference,
      required this.commandTotalPrice,
      required this.commandDate,
      required this.commandStatus,
      required this.userId,
      required this.sales});
}
