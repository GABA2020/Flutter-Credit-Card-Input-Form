import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/provider/state_provider.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/components/card_logo.dart';
import 'package:provider/provider.dart';
import 'card_cvv.dart';
import 'card_sign.dart';

class BackCardView extends StatelessWidget {
  final height;
  final decoration;

  BackCardView({this.height, this.decoration});

  @override
  Widget build(BuildContext context) {
    final currentState =
        Provider.of<StateProvider>(context, listen: false).getCurrentState();
    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: height,
      decoration: decoration,
      child: Stack(
        children: <Widget>[
          Positioned(
            top: -100,
            right: -70,
            child: Container(
              width: 270,
              height: 270,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x22FFFFFF)),
            ),
          ),
          Positioned(
            top: -110,
            left: -55,
            child: Container(
              width: 300,
              height: 300,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0x0aFFFFFF)),
            ),
          ),
          Container(
            margin: EdgeInsets.only(top: 25),
            height: 35,
            color: Colors.black,
          ),
          Align(alignment: Alignment.centerLeft, child: CardSign()),
          AnimatedOpacity(
            opacity: currentState != InputState.DONE ? 1 : 0,
            duration: Duration(milliseconds: 300),
            child: Align(
                alignment: Alignment.centerRight,
                child: Container(
                  margin: EdgeInsets.only(right: 30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color:
                          Colors.yellow, //                   <--- border color
                      width: 1.0,
                    ),
                  ),
                  child: Container(
                    height: 55,
                    width: 75,
                  ),
                )),
          ),
          Align(
              alignment: Alignment.centerRight,
              child: Container(
                margin: EdgeInsets.only(right: 30),
                child: CardCVV(),
              )),
          Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 10, right: 30),
                child: CardLogo(),
              )),
        ],
      ),
    );
  }
}
