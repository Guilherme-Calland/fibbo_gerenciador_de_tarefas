import 'package:dartz/dartz.dart';

abstract class Usecase<Result, Params> {
  Future<Either<Exception, Result>> call(Params params);
}

class NoParams{}

