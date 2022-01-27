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
  //In App Statuses
  NONE,
  SHIPPED,
  NEW_ORDER,
  UNDER_PROCESS
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
  get title => describeEnum(this);

  String get apiToAppTitles {
    switch (this) {
      case OrderStatusTypes.CREATED:
        return "CREATED";

      case OrderStatusTypes.NEW_ORDER:
        return "NEW ORDER";

      case OrderStatusTypes.PROCESSING:
        return "PROCESSING";
      case OrderStatusTypes.UNDER_PROCESS:
        return "PROCESSING";
      case OrderStatusTypes.INTRANSIT:
        return "INTRANSIT";
      case OrderStatusTypes.SHIPPED:
        return "SHIPPED";
      case OrderStatusTypes.DELIVERED:
        return "DELIVERED";
      case OrderStatusTypes.CANCELLED:
        return "CANCELLED";
      default:
        return "ALL";
    }
  }
}

extension SelectedColorExtension on OrderStatusTypes {
  String get name => describeEnum(this);

  Color get displayColor {
    switch (this) {
      case OrderStatusTypes.CREATED:
      case OrderStatusTypes.NEW_ORDER:
        return AppColors().placedOrderBg;

      case OrderStatusTypes.PROCESSING:
      case OrderStatusTypes.UNDER_PROCESS:
        return AppColors().processingOrderBg;

      case OrderStatusTypes.INTRANSIT:
      case OrderStatusTypes.SHIPPED:
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
