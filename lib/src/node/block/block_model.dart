import '../xchain/xchain_model.dart';

class BlockModel {

  int? id;
  int version;
  String previousHash;
  XchainModel xchain;
  String transactionRoot;
  int transactionCount;
  DateTime timestamp;

  BlockModel({
    this.id,
    this.version = 1,
    required this.previousHash,
    required this.xchain,
    required this.transactionRoot,
    required this.transactionCount,
    required this.timestamp,
  });

  BlockModel.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        version = map['version'],
        previousHash = map['previous_hash'],
        xchain = map['xchain'],
        transactionRoot = map['transaction_root'],
        transactionCount = map['transaction_count'],
        timestamp =
            DateTime.fromMillisecondsSinceEpoch(map['timestamp'] ~/ 1000);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'version': version,
      'previous_hash': previousHash,
      'xchain': xchain.toMap(),
      'transaction_root': transactionRoot,
      'transaction_count': transactionCount,
      'timestamp': timestamp.millisecondsSinceEpoch
    };
  }

  String toSqlValues() {
    return '''$id, $version, '$previousHash', ${xchain.id},
      '$transactionRoot', $transactionCount, ${timestamp.millisecondsSinceEpoch ~/ 1000}''';
  }

  @override
  String toString() {
    return '''BlockModel
      'id': $id,
      'version': $version,
      'previousHash': $previousHash,
      'xchain': ${xchain.toString()},
      'transactionRoot': $transactionRoot,
      'transactionCount': $transactionCount,
      'timestamp': $timestamp
    ''';
  }
}