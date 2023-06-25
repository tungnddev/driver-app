import 'package:driver/generated/l10n.dart';
import 'package:flutter/cupertino.dart';

enum PaymentMethodVM {
  cash, creditCard, check, purchaseOrder
}

extension Convert on PaymentMethodVM {
  String toStringDisplay(BuildContext context) {
    switch (this) {
      case PaymentMethodVM.cash:
        return S.of(context).cash;
      case PaymentMethodVM.creditCard:
        return S.of(context).credit_card;
      case PaymentMethodVM.check:
        return S.of(context).check;
      case PaymentMethodVM.purchaseOrder:
        return S.of(context).purchase_order;
    }
  }
}