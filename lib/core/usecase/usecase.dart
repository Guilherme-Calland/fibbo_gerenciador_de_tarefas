import 'package:dartz/dartz.dart';

abstract class Usecase<T, Params> {
  Future<Either<Exception, T>> call(Params params);
}

