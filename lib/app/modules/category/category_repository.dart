import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

import 'category_model.dart';

class CategoryRepository {
  final CollectionReference _categoryCollectionReference =
      FirebaseFirestore.instance.collection('category');

  final StreamController<List<Category>> _categoryController =
      StreamController<List<Category>>.broadcast();


  Future addCategory(Category category) async {
    try {
      await _categoryCollectionReference.add(category.toJson());
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Future getCategoryOnceOff() async {
    try {
      var categoryDocumentSnapshot = await _categoryCollectionReference.get();
      if (categoryDocumentSnapshot.docs.isNotEmpty) {
        var result = categoryDocumentSnapshot.docs
            .map((snapshot) => Category.fromJson(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem.valor != null)
            .toList();
            return result;
      }
    } catch (e) {
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }

  Stream listenToCategoryRealTime() {
    // Register the handler for when the posts data changes
    _categoryCollectionReference.snapshots().listen((categorySnapshot) {
      if (categorySnapshot.docs.isNotEmpty) {
        var categories = categorySnapshot.docs
            .map((snapshot) => Category.fromJson(snapshot.data() as Map<String, dynamic>, snapshot.id))
            .where((mappedItem) => mappedItem.nome != null)
            .toList();

        // Add the posts onto the controller
        _categoryController.add(categories);
      }
    });

    return _categoryController.stream;
  }

  Future deleteCategory(String? documentId) async {
    await _categoryCollectionReference.doc(documentId).delete();
  }

  Future updateCategory(Category category) async {
    try {
      await _categoryCollectionReference
          .doc(category.documentId)
          .update(category.toJson());
    } catch (e) {
      // TODO: Find or create a way to repeat error handling without so much repeated code
      if (e is PlatformException) {
        return e.message;
      }

      return e.toString();
    }
  }
}
