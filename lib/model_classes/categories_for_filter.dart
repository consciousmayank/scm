/// it is created to make the category list checkable in filter bottom sheet
class CategoriesForFilter {
  CategoriesForFilter({
    required this.categoryName,
    required this.isSelected,
  });

  final String? categoryName;
  bool? isSelected;
}