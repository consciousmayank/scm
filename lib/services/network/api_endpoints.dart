const LOGIN = "/driver/auth";

const String UPDATE_FCM_ID = '/driver/update/fcmid';
const String GET_APP_VERSION = "/info/get/version";
final GET_BRANDS_LIST_BY_TYPE = (category, pageIndex) =>
    "/api/product/brands?type=$category&page=$pageIndex";

final GET_BRANDS_LIST_CONTAINS_BRAND_TITLE = (brandTitle, pageIndex) =>
    "/api/product/brands?title=$brandTitle&page=$pageIndex";

final GET_CATEGORIES_LIST_BY_BRAND =
    (brand, pageIndex) => "/api/product/brands/$brand/types?page=$pageIndex";

final GET_PRODUCT_LIST_BY_BRAND =
    (brand, pageIndex) => "/api/product/list?brand=$brand&page=$pageIndex";
const String GET_PRODUCT_LIST_BY_TITLE = "/api/product/list";
final GET_PRODUCT_LIST_BY_CATEGORY =
    (category, pageIndex) => "/api/product/list?type=$category&page=$pageIndex";
final GET_PRODUCT_LIST_BY_BRAND_AND_CATEGORY = (brand, category, pageIndex) =>
    "/api/product/list?brand=$brand&type=$category&page=$pageIndex";

const String GET_PRODUCT_SUB_CATEGORIES_LIST = "/api/product/subtypes";

const String GET_PRODUCT_LIST = "/api/product/list";
const String GET_BRAND_LIST = "/api/product/brands";
const String GET_CATEGORIES_LIST = "/api/product/types";

const String GET_BRANDS_FOR_DASHBOARD = "/api/brands";
const String GET_DASHBOARD_FOR_SUPERVISOR_DASHBOARD = "/api/admin/statistics";

const String GET_BAR_CHART_BASED_ON_PRODUCT_STATUSES =
    "/api/admin/statistics/product/chart/bar";
const String GET_CREATED_PRODUCTS_BY_USER_TYPE =
    "/api/admin/statistics/product/created";

/// Supplier's API
final GET_SUPPLIER_PRODUCTS = (supplierId) => '/api/supply/product/list';

final ADD_REMOVE_PRODUCT_BY_ID =
    (productId) => "/api/supply/product/$productId";

final GET_PRODUCT_BY_ID = (productId) => "/api/product/$productId";

final GET_PRODUCT_IMAGE = (imageName) => "/api/admin/image/get/$imageName.jpg";
final GET_ORDER_SUMMARY = (orderId) => "/api/supply/order/$orderId";
final ORDER_INFO = ({required String role}) => "/api/$role/order/info";
final ORDERED_BRANDS = ({required String role}) => "/api/$role/order/brand";
final ORDERED_TYPES = ({required String role}) => "/api/$role/order/type";
final ORDER = ({required String role}) => "/api/$role/order";

const String ORDERS = "/api/supply/order";

const String USER_AUTH = "/api/user/authenticate";
const String UPDATE_PASSWORD = "/api/user/update/password";

const String USER_REGISTER = '/api/user/register';

const String VERIFY_OTP = "/api/user/verification";
const String RESEND_OTP = "/api/user/otp/resend";
const String REFRESH_TOKEN = "/api/user/refreshtoken";

const String SUPPLY_PROFILE = "/api/supply/profile";

//API ENDPOINTS ADDED BY Mayank
//Admin
const String ADD_PRODUCT = "/api/admin/product";
const String GET_ADDED_PRODUCTS = "/api/admin/product";
