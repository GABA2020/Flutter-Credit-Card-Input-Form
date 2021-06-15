import 'package:credit_card_input_form/components/reset_button.dart';
import 'package:credit_card_input_form/provider/card_last_four_provider.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:credit_card_input_form/components/back_card_view.dart';
import 'package:credit_card_input_form/components/front_card_view.dart';
import 'package:credit_card_input_form/components/input_view_pager.dart';
import 'package:credit_card_input_form/components/round_button.dart';
import 'package:credit_card_input_form/constants/constanst.dart';
import 'package:credit_card_input_form/model/card_info.dart';
import 'package:credit_card_input_form/provider/card_cvv_provider.dart';
import 'package:credit_card_input_form/provider/card_name_provider.dart';
import 'package:credit_card_input_form/provider/card_number_provider.dart';
import 'package:credit_card_input_form/provider/card_valid_provider.dart';
import 'package:credit_card_input_form/provider/state_provider.dart';
import 'package:provider/provider.dart';

import 'constants/captions.dart';
import 'constants/constanst.dart';

typedef CardInfoCallback = void Function(
    InputState currentState, CardInfo cardInfo);

class CreditCardInputForm extends StatelessWidget {
  CreditCardInputForm({
    this.editable = true,
    this.onStateChange,
    this.cardHeight,
    this.frontCardDecoration,
    this.backCardDecoration,
    this.showResetButton = true,
    this.customCaptions,
    this.cardNumber = '',
    this.cardName = '',
    this.cardCVV = '',
    this.cardValid = '',
    this.loading = false,
    this.initialAutoFocus = true,
    this.lastFour = '',
    this.intialCardState = InputState.NUMBER,
    this.nextButtonTextStyle = kDefaultButtonTextStyle,
    this.prevButtonTextStyle = kDefaultButtonTextStyle,
    this.resetButtonTextStyle = kDefaultButtonTextStyle,
    this.nextButtonDecoration = defaultNextPrevButtonDecoration,
    this.prevButtonDecoration = defaultNextPrevButtonDecoration,
    this.resetButtonDecoration = defaultResetButtonDecoration,
  });

  final Function? onStateChange;
  final double? cardHeight;
  final BoxDecoration? frontCardDecoration;
  final BoxDecoration? backCardDecoration;
  final bool showResetButton;
  final Map<String, String>? customCaptions;
  final BoxDecoration nextButtonDecoration;
  final BoxDecoration prevButtonDecoration;
  final BoxDecoration resetButtonDecoration;
  final TextStyle nextButtonTextStyle;
  final TextStyle prevButtonTextStyle;
  final TextStyle resetButtonTextStyle;
  final String cardNumber;
  final String cardName;
  final String cardCVV;
  final String cardValid;
  final initialAutoFocus;
  final bool loading;
  final bool editable;
  final InputState intialCardState;
  final String lastFour;

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => StateProvider(intialCardState),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNumberProvider(cardNumber),
        ),
        ChangeNotifierProvider(
          create: (context) => CardNameProvider(cardName),
        ),
        ChangeNotifierProvider(
          create: (context) => CardValidProvider(cardValid),
        ),
        ChangeNotifierProvider(
          create: (context) => CardCVVProvider(cardCVV),
        ),
        ChangeNotifierProvider(
          create: (context) => CardLastFourProvider(lastFour),
        ),
        Provider(
          create: (_) => Captions(customCaptions: customCaptions),
        ),
      ],
      child: CreditCardInputImpl(
        editable: editable,
        onCardModelChanged:
            onStateChange as void Function(InputState, CardInfo)?,
        backDecoration: backCardDecoration,
        frontDecoration: frontCardDecoration,
        cardHeight: cardHeight,
        initialAutoFocus: initialAutoFocus,
        showResetButton: showResetButton,
        prevButtonDecoration: prevButtonDecoration,
        nextButtonDecoration: nextButtonDecoration,
        resetButtonDecoration: resetButtonDecoration,
        prevButtonTextStyle: prevButtonTextStyle,
        nextButtonTextStyle: nextButtonTextStyle,
        resetButtonTextStyle: resetButtonTextStyle,
        initialCardState: intialCardState,
        loading: loading,
      ),
    );
  }
}

class CreditCardInputImpl extends StatefulWidget {
  final CardInfoCallback? onCardModelChanged;
  final double? cardHeight;
  final BoxDecoration? frontDecoration;
  final BoxDecoration? backDecoration;
  final bool? showResetButton;
  final BoxDecoration? nextButtonDecoration;
  final BoxDecoration? prevButtonDecoration;
  final BoxDecoration? resetButtonDecoration;
  final TextStyle? nextButtonTextStyle;
  final TextStyle? prevButtonTextStyle;
  final TextStyle? resetButtonTextStyle;
  final InputState? initialCardState;
  final bool? loading;
  final bool? editable;
  final initialAutoFocus;

  CreditCardInputImpl({
    this.onCardModelChanged,
    this.cardHeight,
    this.showResetButton,
    this.frontDecoration,
    this.backDecoration,
    this.nextButtonTextStyle,
    this.prevButtonTextStyle,
    this.resetButtonTextStyle,
    this.nextButtonDecoration,
    this.prevButtonDecoration,
    this.initialCardState,
    this.initialAutoFocus,
    this.loading,
    this.editable,
    this.resetButtonDecoration,
  });

  @override
  _CreditCardInputImplState createState() => _CreditCardInputImplState();
}

class _CreditCardInputImplState extends State<CreditCardInputImpl> {
  final GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  final cardHorizontalpadding = 12;
  final cardRatio = 16.0 / 9.0;

  var _currentState;

  @override
  void initState() {
    super.initState();

    _currentState = widget.initialCardState;
  }

  @override
  Widget build(BuildContext context) {
    final name = Provider.of<CardNameProvider>(context).cardName;
    final cardNumber = Provider.of<CardNumberProvider>(context).cardNumber;
    final valid = Provider.of<CardValidProvider>(context).cardValid;
    final cvv = Provider.of<CardCVVProvider>(context).cardCVV;
    final captions = Provider.of<Captions>(context);

    double cardWidth =
        MediaQuery.of(context).size.width - (2 * cardHorizontalpadding);

    double? cardHeight;
    if (widget.cardHeight != null && widget.cardHeight! > 0) {
      cardHeight = widget.cardHeight;
    } else {
      cardHeight = cardWidth / cardRatio;
    }

    final frontDecoration = widget.frontDecoration != null
        ? widget.frontDecoration
        : defaultCardDecoration;
    final backDecoration = widget.backDecoration != null
        ? widget.backDecoration
        : defaultCardDecoration;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: FlipCard(
            speed: 300,
            flipOnTouch: _currentState == InputState.DONE,
            key: cardKey,
            front:
                FrontCardView(height: cardHeight, decoration: frontDecoration),
            back: BackCardView(height: cardHeight, decoration: backDecoration),
          ),
        ),
        if (widget.editable == true) ...[
          InputViewPager(cardKey: cardKey),
          Padding(
            padding: EdgeInsets.fromLTRB(12, 40, 12, 12),
            child: MaterialButton(
              height: 50,
              padding: EdgeInsets.symmetric(vertical: 16),
              color: Color(0xFF3D499D),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              onPressed: () => {
                widget.onCardModelChanged!(
                  _currentState,
                  CardInfo(
                    name: name,
                    cardNumber: cardNumber,
                    validate: valid,
                    cvv: cvv,
                  ),
                )
              },
              child: widget.loading!
                  ? SizedBox(
                      width: 25,
                      height: 25,
                      child: CircularProgressIndicator(
                          valueColor: AlwaysStoppedAnimation(Colors.white)),
                    )
                  : Text(
                      captions.getCaption('NEXT')!,
                      style: Theme.of(context).textTheme.headline1!.copyWith(
                            color: Colors.white,
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
            ),
          ),
        ],
      ],
    );
  }
}
