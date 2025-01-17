import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_watch_data_source.dart';
import 'package:clean_arch/domain/enteties/watch.dart';
import 'package:clean_arch/domain/repository/watch_repository.dart';
import 'package:dartz/dartz.dart';

class WatchRepositoryImpl implements WatchRepository {
  final WatchRemoteDataSource watchRemoteDataSource;

  WatchRepositoryImpl({required this.watchRemoteDataSource});

  @override
  Future<Either<Failure, List<Watch>>> getAllWatchs() async {
    try {
      final res = await watchRemoteDataSource.getAllWatchs();
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on WatchNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<Watch>>> getWatchsByCategory(
      {required String category}) async {
    try {
      final res = await watchRemoteDataSource.getWatchsByCat(category);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on WatchNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Watch>> getWatchById({required String watchId}) async {
    try {
      final res = await watchRemoteDataSource.getWatch(watchId);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on WatchNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }
}
