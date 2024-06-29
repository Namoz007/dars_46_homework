import 'package:dars_46/models/test.dart';
import 'package:flutter/material.dart';

class AddTestDialog extends StatefulWidget {
  bool addTest;
  Test? test;
  AddTestDialog({super.key,required this.addTest,this.test});

  @override
  State<AddTestDialog> createState() => _AddTestDialogState();
}

class _AddTestDialogState extends State<AddTestDialog> {
  final _fromKey = GlobalKey<FormState>();
  final question = TextEditingController();
  final firstOption = TextEditingController();
  final secondOption = TextEditingController();
  final threedOption = TextEditingController();
  final fourthOption = TextEditingController();
  final trueQuestion = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: widget.addTest ? Text("Add new test!") : Text("Edit test"),
      content: SingleChildScrollView(
        child: Form(
          key: _fromKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                validator: (value){
                  if(value == null || value.trim().isEmpty)
                    return "Please,return test question";
        
                  return null;
                },
                controller: question,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                  hintText: widget.addTest ? "Test question" : "${widget.test!.question}"
                ),
              ),
              SizedBox(height: 20,),
        
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please,return first option.";

                  return null;
                },
                controller: firstOption,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.addTest ? "First option" : "${widget.test!.options[0]}"
                ),
              ),
              SizedBox(height: 20,),
        
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please,return second option.";

                  return null;
                },
                controller: secondOption,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.addTest ? "Second option" : "${widget.test!.options[1]}"
                ),
              ),
              SizedBox(height: 20,),
        
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please,return threed option.";

                  return null;
                },
                controller: threedOption,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.addTest ? "Threed option" : "${widget.test!.options[2]}"
                ),
              ),
              SizedBox(height: 20,),
        
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please,return fourth option.";

                  return null;
                },
                controller: fourthOption,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.addTest ? "Fourth option" : "${widget.test!.options[3]}"
                ),
              ),
              SizedBox(height: 20,),
        
        
              TextFormField(
                validator: (value){
                  if(value == null || value.isEmpty)
                    return "Please,test true number";

                  try{
                    int numb = int.parse(value.trim());
                    if(numb > 5 || numb < 0){
                      return "The correct number of the test must be less than 5";
                    }
                    return null;
                  }catch(e){
                    return "True test number not number";
                  }
                },
                controller: trueQuestion,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(25),
                    ),
                    hintText: widget.addTest ? "True question number" : "${widget.test!.trueAnswer}"
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        ElevatedButton(onPressed: (){
          Navigator.pop(context);
        }, child: Text("Cancel"),),

        ElevatedButton(onPressed: (){
          if(_fromKey.currentState!.validate()){
            String id = '0';
            if(!widget.addTest)
              id = widget.test!.id;
            Navigator.of(context).pop(Test(id: id, question: question.text, options: [firstOption.text,secondOption.text,threedOption.text,fourthOption.text], trueAnswer: int.parse(trueQuestion.text)));
          }
        }, child: Text("Add test"),)
      ],
    );
  }
}
