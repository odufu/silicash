import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'network_exceptions.freezed.dart';

@freezed
class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;
  const factory NetworkExceptions.unauthorizedRequest() = UnauthorizedRequest;
  const factory NetworkExceptions.badRequest() = BadRequest;
  const factory NetworkExceptions.notFound(String reason) = NotFound;
  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;
  const factory NetworkExceptions.notAcceptable() = NotAcceptable;
  const factory NetworkExceptions.requestTimeout() = RequestTimeout;
  const factory NetworkExceptions.sendTimeout() = SendTimeout;
  const factory NetworkExceptions.conflict() = Conflict;
  const factory NetworkExceptions.internalServerError() = InternalServerError;
  const factory NetworkExceptions.notImplemented() = NotImplemented;
  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;
  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;
  const factory NetworkExceptions.formatException() = FormatException;
  const factory NetworkExceptions.unableToProcess() = UnableToProcess;
  const factory NetworkExceptions.defaultError(String error) = DefaultError;
  const factory NetworkExceptions.unexpectedError(String error) = UnexpectedError;

  static NetworkExceptions fromDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.cancel:
        return const NetworkExceptions.requestCancelled();
      case DioExceptionType.connectionTimeout:
        return const NetworkExceptions.requestTimeout();
      case DioExceptionType.receiveTimeout:
        return const NetworkExceptions.sendTimeout();
      case DioExceptionType.sendTimeout:
        return const NetworkExceptions.sendTimeout();
      case DioExceptionType.badResponse:
        switch (error.response?.statusCode) {
          case 400:
            return const NetworkExceptions.badRequest();
          case 401:
            return const NetworkExceptions.unauthorizedRequest();
          case 404:
            return const NetworkExceptions.notFound("Not found");
          case 409:
            return const NetworkExceptions.conflict();
          case 408:
            return const NetworkExceptions.requestTimeout();
          case 500:
            return const NetworkExceptions.internalServerError();
          case 503:
            return const NetworkExceptions.serviceUnavailable();
          default:
            return NetworkExceptions.defaultError(
              error.response?.statusMessage ?? "Something went wrong",
            );
        }
      case DioExceptionType.unknown:
        if (error.message?.contains("SocketException") ?? false) {
          return const NetworkExceptions.noInternetConnection();
        }
        return const NetworkExceptions.unexpectedError("Unexpected error occurred");
      default:
        return const NetworkExceptions.unexpectedError("Unexpected error occurred");
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(
      requestCancelled: () {
        errorMessage = "Request was cancelled";
      },
      unauthorizedRequest: () {
        errorMessage = "Unauthorized request";
      },
      badRequest: () {
        errorMessage = "Bad request";
      },
      notFound: (String reason) {
        errorMessage = reason;
      },
      methodNotAllowed: () {
        errorMessage = "Method not allowed";
      },
      notAcceptable: () {
        errorMessage = "Not acceptable";
      },
      requestTimeout: () {
        errorMessage = "Request timeout";
      },
      sendTimeout: () {
        errorMessage = "Send timeout";
      },
      conflict: () {
        errorMessage = "Error due to a conflict";
      },
      internalServerError: () {
        errorMessage = "Internal server error";
      },
      notImplemented: () {
        errorMessage = "Not implemented";
      },
      serviceUnavailable: () {
        errorMessage = "Service unavailable";
      },
      noInternetConnection: () {
        errorMessage = "No internet connection";
      },
      formatException: () {
        errorMessage = "Format exception";
      },
      unableToProcess: () {
        errorMessage = "Unable to process the data";
      },
      defaultError: (String error) {
        errorMessage = error;
      },
      unexpectedError: (String error) {
        errorMessage = error;
      },
    );
    return errorMessage;
  }
}
