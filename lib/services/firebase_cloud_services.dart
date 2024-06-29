import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_46/models/test.dart';

class TestsFirebaseServices {
  final _productCollection = FirebaseFirestore.instance.collection("Tests");

  Stream<QuerySnapshot> getTests() async* {
    yield* _productCollection.snapshots();
  }

  void addTest(Test test,) {
    _productCollection.add({
      "options": test.options,
      "question": test.question,
      "trueAnswer": test.trueAnswer - 1
    });
  }

  void editTest(Test test) {
    _productCollection.doc(test.id).update({
      "options": test.options,
      "question": test.question,
      "trueAnswer": test.trueAnswer
    });
  }

  void deleteTest(String id){
    _productCollection.doc(id).delete();
  }


}
