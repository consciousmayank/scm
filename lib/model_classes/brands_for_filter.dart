/// it is created to make the brand list checkable in filter bottom sheet
class BrandsForFilter {
  BrandsForFilter({
    required this.brandName,
    required this.isSelected,
  });

  final String? brandName;
  bool? isSelected;
}