import 'package:credit_card_input_form/constants/captions.dart';
import 'package:credit_card_input_form/provider/state_provider.dart';
import 'package:credit_card_input_form/util/util.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/provider/card_cvv_provider.dart';
import 'package:credit_card_input_form/provider/card_name_provider.dart';
import 'package:credit_card_input_form/provider/card_valid_provider.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:credit_card_input_form/provider/card_number_provider.dart';

class InputViewPager extends StatefulWidget {
  final GlobalKey<FlipCardState>? cardKey;
  InputViewPager({this.cardKey});
  @override
  _InputViewPagerState createState() => _InputViewPagerState();
}

class _InputViewPagerState extends State<InputViewPager> {
  final List<FocusNode> focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final captions = Provider.of<Captions>(context);

    final titleMap = {
      0: captions.getCaption('CARD_NUMBER'),
      1: captions.getCaption('CARDHOLDER_NAME'),
      2: captions.getCaption('VALID_THRU'),
      3: captions.getCaption('SECURITY_CODE_CVC'),
    };

    void onfocus(index) {
      if (widget.cardKey!.currentState!.isFront && index == 3) {
        widget.cardKey!.currentState!.toggleCard();
      }
      if (!widget.cardKey!.currentState!.isFront && (index < 3)) {
        widget.cardKey!.currentState!.toggleCard();
      }
      var nextState;
      switch (index) {
        case 0:
          nextState = InputState.NUMBER;
          break;
        case 1:
          nextState = InputState.NAME;
          break;
        case 2:
          nextState = InputState.VALIDATE;
          break;
        case 3:
          nextState = InputState.CVV;
          break;
      }
      Provider.of<StateProvider>(context, listen: false).moveToState(nextState);
    }

    String cardNumber =
        Provider.of<CardNumberProvider>(context, listen: false).cardNumber;

    return Container(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 32),
        child: Column(
          children: [
            InputForm(
              onfocus: onfocus,
              isAutoFocus: true,
              focusNode: focusNodes[0],
              title: titleMap[0],
              index: 0,
              maxLength: 19,
              textInputType: TextInputType.number,
            ),
            InputForm(
              onfocus: onfocus,
              isAutoFocus: false,
              focusNode: focusNodes[1],
              title: titleMap[1],
              index: 1,
              maxLength: 20,
              textInputType: TextInputType.text,
            ),
            InputForm(
              onfocus: onfocus,
              isAutoFocus: false,
              focusNode: focusNodes[2],
              title: titleMap[2],
              index: 2,
              maxLength: 5,
              textInputType: TextInputType.number,
            ),
            InputForm(
              onfocus: onfocus,
              isAutoFocus: false,
              focusNode: focusNodes[3],
              title: titleMap[3],
              index: 3,
              maxLength:
                  CardCompany.AMERICAN_EXPRESS == detectCardCompany(cardNumber)
                      ? 4
                      : 3,
              textInputType: TextInputType.number,
            ),
          ],
        ),
      ),
    );
  }
}

class InputForm extends StatefulWidget {
  final String? title;
  final int? index;
  final FocusNode? focusNode;
  final Function onfocus;
  final isAutoFocus;
  final maxLength;
  final textInputType;

  InputForm({
    required this.title,
    required this.maxLength,
    required this.textInputType,
    required this.onfocus,
    this.index,
    this.focusNode,
    this.isAutoFocus,
  });

  @override
  _InputFormState createState() => _InputFormState();
}

class _InputFormState extends State<InputForm> {
  TextEditingController textController = TextEditingController();

  String? value;

  @override
  void initState() {
    super.initState();

    widget.focusNode!.addListener(() {
      if (widget.focusNode!.hasFocus) widget.onfocus(widget.index);
    });
  }

  var isInit = false;

  @override
  Widget build(BuildContext context) {
    String? textValue = "";

    if (widget.index == InputState.NUMBER.index) {
      textValue =
          Provider.of<CardNumberProvider>(context, listen: false).cardNumber;
    } else if (widget.index == InputState.NAME.index) {
      textValue =
          Provider.of<CardNameProvider>(context, listen: false).cardName;
    } else if (widget.index == InputState.VALIDATE.index) {
      textValue =
          Provider.of<CardValidProvider>(context, listen: false).cardValid;
    } else if (widget.index == InputState.CVV.index) {
      textValue = Provider.of<CardCVVProvider>(context).cardCVV;
    }

    return Container(
      margin: EdgeInsets.only(bottom: 6),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            widget.title!,
            style: TextStyle(fontSize: 14, color: Colors.black38),
          ),
          SizedBox(
            height: 5,
          ),
          TextField(
            autocorrect: false,
            autofocus: widget.isAutoFocus,
            controller: textController
              ..value = textController.value.copyWith(
                text: textValue,
                selection: TextSelection.fromPosition(
                  TextPosition(offset: textValue!.length),
                ),
              ),
            focusNode: widget.focusNode,
            keyboardType: widget.textInputType,
            maxLength: widget.maxLength,
            onChanged: (String newValue) {
              if (widget.index == InputState.NUMBER.index) {
                Provider.of<CardNumberProvider>(context, listen: false)
                    .setNumber(newValue);
              } else if (widget.index == InputState.NAME.index) {
                Provider.of<CardNameProvider>(context, listen: false)
                    .setName(newValue);
              } else if (widget.index == InputState.VALIDATE.index) {
                Provider.of<CardValidProvider>(context, listen: false)
                    .setValid(newValue);
              } else if (widget.index == InputState.CVV.index) {
                Provider.of<CardCVVProvider>(context, listen: false)
                    .setCVV(newValue);
              }
            },
            decoration: InputDecoration(
              isDense: true,
              counter: SizedBox(
                height: 0,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              border: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.grey),
                  borderRadius: BorderRadius.circular(5)),
              focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(width: 1, color: Colors.blue),
                  borderRadius: BorderRadius.circular(5)),
            ),
          )
        ],
      ),
    );
  }
}
