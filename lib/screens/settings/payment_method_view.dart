import 'package:flutter/material.dart';
import 'package:giys_frontend/screens/settings/credit_card_view.dart';

import '../../data/credit_card.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  late List<CreditCard> creditCardList;

  @override
  void initState() {
    // TODO: implement get creditCardList
    creditCardList = [];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Payment"),
      ),
      body: Column(
        children: [
          ListView.builder(
            itemBuilder: (context, index) {
              final creditCard = creditCardList[index];
              return ListTile(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CreditCardView(
                        creditCard: creditCard,
                      ),
                    ),
                  );
                },
                title: Text(creditCard.cardNumber),
                trailing: IconButton(
                  onPressed: () {
                    //TODO delete from database
                    creditCardList.remove(creditCard);
                  },
                  icon: const Icon(Icons.delete),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              MaterialPageRoute(
                builder: (context) => CreditCardView(),
              );
            },
            child: const Text("Add Credit Card"),
          )
        ],
      ),
    );
  }
}
