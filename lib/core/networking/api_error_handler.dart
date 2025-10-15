import 'dart:io';
import 'package:dio/dio.dart';

import 'api_error_model.dart';

/// HTTP Status Codes
class HttpStatus {
  static const int ok = 200;
  static const int created = 201;
  static const int noContent = 204;
  static const int badRequest = 400;
  static const int unauthorized = 401;
  static const int forbidden = 403;
  static const int notFound = 404;
  static const int unprocessableEntity = 422;
  static const int internalServerError = 500;

  // Local error codes
  static const int connectTimeout = -1;
  static const int cancel = -2;
  static const int receiveTimeout = -3;
  static const int sendTimeout = -4;
  static const int cacheError = -5;
  static const int noInternetConnection = -6;
  static const int unknown = -7;
}

/// Data Source Types for Error Handling
enum ErrorType {
  noContent,
  badRequest,
  unauthorized,
  forbidden,
  notFound,
  unprocessableEntity,
  internalServerError,
  connectTimeout,
  cancel,
  receiveTimeout,
  sendTimeout,
  cacheError,
  noInternetConnection,
  unknown,
}

/// Extension to convert ErrorType to ApiErrorModel
extension ErrorTypeExtension on ErrorType {
  ApiErrorModel toFailure() {
    switch (this) {
      case ErrorType.noContent:
        return ApiErrorModel(
          code: HttpStatus.noContent,
          message: 'No content available',
        );
      case ErrorType.badRequest:
        return ApiErrorModel(
          code: HttpStatus.badRequest,
          message: 'Bad request. Please check your input.',
        );
      case ErrorType.unauthorized:
        return ApiErrorModel(
          code: HttpStatus.unauthorized,
          message: 'Unauthorized. Please login again.',
        );
      case ErrorType.forbidden:
        return ApiErrorModel(
          code: HttpStatus.forbidden,
          message: 'Access forbidden.',
        );
      case ErrorType.notFound:
        return ApiErrorModel(
          code: HttpStatus.notFound,
          message: 'Resource not found.',
        );
      case ErrorType.unprocessableEntity:
        return ApiErrorModel(
          code: HttpStatus.unprocessableEntity,
          message: 'Validation error. Please check your input.',
        );
      case ErrorType.internalServerError:
        return ApiErrorModel(
          code: HttpStatus.internalServerError,
          message: 'Internal server error. Please try again later.',
        );
      case ErrorType.connectTimeout:
        return ApiErrorModel(
          code: HttpStatus.connectTimeout,
          message: 'Connection timeout. Please check your internet connection.',
        );
      case ErrorType.cancel:
        return ApiErrorModel(
          code: HttpStatus.cancel,
          message: 'Request cancelled.',
        );
      case ErrorType.receiveTimeout:
        return ApiErrorModel(
          code: HttpStatus.receiveTimeout,
          message: 'Receive timeout. Please try again.',
        );
      case ErrorType.sendTimeout:
        return ApiErrorModel(
          code: HttpStatus.sendTimeout,
          message: 'Send timeout. Please try again.',
        );
      case ErrorType.cacheError:
        return ApiErrorModel(
          code: HttpStatus.cacheError,
          message: 'Cache error occurred.',
        );
      case ErrorType.noInternetConnection:
        return ApiErrorModel(
          code: HttpStatus.noInternetConnection,
          message: 'No internet connection. Please check your network.',
        );
      case ErrorType.unknown:
        return ApiErrorModel(
          code: HttpStatus.unknown,
          message: 'Something went wrong. Please try again.',
        );
    }
  }
}

/// Main Error Handler Class
class ApiErrorHandler implements Exception {
  late final ApiErrorModel errorModel;

  ApiErrorHandler.handle(dynamic error) {
    errorModel = _mapErrorToModel(error);
  }

  /// Maps any error to ApiErrorModel
  ApiErrorModel _mapErrorToModel(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else {
      return ErrorType.unknown.toFailure();
    }
  }

  /// Handles DioException specifically
  ApiErrorModel _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
        return ErrorType.connectTimeout.toFailure();

      case DioExceptionType.sendTimeout:
        return ErrorType.sendTimeout.toFailure();

      case DioExceptionType.receiveTimeout:
        return ErrorType.receiveTimeout.toFailure();

      case DioExceptionType.badResponse:
        return _handleBadResponse(error);

      case DioExceptionType.cancel:
        return ErrorType.cancel.toFailure();

      case DioExceptionType.connectionError:
        return _handleConnectionError(error);

      case DioExceptionType.badCertificate:
        return ApiErrorModel(
          code: HttpStatus.unknown,
          message: 'SSL certificate error.',
        );

      case DioExceptionType.unknown:
        return _handleUnknownError(error);

      }
  }

  /// Handles bad HTTP responses (4xx, 5xx)
  ApiErrorModel _handleBadResponse(DioException error) {
    final response = error.response;
    
    if (response == null) {
      return ErrorType.unknown.toFailure();
    }

    // Try to parse error from backend
    if (response.data != null && response.data is Map<String, dynamic>) {
      try {
        return ApiErrorModel.fromJson(response.data);
      } catch (e) {
        // If parsing fails, fall back to status code handling
      }
    }

    // Handle by status code
    return _mapStatusCodeToError(response.statusCode);
  }

  /// Maps HTTP status code to appropriate error
  ApiErrorModel _mapStatusCodeToError(int? statusCode) {
    switch (statusCode) {
      case HttpStatus.badRequest:
        return ErrorType.badRequest.toFailure();
      case HttpStatus.unauthorized:
        return ErrorType.unauthorized.toFailure();
      case HttpStatus.forbidden:
        return ErrorType.forbidden.toFailure();
      case HttpStatus.notFound:
        return ErrorType.notFound.toFailure();
      case HttpStatus.unprocessableEntity:
        return ErrorType.unprocessableEntity.toFailure();
      case HttpStatus.internalServerError:
        return ErrorType.internalServerError.toFailure();
      default:
        return ErrorType.unknown.toFailure();
    }
  }

  /// Handles connection errors (no internet, etc.)
  ApiErrorModel _handleConnectionError(DioException error) {
    if (error.error is SocketException) {
      return ErrorType.noInternetConnection.toFailure();
    }
    return ErrorType.unknown.toFailure();
  }

  /// Handles unknown DioException errors
  ApiErrorModel _handleUnknownError(DioException error) {
    if (error.error is SocketException) {
      return ErrorType.noInternetConnection.toFailure();
    }
    
    final response = error.response;
    if (response != null && response.data != null) {
      try {
        return ApiErrorModel.fromJson(response.data);
      } catch (e) {
        return ErrorType.unknown.toFailure();
      }
    }
    
    return ErrorType.unknown.toFailure();
  }

  @override
  String toString() => errorModel.message ?? 'Unknown error occurred';
}