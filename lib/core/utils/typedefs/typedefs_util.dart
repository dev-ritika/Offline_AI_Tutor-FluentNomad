import 'dart:core';

import 'package:dartz/dartz.dart';
import 'package:offline_ai_tutor/core/error_handling/failures.dart';

typedef Result<T> = Either<Failures, T>;
typedef ResultFuture<T> = Future<Either<Failures, T>>;
typedef ResultStream<T> = Stream<Either<Failures, T>>;
typedef DataMap = Map<String, dynamic>;
