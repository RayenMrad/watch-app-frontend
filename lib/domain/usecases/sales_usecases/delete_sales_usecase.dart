import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class DeleteSalesUsecase {
  final SalesRepository _salesRepository;

  const DeleteSalesUsecase(this._salesRepository);

  Future<Either<Failure, Unit>> call({required String salesId}) async =>
      await _salesRepository.deleteSales(salesId: salesId);
}
