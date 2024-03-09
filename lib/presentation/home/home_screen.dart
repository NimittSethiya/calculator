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
  String bg_image_loc1="https://images.pexels.com/photos/3394939/pexels-photo-3394939.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";
  String bg_image_loc2="https://images.pexels.com/photos/3560168/pexels-photo-3560168.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=1";

  final TextEditingController valueController = TextEditingController(text: '0');
  double firstValue = 0;
  double secondValue = 0;
  String? operator;
  final FocusNode focusNode = FocusNode();

  String bg_swap="";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    bg_swap= bg_image_loc1;
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0x3F6F6FF5),
      body: SafeArea(

        child: Container(
          padding: EdgeInsets.all(14),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.4,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(bg_swap),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: focusNode.hasFocus ? BorderRadius.all(Radius.circular(32)) : BorderRadius.all(Radius.circular(16))
                    ),

                    child: TextField(
                      focusNode: focusNode,
                      style: TextStyle(color: Color(0xFFFFFFFF),
                      fontWeight: FontWeight.bold,
                      ),
                      cursorColor: Color(0xFC4444AF),
                      controller: valueController,
                      keyboardType: TextInputType.none,
                      textAlign: TextAlign.end,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(32)),
                              borderSide:  BorderSide(color: Color(0xFD4B4BFA), width: 2.0)
                          ),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(16)),
                              borderSide:  BorderSide(color: Color(0xFD4B4BFA), width: 0.0)
                          ) ,
                          fillColor: Color(0x455B5BFC),
                          contentPadding: EdgeInsets.all(20)),
                    ),),
                ),
              ),
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
                        numberWidget(context,number: 9,),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context,number: 0),
                        numberWidget(context, action: "-"),
                        numberWidget(context,action: '*'),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        numberWidget(context, action: "+"),
                        numberWidget(context,action: "/"),
                        numberWidget(context,action: '='),
                      ],
                    ),Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        numberWidget(context,action: "CLS"),
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
        if(valueController.text == "0" && action == null){
          valueController.text = "$number";
        }else if(action == null){
          valueController.text = valueController.text + "$number";
        }else{
          switch(action){
            case '+':
              calculation();
              operator = '+';
              break;
            case '-':
              calculation();
              operator = '-';
              break;
            case '*':
              calculation();
              operator = '*';
              break;
            case '/':
              calculation();
              operator = '/';
              break;
            case 'CLS':
              calculation();
              operator = 'CLS';

              valueController.text = '0';
              break;
            case '=':
              calculation();
              valueController.text = "$firstValue";
          }
        }
        secondValue = double.tryParse(valueController.text) ?? 0;


        setState(() {
          bg_swap = (bg_swap==bg_image_loc1)? bg_image_loc2: bg_image_loc1;
        });
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.25-16,
          decoration: BoxDecoration(
            image: DecorationImage(image: NetworkImage(bg_image_loc1),
            fit: BoxFit.fill),
              color: Color(0x232323FF),
              //BoxShape shape = BoxShape.circle,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: Color(0xFD4B4BFA))
          ),
          child: Center(child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text('${number ?? action}',
              style: TextStyle(color: Color(0xFFFFFFFF),
                  fontWeight: FontWeight.bold,
                  fontSize: 21,
              ),),
          )),
        ),
      ),
    );
  }

  // function to Calculate
  void calculation() {
    print("-------------------------------------------");
    print("firstValue $firstValue");
    print("secondValue $secondValue");
    print("-------------------------------------------");

    // calculate value based on opeator, then reset value for second and operator
    if(firstValue != 0 && operator != null){
      switch(operator){
        case '+':
          firstValue = firstValue + secondValue;
          break;
        case '-':
          firstValue = firstValue - secondValue;
          break;
        case '*':
          firstValue = firstValue * secondValue;
          break;
        case '/':
          firstValue = double.parse((firstValue / secondValue).toStringAsFixed(2));
          break;
        case 'CLS':
          firstValue = 0;
          secondValue = 0;
          break;

      }
      secondValue = 0;
      operator = null;
    }else{
      firstValue = secondValue;
    }
    valueController.text = '';
    focusNode.requestFocus();
  }
}