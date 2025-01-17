// import 'package:clean_arch/core/error/exceptions/exceptions.dart';
// import 'package:clean_arch/core/error/failures/failures.dart';
// import 'package:clean_arch/data/data_source/remote_data_source/remote_wishlist_data_source.dart';
// import 'package:clean_arch/data/models/wishlist_model.dart';
// import 'package:clean_arch/domain/enteties/watch.dart';
// import 'package:clean_arch/domain/enteties/wishlist.dart';
// import 'package:clean_arch/domain/repository/wishlist_repository.dart';
// import 'package:dartz/dartz.dart';

// class WishlistReporitoryImpl implements WishlistRepository {
//   final WishlistRemoteDataSource wishlistRemoteDataSource;

//   WishlistReporitoryImpl({required this.wishlistRemoteDataSource});

//   @override
//   Future<Either<Failure, Unit>> createWishList(
//       {required String userId, required List<Watch> watchs}) async {
//     try {
//       final res = await wishlistRemoteDataSource.createWishList(userId, watchs);
//       return Right(res);
//     } on RegistrationException catch (e) {
//       return Left(RegistrationFailure(e.message));
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> deleteWishlist(
//       {required String wishlistId}) async {
//     try {
//       await wishlistRemoteDataSource.deleteWishlist(wishlistId);
//       return right(unit);
//     } on ServerException catch (e) {
//       return left(ServerFailure(message: e.message));
//     }
//   }

//   @override
//   Future<Either<Failure, Wishlist>> getWishList(
//       {required String wishlistId}) async {
//     try {
//       final res = await wishlistRemoteDataSource.getWishList(wishlistId);
//       return right(res);
//     } on ServerException catch (_) {
//       return left(ServerFailure());
//     } on ProductNotFoundException catch (_) {
//       return left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateWishlist({
//     required String wishlistId,
//     required String userId,
//     required List<Watch> watchs,
//   }) async {
//     try {
//       final wModel = WishlistModel(
//         id: wishlistId,
//         userId: userId,
//         watchs: watchs,
//       );
//       await wishlistRemoteDataSource.updateWishlist(wishlist: wModel);
//       return const Right(unit);
//     } on ServerException catch (e) {
//       return Left(ServerFailure(message: e.message));
//     }
//   }
// }
