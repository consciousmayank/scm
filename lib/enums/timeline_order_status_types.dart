///Used to show the statuses of the current user's Order
enum TimeLineOrderStatusTypes {
  PLACED,
  PROCESSING,
  SHIPPED,
  DELIVERED,
  CANCELLED,
}

extension TimeLineOrderStatusTypesIntValues on TimeLineOrderStatusTypes {
  int get getStatusCode {
    switch (this) {
      case TimeLineOrderStatusTypes.PLACED:
        return TimeLineOrderStatusTypes.PLACED.index + 1;

      case TimeLineOrderStatusTypes.PROCESSING:
        return TimeLineOrderStatusTypes.PROCESSING.index + 1;

      case TimeLineOrderStatusTypes.SHIPPED:
        return TimeLineOrderStatusTypes.SHIPPED.index + 1;

      case TimeLineOrderStatusTypes.DELIVERED:
        return TimeLineOrderStatusTypes.DELIVERED.index + 1;

      default:
        return -1;
    }
  }

  String get getName {
    switch (this) {
      case TimeLineOrderStatusTypes.PLACED:
      case TimeLineOrderStatusTypes.SHIPPED:
      case TimeLineOrderStatusTypes.DELIVERED:
      case TimeLineOrderStatusTypes.CANCELLED:
        return name;

      case TimeLineOrderStatusTypes.PROCESSING:
        return 'IN PROCESS';

      default:
        return "";
    }
  }
}
