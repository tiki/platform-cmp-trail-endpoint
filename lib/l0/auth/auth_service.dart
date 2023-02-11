/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// Client APIs for TIKI's authorization service:
/// [L0 Auth](https://github.com/tiki/l0-auth).
/// {@category L0 Services}
library l0_auth;

import 'auth_repository.dart';

export 'auth_model_jwt.dart';
export 'auth_repository.dart';

/// The primary class for interaction with the L0 Auth Service.
///
/// Use to get authorization [tokens] from the service.
/// Requires a [_publishingId].
class AuthService {
  final String _publishingId;
  final AuthRepository _repository;

  /// Get a free [_publishingId] at
  /// [console.mytiki.com](https://console.mytiki.com)
  AuthService(this._publishingId) : _repository = AuthRepository();

  /// Request a new authorization token
  ///
  /// Throws [HttpException] for invalid [_publishingId]s
  Future<String?> get token async =>
      (await _repository.grant(_publishingId)).accessToken;
}