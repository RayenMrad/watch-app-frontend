// import 'package:clean_arch/core/error/exceptions/exceptions.dart';
// import 'package:clean_arch/core/error/failures/failures.dart';
// import 'package:clean_arch/data/data_source/remote_data_source/remote_sales_data_source.dart';
// import 'package:clean_arch/data/models/sales_model.dart';
// import 'package:clean_arch/domain/enteties/sales.dart';
// import 'package:clean_arch/domain/repository/sales_repository.dart';
// import 'package:dartz/dartz.dart';

// class SalesRepositoryImpl implements SalesRepository {
//   final SalesRemoteDataSource salesRemoteDataSource;

//   SalesRepositoryImpl({required this.salesRemoteDataSource});

//   @override
//   Future<Either<Failure, Unit>> createSales(
//       {required String userId, required String variantId}) async {
//     try {
//       final SalesModel sale = SalesModel(
//           id: id,
//           quantity: quantity,
//           totalprice: totalprice,
//           userId: userId,
//           variantId: variantId);
//       final res = await salesRemoteDataSource.createSales(sale);
//       return Right(res);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> deleteSales({required String salesId}) async {
//     try {
//       await salesRemoteDataSource.deleteSales(salesId);
//       return right(unit);
//     } on ServerException {
//       return left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, List<Sales>>> getAllSales(
//       {required String userId}) async {
//     try {
//       final salesModels = await salesRemoteDataSource.getAllSales(userId);
//       return right(salesModels);
//     } on ServerException {
//       return left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Sales>> getSalesById({required String salesId}) async {
//     try {
//       final salesModels = await salesRemoteDataSource.getSalesById(salesId);
//       return right(salesModels);
//     } on ServerException {
//       return left(ServerFailure());
//     }
//   }

//   @override
//   Future<Either<Failure, Unit>> updateSales(Sales sale) async {
//     try {
//       SalesModel salesModel = SalesModel(
//           id: sale.id,
//           quantity: sale.quantity,
//           totalprice: sale.totalprice,
//           userId: sale.userId,
//           variantId: sale.variantId);
//       await salesRemoteDataSource.updateSales(salesModel);
//       return const Right(unit);
//     } on ServerException {
//       return Left(ServerFailure());
//     }
//   }
// }
