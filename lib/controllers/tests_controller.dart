import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dars_46/models/test.dart';
import 'package:dars_46/services/firebase_cloud_services.dart';
import 'package:flutter/material.dart';

class TestsController extends ChangeNotifier {
  final _test = TestsFirebaseServices();
  List<int> _clicked = [];

  Stream<QuerySnapshot> get getTest {
    return _test.getTests();
  }

  void addTest(Test test) async{
    _test.addTest(test);
    notifyListeners();
  }

  void editTest(Test test) {
    _test.editTest(test);
    notifyListeners();
  }

  void deleteTest(String id){
    _test.deleteTest(id);
    notifyListeners();
  }

  List<int> clickedIndexs(){
    return [..._clicked];
  }

  void clickQuestion(int id){
    _clicked.add(id);
    notifyListeners();
  }

  void allRemoveIndexs(){
    _clicked = [];
    notifyListeners();
  }


}
