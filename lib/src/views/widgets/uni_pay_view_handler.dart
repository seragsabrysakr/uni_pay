import 'package:flutter/material.dart';
import 'package:uni_pay/src/utils/extension.dart';

import '../../../uni_pay.dart';
import '../../modules/moyasar/views/uni_pay_moyasar_view.dart';

import '../../core/controllers/uni_pay_controller.dart';
import '../../utils/extension/size_extension.dart';
import '../design_system.dart';
import '../uni_pay_all_view.dart';

class UniPayViewHandler extends StatefulWidget {
  final Widget? leading;
  const UniPayViewHandler({Key? key,   this.leading}) : super(key: key);

  @override
  State<UniPayViewHandler> createState() => _UniPayViewHandlerState();
}

class _UniPayViewHandlerState extends State<UniPayViewHandler> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _viewHandler());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: UniPayDesignSystem.loadingIndicator());
  }

  Future _viewHandler() async {
    ScreenSizes.init(context);

    // Get the payment data
    UniPayData uniPayData = UniPayControllers.uniPayData;

    // Payment methods requested by client
    List<UniPayPaymentMethods> paymentMethods =
        uniPayData.credentials.paymentMethods;

    bool isSingleGatewayPayment = paymentMethods.length == 1;

    // Case 1:  Tamara checkout
    if (isSingleGatewayPayment && paymentMethods.first.isTamara) {
      context.uniPushReplacement(  UniPayTamara(leading: widget.leading,));
    }

    // Case 2:  Tabby checkout
    else if (isSingleGatewayPayment && paymentMethods.first.isTabby) {
      context.uniPushReplacement(  UniPayTabby(leading: widget.leading,));
    }
    // Case 3: Moyasar checkout
    else if ((isSingleGatewayPayment && paymentMethods.first.isMoyasar) ||
        (paymentMethods.length == 2 &&
            !paymentMethods.isTamaraGateway &&
            !paymentMethods.isTabbyGateway)) {
      context.uniPushReplacement(  UniPayCard(leading: widget.leading,));
    }
    // Case 4: All payment methods
    else {
      context.uniPushReplacement(  UniPayGatewayView(leading: widget.leading,));
    }
  }
}
