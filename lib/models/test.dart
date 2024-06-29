
import 'package:cloud_firestore/cloud_firestore.dart';

class Test {
  String id;
  String question;
  List<dynamic> options;
  int trueAnswer;

  Test({
    required this.id,
    required this.question,
    required this.options,
    required this.trueAnswer,
  });

  factory Test.fromJson(QueryDocumentSnapshot query) {
    return Test(
      id: query.id,
      question: query['question'],
      options: query['options'],
      trueAnswer: query['trueAnswer']
    );
  }
}
