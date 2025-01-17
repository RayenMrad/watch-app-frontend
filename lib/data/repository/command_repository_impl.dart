import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_command_data_source.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:clean_arch/domain/repository/command_reposetory.dart';
import 'package:dartz/dartz.dart';

class CommandRepositoryImpl implements CommandRepository {
  final CommandRemoteDataSource commandRemoteDataSource;

  CommandRepositoryImpl({required this.commandRemoteDataSource});

  @override
  Future<Either<Failure, Unit>> cancelCommand(
      {required String commandId}) async {
    try {
      await commandRemoteDataSource.cancelCommand(commandId);
      return const Right(unit);
    } on ServerException catch (_) {
      return Left(ServerFailure());
    } on ProductNotFoundException catch (_) {
      return Left(ProductNotFoundFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> createCommand(
      {required String userId, required List<Sales> sales}) async {
    try {
      await commandRemoteDataSource.createCommand(userId, sales);
      return Right(unit);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, Command>> getCommandById(
      {required String commandId}) async {
    try {
      final res = await commandRemoteDataSource.getCommandById(commandId);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on ProductNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }
}
