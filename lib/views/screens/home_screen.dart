import 'package:dars_46/controllers/tests_controller.dart';
import 'package:dars_46/models/test.dart';
import 'package:dars_46/views/widgets/add_test_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isStart = false;
  int trueQuestion = 0;
  int falseQuestion = 0;
  final pageController = PageController();
  bool isEnd = false;
  bool isLoading = true;

  void initState() {
    super.initState();
  }

  void nextPage() {
    pageController.nextPage(
        duration: Duration(seconds: 1), curve: Curves.linear);
  }

  @override
  Widget build(BuildContext context) {
    final testControllers = Provider.of<TestsController>(context);
    return Scaffold(
      backgroundColor: Colors.greenAccent,
      appBar: AppBar(
        backgroundColor: Colors.greenAccent,
        title: Text(
          'Welcome to Tests',
          style: TextStyle(color: Colors.red, fontSize: 25),
        ),
        centerTitle: true,
        actions: [
          !isLoading
              ? IconButton(
                  onPressed: () async {
                    final data = await showDialog(
                      context: context,
                      builder: (ctx) => AddTestDialog(
                        addTest: true,
                      ),
                    );
                    if (data != null) testControllers.addTest(data);
                  },
                  icon: Icon(Icons.add))
              : SizedBox()
        ],
      ),
      body: StreamBuilder(
        stream: testControllers.getTest,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.data == null) {
            return const Center(
              child: Text("Testlar mavjud emas"),
            );
          }

          isLoading = false;
          final data = snapshot.data!.docs;
          List<Test> tests = [];
          for (int i = 0; i < data.length; i++)
            tests.add(Test.fromJson(data[i]));
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              isStart
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(
                          'True:$trueQuestion',
                          style: TextStyle(
                              fontSize: 25,
                              color: Colors.green,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'False:$falseQuestion',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 25,
                              color: Colors.red),
                        )
                      ],
                    )
                  : SizedBox(),
              isStart
                  ? Expanded(
                      child: Center(
                        child: PageView.builder(
                          scrollDirection: Axis.vertical,
                          controller: pageController,
                          itemCount: tests.length,
                          itemBuilder: (ctx, index) {
                            Test test = tests[index];
                            return Center(
                              child: Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.symmetric(horizontal: 20),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Expanded(
                                            child: InkWell(
                                                onTap: () async {
                                                  final data = await showDialog(
                                                      context: context,
                                                      builder: (ctx) =>
                                                          AddTestDialog(
                                                            addTest: false,
                                                            test: test,
                                                          ));
                                                  if (data != null)
                                                    testControllers
                                                        .editTest(data);
                                                },
                                                child: Row(
                                                  children: [
                                                    InkWell(
                                                      onTap: () {
                                                        testControllers
                                                            .deleteTest(
                                                                test.id);
                                                      },
                                                      child: Icon(
                                                        Icons.delete,
                                                        color: Colors.red,
                                                      ),
                                                    ),
                                                    Expanded(
                                                      child: Text(
                                                        '${index + 1}.${test.question}',
                                                        style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 22,
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold),
                                                      ),
                                                    ),
                                                  ],
                                                )),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      for (int i = 0;
                                          i < test.options.length;
                                          i++)
                                        InkWell(
                                          onTap: () {
                                            if (!testControllers
                                                .clickedIndexs()
                                                .contains(
                                                index)) if (i ==
                                                test.trueAnswer) {
                                              trueQuestion += 1;
                                              testControllers
                                                  .clickQuestion(index);
                                            } else {
                                              falseQuestion += 1;
                                              testControllers
                                                  .clickQuestion(index);
                                            }
                                            nextPage();
                                            if (index + 1 == tests.length) {
                                              isStart = false;
                                              isEnd = true;
                                            }
                                          },
                                          child: Text(
                                            "${i + 1}.${test.options[i]}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 18,
                                                color: Colors.white),
                                          ),
                                        )
                                    ],
                                  )),
                            );
                          },
                        ),
                      ),
                    )
                  : Center(
                      child: Column(
                        children: [
                          isEnd
                              ? Text(
                                  'Game end',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              : SizedBox(),
                          isEnd
                              ? Text(
                                  'True answer: ${trueQuestion}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              : SizedBox(),
                          isEnd
                              ? Text(
                                  'False answer: ${falseQuestion}',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 25),
                                )
                              : SizedBox(),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                isStart = true;
                                isEnd = false;
                                trueQuestion = 0;
                                falseQuestion = 0;
                                testControllers.allRemoveIndexs();
                              });
                            },
                            icon: Container(
                              height: 50,
                              width: 290,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(30)),
                              alignment: Alignment.center,
                              child: Text(
                                '${isEnd ? "Restart" : "Start"}',
                                style: TextStyle(
                                    fontSize: 25, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
              SizedBox()
            ],
          );
        },
      ),
    );
  }
}
