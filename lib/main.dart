import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/credit_card_input_form.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  void onCardFormChange(InputState currentState, CardInfo cardInfo) {
    print(currentState);
    print(cardInfo);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Material App Bar'),
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            child: CreditCardInputForm(
              cardHeight: 200,
              showResetButton: true,
              onStateChange: onCardFormChange,
              prevButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.grey,
                shape: BoxShape.rectangle,
              ),
              resetButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Colors.grey,
                shape: BoxShape.rectangle,
              ),
              nextButtonDecoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(6)),
                color: Color.fromRGBO(244, 198, 119, 1),
                shape: BoxShape.rectangle,
              ),
              initialAutoFocus: true, // optional
            ),
          ),
        ),
      ),
    );
  }
}
