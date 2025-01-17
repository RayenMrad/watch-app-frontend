import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/wishlist.dart';
import 'package:clean_arch/domain/repository/wishlist_repository.dart';
import 'package:dartz/dartz.dart';

class GetWishlistUsecase {
  final WishlistRepository _repository;

  const GetWishlistUsecase(this._repository);

  Future<Either<Failure, Wishlist>> call({required String wishlistId}) async =>
      await _repository.getWishList(wishlistId: wishlistId);
}
