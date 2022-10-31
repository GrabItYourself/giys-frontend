import 'package:flutter/material.dart';
import 'package:giys_frontend/views/setting/credit_card_view.dart';

class PaymentMethodView extends StatefulWidget {
  const PaymentMethodView({super.key});

  @override
  State<PaymentMethodView> createState() => _PaymentMethodViewState();
}

class _PaymentMethodViewState extends State<PaymentMethodView> {
  var creditCardList;

  @override
  void initState() {
    // TODO: implement initState get creditCardList
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
            itemCount: creditCardList.length,
            itemBuilder: (context, index) {
              final creditCard = creditCardList[index];
              return ListTile(
                title: Text(
                  creditCard.number,
                  maxLines: 1,
                  softWrap: true,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: IconButton(
                  onPressed: () async {
                    //TODO go to that credit card page
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) =>
                            CreditCardView(creditCard: creditCard),
                      ),
                    );
                  },
                  icon: const Icon(Icons.edit),
                ),
              );
            },
          ),
          TextButton(
            onPressed: () {
              //TODO go to add credit card page
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => CreditCardView(creditCard: null),
                ),
              );
            },
            child: const Text("Add Credit Card"),
          )
        ],
      ),
    );
  }
}
