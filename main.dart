import 'dart:ui';

import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(
    home: HomePage(),
    debugShowCheckedModeBanner: false,
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _controller1 = new TextEditingController();
  TextEditingController _controller2 = new TextEditingController();
  TextEditingController _controller3 = new TextEditingController();
  String? selected;
  double? totalInterest;
  double? monthlyInterest;
  double? monthlyInstallment;

  void loancalculation() {
    final amount = int.parse(_controller1.text) - int.parse(_controller2.text);
    final tinterest = amount * (double.parse(_controller3.text) / 100) * int.parse(selected!);
    final minstall = (amount + tinterest) / (int.parse(selected!) * 12);
    final minterest = tinterest / (int.parse(selected!) * 12);
    setState(() {
      totalInterest = tinterest;
      monthlyInterest = minterest;
      monthlyInstallment = minstall;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.notes, size: 30, color: Colors.white),
        toolbarHeight: 100,
        backgroundColor: Colors.blue,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: Icon(
              Icons.info,
              size: 30,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      color: Colors.blueGrey,
      child: Column(
        children: [
          Container(
            height: 100,
            decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20))),
            child: Padding(
              padding: const EdgeInsets.only(bottom: 50.0),
              child: Align(
                alignment: Alignment.center,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Car Loan Calculator",
                      style: TextStyle(
                          fontSize: 40,
                          decoration: TextDecoration.none,
                          color: Colors.white),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(40, 10, 50, 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InputForm(
                      title: "Car Price",
                      hintText: "e.g 9000",
                      controller: _controller1),
                  InputForm(
                      title: "Downpayment",
                      hintText: "e.g 9000",
                      controller: _controller2),
                  InputForm(
                      title: "Interest Rate",
                      hintText: "e.g 3.5",
                      controller: _controller3),
                  Text(
                    "Loan Period",
                    style: TextStyle(
                        fontSize: 20,
                        decoration: TextDecoration.none,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      loanPeriod("1"),
                      loanPeriod("2"),
                      loanPeriod("3"),
                      loanPeriod("4"),
                      loanPeriod("5"),
                      loanPeriod("6"),
                      loanPeriod("7"),
                      loanPeriod("8"),
                      loanPeriod("9"),
                    ],
                  ),
                  SizedBox(
                    height: 1,
                  ),
                  GestureDetector(
                    onTap: () {
                      loancalculation();
                      Future.delayed(Duration.zero);

                      showModalBottomSheet(
                          isDismissible: false,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          context: context,
                          builder: (BuildContext context) {
                            return Container(
                              height: 400,
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 30, 0, 0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Results",
                                      style: TextStyle(
                                          fontSize: 30,
                                          decoration: TextDecoration.none,
                                          color: Colors.black),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    results(
                                        title: "Total Interest",
                                        amount: totalInterest),
                                    results(
                                        title: "Monthly Interest",
                                        amount: monthlyInterest),
                                    results(
                                        title: "Monthly Installment",
                                        amount: monthlyInstallment),
                                  ],
                                ),
                              ),
                            );
                          });
                    },
                    child: Container(
                      height: 50,
                      width: 100,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                        child: Text(
                          "Calculate",
                        ),
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }

  Widget InputForm(
      {required String title,
      required TextEditingController controller,
      required String hintText}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
        SizedBox(
          height: 2,
          width: 500,
        ),
        SizedBox(
          height: 20,
        ),
        Container(
          height: 50,
          width: 1200,
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: TextField(
            controller: controller,
            style: const TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: OutlineInputBorder(borderSide: BorderSide.none),
              hintText: hintText,
            ),
          ),
        )
      ],
    );
  }

  Widget loanPeriod(String title) {
    return GestureDetector(
      onTap: () {
        selected = title;
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 20, 0),
        child: Container(
          height: 40,
          width: 40,
          decoration: BoxDecoration(
              border: title == selected
                  ? Border.all(color: Colors.amber, width: 2)
                  : null,
              color: Colors.lightBlue,
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: Text(title),
          ),
        ),
      ),
    );
  }

  Widget results({required String title, double? amount}) {
    return ListTile(
      title: Text(
        title,
        style: TextStyle(fontSize: 18),
      ),
      trailing: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: Text(
          "RM" + amount!.toStringAsFixed(2),
          style: TextStyle(fontSize: 17),
        ),
      ),
    );
  }
}
