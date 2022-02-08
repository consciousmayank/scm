/// it is created to make the category list checkable in filter bottom sheet
class CategoriesForFilter {
  CategoriesForFilter({
    required this.categoryName,
    required this.isSelected,
    required this.count,
  });

  final String? categoryName;
  final int? count;
  bool? isSelected;
}
