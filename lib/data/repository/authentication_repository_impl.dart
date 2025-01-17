import 'dart:io';

import 'package:clean_arch/core/error/exceptions/exceptions.dart';
import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/data/data_source/local_data_source/authentication_local_data_source.dart';
import 'package:clean_arch/data/data_source/remote_data_source/remote_authentication_data_source.dart';
import 'package:clean_arch/data/models/token_model.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:clean_arch/domain/repository/authentication_repository.dart';
import 'package:dartz/dartz.dart';

class AuthenticationRepositoryImpl implements AuthenticationRepository {
  final AuthenticationRemoteDataSource authenticationRemoteDataSource;
  final AuthenticationLocalDataSource authenticationLocalDataSource;

  AuthenticationRepositoryImpl(
    this.authenticationLocalDataSource,
    this.authenticationRemoteDataSource,
  );

  @override
  Future<Either<Failure, Unit>> createAccount(
      {required String firstName,
      required String lastName,
      required String image,
      required String email,
      required String adresse,
      required String phone,
      required String gender,
      required DateTime birthDate,
      required String password}) async {
    try {
      await authenticationRemoteDataSource.createAccount(firstName, lastName,
          image, email, adresse, phone, gender, birthDate, password);
      return Right(unit);
    } on RegistrationException catch (e) {
      return Left(RegistrationFailure(e.message));
    }
  }

  @override
  Future<Either<Failure, User>> getUserById({required String userId}) async {
    try {
      final res = await authenticationRemoteDataSource.getOneUser(userId);
      return right(res);
    } on ServerException catch (_) {
      return left(ServerFailure());
    } on UserNotFoundException catch (_) {
      return left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Token>> login(
      {required String email, required String password}) async {
    try {
      TokenModel tm =
          await authenticationRemoteDataSource.login(email, password);
      await authenticationLocalDataSource.saveUserInformations(tm);
      Token t = Token(
          token: tm.token,
          refreshToken: tm.refreshToken,
          expiryDate: tm.expiryDate,
          userId: tm.userId);

      return right(t);
    } on LoginException catch (e) {
      return left(LoginFailure(e.message));
    } on LocalStorageException {
      return left(LocalStorageFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updateImage(
      {required String userId, required File image}) async {
    try {
      await authenticationRemoteDataSource.updateImage(userId, image);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, Unit>> updatePassword(
      {required String userId,
      required String oldPassword,
      required String newPassword}) async {
    try {
      await authenticationRemoteDataSource.updatePassword(
          userId, oldPassword, newPassword);
      return const Right(unit);
    } on DataNotFoundException catch (e) {
      return Left(DataNotFoundFailure(e.message));
    } on ServerException catch (e) {
      return Left(ServerFailure(message: e.message));
    }
  }

  @override
  Future<Either<Failure, Unit>> updateUser(
      {required String id,
      required String firstName,
      required String lastName,
      required String email,
      required String adresse,
      required String phone,
      required String gender,
      required DateTime birthDate}) async {
    try {
      await authenticationRemoteDataSource.updateUser(
          id, firstName, lastName, email, adresse, phone, gender, birthDate);
      return const Right(unit);
    } on ServerException {
      return Left(ServerFailure());
    }
  }
}
