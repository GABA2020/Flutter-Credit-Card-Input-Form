import 'package:flutter/material.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/provider/card_cvv_provider.dart';
import 'package:provider/provider.dart';

class CardCVV extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<CardCVVProvider>(
      builder: (context, value, child) {
        return Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(
            height: 50,
            width: 70,
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.all(Radius.circular(10)),
            ),
            child: Center(
              child: Text(
                value.cardCVV != '' ? value.cardCVV : 'CVC',
                style: value.cardCVV != ''
                    ? Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.black, fontSize: 18)
                    : Theme.of(context)
                        .textTheme
                        .headline1!
                        .copyWith(color: Colors.grey, fontSize: 18),
              ),
            ),
          ),
        );
      },
    );
  }
}
