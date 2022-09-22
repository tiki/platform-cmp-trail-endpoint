/*
 * Copyright (c) TIKI Inc.
 * MIT license. See LICENSE file in root directory.
 */
/// {@category Node}
library keys;

import 'dart:convert';
import 'dart:typed_data';

import 'package:pointycastle/export.dart';

import '../../utils/rsa/rsa.dart';
import 'key_interface.dart';
import 'key_model.dart';
import 'key_repository.dart';

export 'key_interface.dart';
export 'key_model.dart';
export 'key_repository.dart';

/// The service that handles keys creation and persistance.
class KeyService {
  final KeyRepository _repository;

  KeyService(KeyInterface keysInterface)
      : _repository = KeyRepository(keysInterface);

  /// Create a new [RsaKeyPair] and save its public key in object storage.
  Future<KeyModel> create() async {
    RsaKeyPair rsaKeyPair = await UtilsRsa.generateAsync();
    Uint8List address = Digest("SHA3-256")
        .process(base64.decode(rsaKeyPair.publicKey.encode()));
    KeyModel keys = KeyModel(
      address,
      rsaKeyPair.privateKey,
    );
    _repository.save(keys);
    return keys;
  }

  /// Gets a persisted [KeyModel].
  Future<KeyModel?> get(String address) => _repository.get(address);
}