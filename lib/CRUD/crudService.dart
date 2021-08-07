import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class crudService {
  updateData(selectDoc, newValues) {
    FirebaseFirestore.instance
        .collection('HelpField')
        .doc(selectDoc)
        .update(newValues)
        .catchError((e) {
      print(e);
    });
  }

  deleteData(docId) {
    FirebaseFirestore.instance
        .collection('HelpField')
        .doc(docId)
        .delete()
        .catchError((e) {
      print(e);
    });
  }
}
