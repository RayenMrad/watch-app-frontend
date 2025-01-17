import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';

abstract class SalesRepository {
  Future<Either<Failure, Unit>> createSales(
      {required String userId, required String variantId});

  Future<Either<Failure, List<Sales>>> getAllSales({required String userId});

  Future<Either<Failure, Sales>> getSalesById({required String salesId});
  Future<Either<Failure, Unit>> updateSales(Sales sale);
  Future<Either<Failure, Unit>> deleteSales({required String salesId});
}
