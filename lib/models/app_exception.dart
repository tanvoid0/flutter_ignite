import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_ignite/flutter_ignite.dart';
import 'package:flutter_ignite/utils/mixins.dart';
import 'package:process_run/shell.dart';

class AppException implements Exception {
  final String name;
  final String message;
  final String description;
  final Map<String, dynamic> data;
  final StackTrace? stackTrace;

  AppException({
    this.name = "AppException",
    required this.message,
    this.description = "",
    this.data = const {},
    this.stackTrace,
  });

  factory AppException.fromObject(final Object error) {
    if (error is AppException) {
      return error;
    } else if (error is ShellException) {
      return AppException.fromShellException(error);
    } else if (error is DioException) {
      return AppException.fromDioException(error);
    } else {
      return AppException(
        name: "Unknown Exception",
        message: "An unknown issue occurred during the last process",
        description: error.toString(),
      );
    }
  }

  factory AppException.fromDioException(final DioException error) {
    return AppException(
      name: "Network Exception occurred",
      message: AppException.decodeDioExceptionMessage(error),
      description:
          "URL: ${error.requestOptions.uri}\nRequest Body: ${error.requestOptions.data}\nHeader: ${error.requestOptions.headers}\nMessage: ${error.message}\nError: ${error.error}\nStatus Message: ${error.response?.statusMessage}\nStatus Code: ${error.response?.statusCode}\nStackTrace: ${error.stackTrace}",
    );
  }

  factory AppException.fromShellException(final ShellException error) {
    return AppException(
      name: "ShellException",
      message: "Shell Run failed: ${error.message}",
      description: error.result!.toFormattedString(),
    );
  }

  factory AppException.fromFormatException(final FileType type) {
    return AppException(
        name: "Formatter Exception",
        message: "Invalid Format type '$type'",
        description: "Cannot parse String to '$type'");
  }

  @override
  String toString() {
    return "name=$name, message='$message', description='$description', data=$data\nstackTrace:\n$stackTrace";
  }

  static void globalExceptionHandler(
      final Object error, final StackTrace stackTrace) {
    Pen.error("App caught a global exception");
    Pen.error("$error");
    Pen.error("$stackTrace");
    final AppException ex = AppException.fromObject(error);
    Toast.error(
        title: "${ex.name} occurred",
        message: ex.message,
        description: ex.description);
  }

  static Future<T?> isolatedRun<T>(FutureOr<T> Function() func) async {
    try {
      return await func();
    } on AppException catch (ex) {
      Pen.error(ex.message);
      return null;
    } catch (ex) {
      rethrow;
    }
  }

  static String decodeStatusCode(int statusCode, {String? defaultMessage}) {
    final messages = {
      // Common HTTP status codes
      200: "[OK] - The request was successful.",
      201: "[Created] - A new resource was created.",
      204: "[No Content] - The server has no content to send.",
      301:
          "[Moved Permanently] - The requested resource has been permanently moved to a new location.",
      302:
          "[Found] - The requested resource has been temporarily moved to a new location.",
      400: "[Bad Request] - The request is invalid.",
      401: "[Unauthorized] - The request requires user authentication.",
      403: "[Forbidden] - The server has denied the request.",
      404: "[Not Found] - The requested resource could not be found.",
      405:
          "[Method Not Allowed] - The request method is not supported for this resource.",
      409: "[Conflict] - The request could not be completed due to a conflict.",
      500:
          "[Internal Server Error] - An unexpected error occurred on the server.",
      502:
          "[Bad Gateway] - The server received an invalid response from an upstream server.",
      503: "[Service Unavailable] - The server is currently unavailable.",
    };

    // Check for defined message in the map
    final message = messages[statusCode];

    // Return the mapped message or default message if not found
    return message ?? defaultMessage ?? "Unknown Status Code";
  }

  static String decodeDioExceptionMessage(final DioException err) {
    switch (err.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return "Connection timeout error";
      case DioExceptionType.connectionError:
        return "Connection error";
      case DioExceptionType.badCertificate:
        return "Bad Certification";
      case DioExceptionType.cancel:
        return "Request Cancelled";
      case DioExceptionType.badResponse:
        if (err.response!.statusCode != null) {
          return "Request failed with Status ${decodeStatusCode(err.response!.statusCode!)}";
        }
      case DioExceptionType.unknown:
        return "Unknown Network Error occurred";
    }
    return "No relative issue description found";
  }
}

class DioErrorHandler extends InterceptorsWrapper {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    super.onRequest(options, handler);
    Pen.write(
        "Dio Request:\n\turl: ${options.baseUrl}\n\tdata: ${options.data}\n");
    return handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    super.onResponse(response, handler);
    Pen.success("data: ${response.data}");
    return handler.next(response);
  }

  @override
  void onError(final DioException err, final ErrorInterceptorHandler handler) {
    super.onError(err, handler);
    // throw _handleError(err);
    return handler.next(err);
  }

  // AppException _handleError(final DioException err) {
  //   String message = AppException.decodeDioExceptionMessage(err);
  //
  //   final appExp = AppException(
  //       name: "Network Exception",
  //       message: message,
  //       description:
  //           "Status Code: ${err.response!.statusCode}\nmessage: ${err.response!.statusMessage}");
  //   Pen.error("DIO Error handler: $appExp");
  //   return appExp;
  // }
}
