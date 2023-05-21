import 'package:flutter/material.dart';
import 'package:moyasar/moyasar.dart';
import 'package:uni_pay/src/utils/extension/size_extension.dart';
import 'package:uni_pay/src/views/design_system.dart';
import 'package:uni_pay/src/views/uni_apple_pay.dart';

import '../../../constant/uni_text.dart';
import '../../../core/keys/api_keys.dart';
import '../core/services/uni_moyasar.dart';

class UniPayCard extends StatefulWidget {
  const UniPayCard({Key? key}) : super(key: key);

  @override
  State<UniPayCard> createState() => _UniPayCardState();
}

class _UniPayCardState extends State<UniPayCard> {
  @override
  Widget build(BuildContext context) {
    return UniPayScaffold(
      title: UniPayText.payWithCard,
      builder: (_) => ListView(
        padding: EdgeInsets.all(20.rSp),
        children: [
          const UniPayApplePay(),
          SizedBox(height: 20.rh),
          Directionality(
            textDirection: TextDirection.ltr,
            child: CreditCard(
              locale: UniPayText.isEnglish
                  ? const Localization.en()
                  : const Localization.ar(),
              config: ApiKeys.moyasarPaymentConfig,
              onPaymentResult: (r) =>
                  UniPayMoyasarGateway.processMoyasarPayment(context,
                      result: r),
            ),
          ),
        ],
      ),
    );
  }
}