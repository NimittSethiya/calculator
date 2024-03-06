import 'dart:js';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController valueController = TextEditingController(text: '0');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: TextField(
                  controller: valueController,
                  keyboardType: TextInputType.none,
                  textAlign: TextAlign.end,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(20)
                  ),
                ),
              ),),
              SizedBox(
                height:  (MediaQuery.of(context).size.height * 0.6) - 32,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context, number: 1),
                        numberWidget(context, number: 2),
                        numberWidget(context,number: 3),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 4),
                        numberWidget(context,number: 5),
                        numberWidget(context,number: 6),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 7),
                        numberWidget(context,number: 8),
                        numberWidget(context,number: 9),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget numberWidget(BuildContext context, {int? number, String? action}){
    return GestureDetector(
      onTap: (){
        if(valueController.text == "0"){
          valueController.text = "$number";
        }else{
          valueController.text = valueController.text + "$number";
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.3,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            border: Border.all()
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('$number'),
          )),
        ),
      ),
    );
  }
}
