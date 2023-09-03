import 'package:dartz/dartz.dart';

import '../errors/failuer.dart';

abstract class UseCase<Type, Parameter> {
  Future<Either<Failuer, Type>> call([Parameter parameter]);
}
