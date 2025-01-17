import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class GetAllSalesUsecase {
  final SalesRepository _salesRepository;

  const GetAllSalesUsecase(this._salesRepository);

  Future<Either<Failure, List<Sales>>> call({required String userId}) async =>
      _salesRepository.getAllSales(userId: userId);
}
