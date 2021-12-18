enum ProductStatuses {
  CREATED,
  PUBLISHED,
  PROCESSED,
}

extension ProductStatusesValues on ProductStatuses {
  int get getStatusCode {
    switch (this) {
      case ProductStatuses.CREATED:
        return ProductStatuses.CREATED.index + 1;

      case ProductStatuses.PUBLISHED:
        return ProductStatuses.PUBLISHED.index + 1;

      case ProductStatuses.PROCESSED:
        return ProductStatuses.PROCESSED.index + 1;

      default:
        return -1;
    }
  }
}

extension ProductStatusesValue on ProductStatuses {
  String get getStatusString {
    switch (this) {
      case ProductStatuses.CREATED:
        return 'CREATED';

      case ProductStatuses.PUBLISHED:
        return 'PUBLISHED';

      case ProductStatuses.PROCESSED:
        return 'PROCESSED';

      default:
        return 'UNKNOWN';
    }
  }
}

extension ProductStatusesFirstWordCapitalisedValue on ProductStatuses {
  String get getStatusFirstWordCapitalisedString {
    switch (this) {
      case ProductStatuses.CREATED:
        return 'Created';

      case ProductStatuses.PUBLISHED:
        return 'Published';

      case ProductStatuses.PROCESSED:
        return 'Processed';

      default:
        return 'Unknown';
    }
  }
}
