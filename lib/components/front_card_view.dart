import 'package:credit_card_input_form/constants/captions.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/components/yellow_border.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:provider/provider.dart';
import 'card_logo.dart';
import 'card_name.dart';
import 'card_number.dart';
import 'card_valid.dart';

class FrontCardView extends StatelessWidget {
  final height;
  final decoration;

  FrontCardView({this.height, this.decoration});

  @override
  Widget build(BuildContext context) {
    final captions = Provider.of<Captions>(context);

    return Container(
      margin: EdgeInsets.only(bottom: 5),
      height: height,
      decoration: decoration,
      child: Stack(
        children: [
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
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Stack(
              children: <Widget>[
                YellowBorder(),
                Align(
                  alignment: Alignment.topLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 2),
                            child: Image.asset(
                              'images/logo.png',
                              height: 24,
                              package: 'credit_card_input_form',
                            ),
                          ),
                          Text(
                            '  Black',
                            style:
                                Theme.of(context).textTheme.headline2!.copyWith(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 9),
                        child: Image.asset(
                          'images/gaba-healt-icon.png',
                          width: 40,
                          package: 'credit_card_input_form',
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: CardNumber(),
                ),
                Align(alignment: Alignment.topRight, child: CardLogo()),
                Align(
                  alignment: Alignment.bottomLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          captions.getCaption('CARDHOLDER_NAME')!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CardName(),
                      ],
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: <Widget>[
                        Text(
                          captions.getCaption('VALID_THRU')!.toUpperCase(),
                          style: Theme.of(context)
                              .textTheme
                              .headline1!
                              .copyWith(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        CardValid(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
