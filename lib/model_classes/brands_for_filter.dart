/// it is created to make the brand list checkable in filter bottom sheet
class BrandsForFilter {
  BrandsForFilter({
    required this.brandName,
    required this.isSelected,
    required this.count,
  });

  final String? brandName;
  final int count;
  bool? isSelected;
}
