import 'package:clean_arch/data/models/watch_model.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';

class WishlistModel extends Wishlist {
  WishlistModel(
      {required super.id, required super.userId, required super.watchs});

  factory WishlistModel.fromJson(Map<String, dynamic> json) => WishlistModel(
      id: json['id'],
      userId: json['userId'],
      watchs: ((json['watchs']) as List)
          .map((e) => WatchModel.fromJson(e))
          .toList());
}
