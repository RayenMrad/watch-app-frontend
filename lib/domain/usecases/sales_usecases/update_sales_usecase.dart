import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class UpdateSalesUsecase {
  final SalesRepository _salesRepository;

  const UpdateSalesUsecase(this._salesRepository);

  Future<Either<Failure, Unit>> call(Sales sale) async =>
      await _salesRepository.updateSales(sale);
}
