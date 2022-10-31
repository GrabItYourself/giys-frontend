import 'package:flutter/material.dart';
import '../../data/credit_card.dart';

class CreditCardView extends StatefulWidget {
  final CreditCard? creditCard;
  const CreditCardView({super.key, this.creditCard});

  @override
  State<CreditCardView> createState() => _CreditCardViewState();
}

class _CreditCardViewState extends State<CreditCardView> {
  late DateTime selectedDate;

  late final TextEditingController _cardNumberController;
  late final TextEditingController _cardHolderNameController;
  late final TextEditingController _cVVController;

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    if (widget.creditCard != null) {
      //edit credit card
      _cardNumberController =
          TextEditingController(text: widget.creditCard!.cardNumber);
      _cardHolderNameController =
          TextEditingController(text: widget.creditCard!.cardHolderName);
      _cVVController = TextEditingController(text: widget.creditCard!.cVV);

      selectedDate = widget.creditCard!.expDate;
    } else {
      //create credit card
      _cardNumberController = TextEditingController();
      _cardHolderNameController = TextEditingController();
      _cVVController = TextEditingController();
      selectedDate = DateTime.now();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Credit Card"),
        actions: [
          IconButton(
            onPressed: () async {
              //TODO save to database
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      body: Column(
        children: [
          TextField(
            controller: _cardNumberController,
            decoration: const InputDecoration(
              hintText: "Card Number",
            ),
          ),
          TextField(
            controller: _cardHolderNameController,
            decoration: const InputDecoration(
              hintText: "Card Holder Name",
            ),
          ),
          Row(
            children: [
              Text("${selectedDate.toLocal()}".split(' ')[0]),
              TextButton(
                onPressed: () => _selectDate(context),
                child: const Text('Select date'),
              )
            ],
          ),
          TextField(
            controller: _cVVController,
            decoration: const InputDecoration(
              hintText: "CVV",
            ),
          )
        ],
      ),
    );
  }
}
