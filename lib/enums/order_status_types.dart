import 'dart:ui';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:scm/app/appcolors.dart';

///Used to show the statuses of the current user's Order
enum OrderStatusTypes {
  CREATED,
  PROCESSING,
  INTRANSIT,
  DELIVERED,
  CANCELLED,
  NONE,
  SHIPPED,
}

extension OrderStatusTypesIntValues on OrderStatusTypes {
  int get getStatusCode {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return OrderStatusTypes.CREATED.index + 1;

      case OrderStatusTypes.PROCESSING:
        return OrderStatusTypes.PROCESSING.index + 1;

      case OrderStatusTypes.INTRANSIT:
        return OrderStatusTypes.INTRANSIT.index + 1;
      case OrderStatusTypes.DELIVERED:
        return OrderStatusTypes.DELIVERED.index + 1;
      case OrderStatusTypes.CANCELLED:
        return OrderStatusTypes.CANCELLED.index + 1;

      default:
        return -1;
    }
  }
}

extension OrderStatusTypesStringValues on OrderStatusTypes {
  String get getStatusStringValues {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return 'NEW ORDER';

      case OrderStatusTypes.PROCESSING:
        return 'UNDER PROCESS';

      case OrderStatusTypes.INTRANSIT:
        return 'SHIPPED';
      case OrderStatusTypes.DELIVERED:
        return 'DELIVERED';
      case OrderStatusTypes.CANCELLED:
        return 'CANCELLED';

      default:
        return 'UNKNOWN';
    }
  }
}

extension OrderStatusTypesGetActualStringValues on OrderStatusTypes {
  String get getStatusRealStringValues {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return 'CREATED';

      case OrderStatusTypes.PROCESSING:
        return 'PROCESSING';
      case OrderStatusTypes.SHIPPED:
        return 'SHIPPED';

      case OrderStatusTypes.INTRANSIT:
        return 'INTRANSIT';
      case OrderStatusTypes.DELIVERED:
        return 'DELIVERED';
      case OrderStatusTypes.CANCELLED:
        return 'CANCELLED';

      default:
        return 'UNKNOWN';
    }
  }
}

extension OrderStatusTypesColorValues on OrderStatusTypes {
  Color get getStatusColors {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return AppColors().placedOrderBg;

      case OrderStatusTypes.PROCESSING:
        return AppColors().processingOrderBg;

      case OrderStatusTypes.INTRANSIT:
        return AppColors().shippedOrderBg;
      case OrderStatusTypes.DELIVERED:
        return AppColors().deliveredOrderBg;
      case OrderStatusTypes.CANCELLED:
        return AppColors().cancelledOrderBg;

      default:
        return Colors.transparent;
    }
  }
}

extension SelectedColorExtension on OrderStatusTypes {
  String get name => describeEnum(this);

  Color get displayColor {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return AppColors().placedOrderBg;

      case OrderStatusTypes.PROCESSING:
        return AppColors().processingOrderBg;

      case OrderStatusTypes.INTRANSIT:
        return AppColors().shippedOrderBg;
      case OrderStatusTypes.DELIVERED:
        return AppColors().deliveredOrderBg;
      case OrderStatusTypes.CANCELLED:
        return AppColors().cancelledOrderBg;

      default:
        return Colors.transparent;
    }
  }
}
