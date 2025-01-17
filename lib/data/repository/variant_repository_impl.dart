import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_variant_data_source.dart';
import 'package:clean_arch/domain/enteties/variant.dart';
import 'package:clean_arch/domain/repository/variant_repository.dart';
import 'package:dartz/dartz.dart';

class VariantRepositoryImpl implements VariantRepository {
  final VariantRemoteDataSource variantRemoteDataSource;

  VariantRepositoryImpl({required this.variantRemoteDataSource});

  @override
  Future<Either<Failure, List<Variant>>> getAllVariant() async {
    try {
      final res = await variantRemoteDataSource.getAllVariant();
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on ProductNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }
}
