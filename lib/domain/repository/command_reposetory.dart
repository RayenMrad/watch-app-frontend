import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/command.dart';
import 'package:clean_arch/domain/enteties/sales.dart';
import 'package:dartz/dartz.dart';

abstract class CommandRepository {
  Future<Either<Failure, Unit>> createCommand(
      {required String userId, required List<Sales> sales});

  Future<Either<Failure, Command>> getCommandById({required String commandId});

  Future<Either<Failure, Unit>> cancelCommand({required String commandId});
}
