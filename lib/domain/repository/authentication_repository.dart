import 'dart:io';

import 'package:clean_arch/core/error/failures/failures.dart';
import 'package:clean_arch/domain/enteties/token.dart';
import 'package:clean_arch/domain/enteties/user.dart';
import 'package:dartz/dartz.dart';

abstract class AuthenticationRepository {
  Future<Either<Failure, String>> createAccount(
      {required String firstName,
      required String lastName,
      required String image,
      required String email,
      required String adresse,
      required String phone,
      required String gender,
      required DateTime birthDate,
      required String password});

  Future<Either<Failure, Token>> login(
      {required String email, required String password});

  Future<Either<Failure, Unit>> updateUser({
    required String id,
    required String firstName,
    required String lastName,
    required String email,
    required String adresse,
    required String phone,
    required String gender,
    required DateTime birthDate,
  });

  Future<Either<Failure, Unit>> updatePassword({
    required String userId,
    required String oldPassword,
    required String newPassword,
  });

  Future<Either<Failure, Unit>> updateImage({
    required String userId,
    required File image,
  });

  Future<Either<Failure, User>> getUserById({required String userId});

  Future<Either<Failure, Token>> autologin();
  Future<Either<Failure, Unit>> logout();
}
