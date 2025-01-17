import 'package:clean_arch/domain/enteties/watch.dart';

class Wishlist {
  final String id;
  final String userId;
  final List<Watch> watchs;

  Wishlist({required this.id, required this.userId, required this.watchs});
}
