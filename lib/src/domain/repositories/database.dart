import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_bloc_ui/src/domain/models/array_item.dart';
import 'package:firebase_bloc_ui/src/domain/models/failure.dart';

class DatabaseImpl {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance
    ..settings = const Settings(persistenceEnabled: false);

  Future<Either<Failure, List<ArrayItem>>> readItems() async {
    log('***** Database readItems call');
    try {
      final QuerySnapshot<Map<String, dynamic>> queryItems =
          await _firestore.collection('items').get();
      List<ArrayItem> items = [];

      if (queryItems.docs.isNotEmpty) {
        items.addAll(
            queryItems.docs.map((query) => ArrayItem.fromJson(query.data())));
      }

      return Right(items);
    } catch (e) {
      log('***** Database readItems failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> createItem(ArrayItem item) async {
    log('***** Database createItem call');
    try {
      final WriteBatch batch = _firestore.batch();

      batch.set(
        _firestore.collection('items').doc(),
        item.toJson(),
      );

      batch.commit();

      return const Right(true);
    } catch (e) {
      log('***** Database createItem failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> updateItem(ArrayItem item) async {
    log('***** Database updateItem call');
    try {
      final QuerySnapshot<Map<String, dynamic>> queryItems = await _firestore
          .collection('items')
          .where('id', isEqualTo: item.id)
          .get();
      final WriteBatch batch = _firestore.batch();

      batch.update(
        queryItems.docs.first.reference,
        item.toJson(),
      );

      batch.commit();

      return const Right(true);
    } catch (e) {
      log('***** Database updateItem failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }

  Future<Either<Failure, bool>> deleteItem(String deletedId) async {
    log('***** Database deleteItem call');
    try {
      final QuerySnapshot<Map<String, dynamic>> queryItems = await _firestore
          .collection('items')
          .where('id', isEqualTo: deletedId)
          .get();
      final WriteBatch batch = _firestore.batch();

      batch.delete(queryItems.docs.first.reference);
      batch.commit();

      return const Right(true);
    } catch (e) {
      log('***** Database deleteItem failure');
      return const Left(CommonFailure('Firestore failure'));
    }
  }
}
