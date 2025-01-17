import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/sales_repository.dart';
import 'package:dartz/dartz.dart';

class GetSalesByIdUsecase {
  final SalesRepository _salesRepository;

  const GetSalesByIdUsecase(this._salesRepository);

  Future<Either<Failure, Sales>> call({required String salesId}) async =>
      await _salesRepository.getSalesById(salesId: salesId);
}
