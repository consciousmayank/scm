enum OrderFiltersDurationType {
  LAST_30_DAYS,
  LAST_2_MONTHS,
  LAST_3_MONTHS,
  LAST_4_MONTHS,
  LAST_5_MONTHS,
  LAST_6_MONTHS,
  CUSTOM
}

extension OrderFiltersDurationIntValues on OrderFiltersDurationType {
  int get getValue {
    switch (this) {
      case OrderFiltersDurationType.LAST_30_DAYS:
        return 1;

      case OrderFiltersDurationType.LAST_2_MONTHS:
        return 2;

      case OrderFiltersDurationType.LAST_3_MONTHS:
        return 3;

      case OrderFiltersDurationType.LAST_4_MONTHS:
        return 4;

      case OrderFiltersDurationType.LAST_5_MONTHS:
        return 5;

      case OrderFiltersDurationType.LAST_6_MONTHS:
        return 6;
      case OrderFiltersDurationType.CUSTOM:
        return 7;

      default:
        return 0;
    }
  }

  String get getNames {
    switch (this) {
      case OrderFiltersDurationType.LAST_30_DAYS:
        return 'Last 30 days';

      case OrderFiltersDurationType.LAST_2_MONTHS:
        return 'Last 2 months';

      case OrderFiltersDurationType.LAST_3_MONTHS:
        return 'Last 3 months';

      case OrderFiltersDurationType.LAST_4_MONTHS:
        return 'Last 4 months';

      case OrderFiltersDurationType.LAST_5_MONTHS:
        return 'Last 5 months';

      case OrderFiltersDurationType.LAST_6_MONTHS:
        return 'Last 6 months';
      case OrderFiltersDurationType.CUSTOM:
        return 'Custom';

      default:
        return 'Last 30 days';
    }
  }
}
