import 'package:flutter/material.dart';

const String appName = 'Supply Chain Management';
//UI Labels
const String labelLogin = 'Login';
final labelLogin2 = ({required String url}) => 'Login : $url';
final labelBarchart =
    ({required String productStatus}) => '$productStatus Products';
const String labelLoginButton = 'Login';
const String labelCredentials = 'Please enter your credentials';
final labelApiUrl = ({required String apiUrl}) => 'Targetting :: $apiUrl';
const String labelUserName = 'Username';
const String labelPassword = 'Password';
const String addProductPageTitle = 'Add Product';
const String updateProductPageTitle = 'Update Product';
const String supervisorHomePageTitle = 'Dashboard';
const String dailyEntriesTitle = 'Daily Work Summary';
const String addProductPageSubTitle = 'Use Enter to move to next field';
const String productsListPageTitle = 'Product List';
const String todoProductsListPageTitle = 'Todo Product List';
const String publishedProductsListPageTitle = 'Published Product List';
const String addBrandPageTitle = 'Add Brand';
const String brandTitleHintText = 'Add Brand Title';
const String labelBrands = 'Brand';
const String labelAddBrand = 'Add Brand';
const String labelViewProducts = 'View Products';
const String labelDashboard = 'Home';
const String labelAddProducts = 'Add Products';
const String labelAddBrandImages = 'Add Brand Images';
const String labelType = 'Type';
const String labelSubType = 'Sub-Type';
const String labelPrice = 'Price';
const String labelMeasurement = 'Measurement';
const String labelMeasurementUnit = 'Measurement Unit';
const String labelTitle = 'Title';
const String labelTags = 'Tags (Max length 120)';
const String labelDataUrl = 'Data URL';
const String labelSummary = 'Summary (Max length 400, including Link)';
const String labelGetProductById = 'Get Product by Id';
const String labelLogout = 'Logout';
const String labelSummaryHelperText =
    'Please add the Data Url at the end of the summary';
const String productBrandRequiredErrorMessage = 'Product brand is required';
const String productTypeRequiredErrorMessage = 'Product type is required';
const String brandTitleRequiredErrorMessage = 'Brand title is required';
const String productSubTypeRequiredErrorMessage =
    'Product sub-type is required';
const String productPriceRequiredErrorMessage = 'Product price is required';
const String productImageRequiredErrorMessage = 'Product image is required';
const String productMeasurementRequiredErrorMessage =
    'Product measurement is required';
const String productMeasurementUnitRequiredErrorMessage =
    'Product measurement unit is required';
const String productTitleRequiredErrorMessage = 'Product title is required';
const String productTagsRequiredErrorMessage = 'Product tags are required';
const String productTagsLengthErrorMessage =
    'Product tags chould be more than 15 in length';
const String productSummaryRequiredErrorMessage = 'Product summary is required';

//UI Button labels

//Error Strings
const String errorUserNameRequired = "Username is required";
const String errorPasswordRequired = "Password is required";
const String errorUserNameLength = "Username must be at least 6 characters";
const String errorPasswordLength = "password must be at least 4 characters";
const String errorUploadedImageSize = 'Image size should be less than 50kb';
const String errorNotAuthorisedToEditProducts =
    'You are not authorized to edit products';
const String errorCurrentPasswordRequired = "Current Password is required";
const String errorNewPasswordRequired = "New Password is required";
const String errorPasswordsDontMatch = "Passwords don't match";
const String errorConfirmPasswordRequired =
    "You have to confirm the new password";

const String brandDialogTitle = 'Choose a Brand';
const String brandDialogSearchTitle = 'Search for a Brand';
const String labelAddImage = 'Add Image';
const String labelEnterProductId = 'Enter Product Id';
const String labelEnterValidProductId =
    'Please enter a valid product id in the search box';
const String buttonLabelAddProduct = 'Add Product';
const String buttonLabelUpdateProduct = 'Update Product';
const String base64ImagePrefix = 'data:image/jpeg;base64,';
const String popUpMenuLabelLogout = 'Logout';
const String popUpMenuLabelChangePassword = 'Change Password';
const String popUpMenuLabelToolTip = 'Show Profile Options';
const String labelChangePassword = 'Change Password';
const String labelChangePasswordOldPassword = 'Current Password';
const String labelChangePasswordNewPassword = 'New Password';
const String labelChangePasswordConfirmPassword = 'Confirm Password';
const List<String> profileOptions = [
  'Change Password',
  'Logout',
];

const String labelSupplyLandingPageCatalog = 'Home';
const String labelSupplyLandingPageProduct = 'Products';
const String labelSupplyLandingPageCategories = 'Categories';
const String labelSupplyLandingPageOrder = 'Order';
const String labelSupplyLandingPageMore = 'More';

const String labelDemandLandingPageCatalog = 'Home';
const String labelDemandLandingPageCategories = 'Categories';
const String labelDemandLandingPageSuppliers = 'Suppliers';
const String labelDemandLandingPageOrder = 'Order';
const String labelDemandLandingPageMore = 'More';

const String labelPopularBrands = 'Popular Brands';
const String lableproductdetails = 'Product Details';
const String labelSearchBrands = 'Search Brands';
const String labelSearchCategory = 'Search Categories';
const String labelSearchSubCategory = 'Search Sub-Categories';
const String labelSearchProducts = 'Search Products';
const String labelSearchAllProducts = 'Search All Products';
const String labelRecentOrders = 'RECENT ORDERS';
const String labelOrders = 'ORDERS LIST';
const String labelOrderDetail = 'ORDER DETAILS';
const String labelAppFooterTitle = 'Product Of Geek Technotonic @2021';
const String labelAppFooterSubTitle1 = 'Terms and Conditions';
const String labelAppFooterSubTitle2 = 'Privacy Policy';
const String labelAppFooterSubTitle3 = 'Cookies Policy';
const String labelShippingAddress = 'Shipping Address';
const String labelBillingAddress = 'Billing Address';
const String labelProductItems = 'Order Items';
const String labelOrderSummary = 'Summary';
const String errorQuantityRequired = 'Quantity is required. Cannot be left 0';
const String errorPriceRequired = 'Price is required. Cannot be left 0';

const String orderStatusProcessing = 'PROCESSING';
const String orderStatusCreated = 'PROCESSING';
const String orderStatusInTransit = 'INTRANSIT';
const String orderStatusInDelivered = 'DELIVERED';
const String orderStatusInCancelled = 'CANCELLED';
