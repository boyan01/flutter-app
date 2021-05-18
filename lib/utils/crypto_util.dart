import 'dart:math';
import 'dart:typed_data';

import 'package:pointycastle/api.dart';
import 'package:pointycastle/block/aes_fast.dart';
import 'package:pointycastle/block/modes/cbc.dart';
import 'package:pointycastle/block/modes/gcm.dart';
import 'package:pointycastle/padded_block_cipher/padded_block_cipher_impl.dart';
import 'package:pointycastle/paddings/pkcs7.dart';
import 'package:x25519/x25519.dart' as x25519;

List<int> aesGcmEncrypt(List<int> key, List<int> plainText) {
  final iv = generateRandomKey(12);
  final params = ParametersWithIV<KeyParameter>(
      KeyParameter(Uint8List.fromList(key)), Uint8List.fromList(iv));
  final gcmCipher = GCMBlockCipher(AESFastEngine())..init(true, params);
  final encrypted = gcmCipher.process(Uint8List.fromList(plainText));
  final result = [...iv, ...encrypted];
  return result;
}

Uint8List aesGcmDecrypt(List<int> key, List<int> iv, List<int> cipherText) {
  final params = ParametersWithIV<KeyParameter>(
      KeyParameter(Uint8List.fromList(key)), Uint8List.fromList(iv));
  final gcmCipher = GCMBlockCipher(AESFastEngine())..init(false, params);
  return gcmCipher.process(Uint8List.fromList(cipherText));
}

List<int> aesEncrypt(List<int> key, List<int> plainText, [List<int>? iv]) {
  final cbcCipher = CBCBlockCipher(AESFastEngine());
  final nonce = iv ?? generateRandomKey(16);
  final ivParams = ParametersWithIV<KeyParameter>(
      KeyParameter(Uint8List.fromList(key)), Uint8List.fromList(nonce));
  final paddingParams =
      // ignore: prefer_void_to_null
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
          ivParams, null);

  final paddedCipher = PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher)
    ..init(true, paddingParams);

  final result = paddedCipher.process(Uint8List.fromList(plainText));

  return [
    ...nonce,
    ...result,
  ];
}

List<int> aesDecrypt(List<int> key, List<int> iv, List<int> cipherText) {
  final cbcCipher = CBCBlockCipher(AESFastEngine());
  final ivParams = ParametersWithIV<KeyParameter>(
      KeyParameter(Uint8List.fromList(key)), Uint8List.fromList(iv));
  final paddingParams =
      // ignore: prefer_void_to_null
      PaddedBlockCipherParameters<ParametersWithIV<KeyParameter>, Null>(
          ivParams, null);
  final paddedCipher = PaddedBlockCipherImpl(PKCS7Padding(), cbcCipher)
    ..init(false, paddingParams);
  return paddedCipher.process(Uint8List.fromList(cipherText));
}

List<int> calculateAgreement(List<int>? publicKey, List<int>? privateKey) {
  if (publicKey == null) {
    throw Exception('publicKey value is null');
  }

  if (privateKey == null) {
    throw Exception('privateKey value is null');
  }
  return x25519.X25519(privateKey, publicKey);
}

Uint8List toLeByteArray(int v) {
  final result = Uint8List(2);
  result[0] = v;
  result[1] = v >> 8;
  return result;
}

int leByteArrayToInt(List<int> array) => array[0] + array[1];

final Random _random = Random.secure();

List<int> generateRandomKey([int length = 32]) =>
    List<int>.generate(length, (i) => _random.nextInt(256));

int generateRandomInt(int max) => _random.nextInt(max);