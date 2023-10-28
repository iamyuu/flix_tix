abstract class UseCase<Result, ParamsOrBody> {
  Future<Result> call(ParamsOrBody paramsOrBody);
}
