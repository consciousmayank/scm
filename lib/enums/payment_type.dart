enum PaymentType {
  FULL,
  PARTIAL,
  NONE,
}

extension OrderPaymentValue on PaymentType {
  String get getPaymentValue {
    switch (this) {
      case PaymentType.FULL:
        return 'FULL';
      case PaymentType.PARTIAL:
        // TODO: Handle this case.
        return 'PARTIAL';
      case PaymentType.NONE:
        return 'NONE';
        break;
      default:
        return "";
    }
  }
}
