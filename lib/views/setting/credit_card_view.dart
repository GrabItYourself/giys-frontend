import 'package:flutter/material.dart';

class CreditCardView extends StatefulWidget {
  final creditCard;
  const CreditCardView({super.key, this.creditCard});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  @override
  void initState() {
    // TODO: implement initState
    if (widget.creditCard ?? false) {
      //edit
    } else {
      //create
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
