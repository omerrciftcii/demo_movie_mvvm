abstract class Failure {
  List<Object> get props => [];
}

// General failures
class ServerFailure implements Failure {
  final String errorMessage;
  ServerFailure({required this.errorMessage});

  @override
  // TODO: implement props
  List<Object> get props => throw UnimplementedError();
}
