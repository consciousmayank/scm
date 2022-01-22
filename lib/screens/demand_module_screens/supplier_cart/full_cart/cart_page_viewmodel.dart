import 'package:scm/app/di.dart';
import 'package:scm/app/generalised_base_view_model.dart';
import 'package:scm/enums/api_status.dart';
import 'package:scm/enums/dialog_type.dart';
import 'package:scm/model_classes/add_address_model.dart';
import 'package:scm/model_classes/add_address_request.dart';
import 'package:scm/model_classes/api_response.dart';
import 'package:scm/model_classes/cart.dart';
import 'package:scm/model_classes/post_order_request.dart';
import 'package:scm/model_classes/suppliers_list_response.dart';
import 'package:scm/screens/demand_module_screens/supplier_cart/full_cart/cart_page_view.dart';
import 'package:scm/services/app_api_service_classes/address_apis.dart';
import 'package:scm/services/app_api_service_classes/common_dashboard_apis.dart';
import 'package:scm/services/app_api_service_classes/demand_cart_api.dart';
import 'package:scm/utils/strings.dart';
import 'package:scm/widgets/address/address_dialog_box.dart';
import 'package:scm/widgets/product/product_details/product_add_to_cart_dialogbox_view.dart';
import 'package:scm/widgets/product/product_details/product_detail_dialog_box_view.dart';
import 'package:scm/widgets/product/product_list/add_to_cart_helper.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:scm/model_classes/address.dart' as demanders_address;

class CartPageViewModel extends GeneralisedBaseViewModel {
  late AddToCart addToCartObject;
  List<demanders_address.Address> addressList = [];
  Cart cart = Cart().empty();
  ApiStatus cartApiStatus = ApiStatus.LOADING;
  ApiStatus getAddressListApiStatus = ApiStatus.LOADING;
  demanders_address.Address? selectedAddress;
  String? supplierName;

  final AddressApis _addressApis = locator<AddressApis>();
  final CommonDashBoardApis _commonDashBoardApis =
      locator<CommonDashBoardApis>();

  final DemandCartApi _demandCartApi = locator<DemandCartApi>();

  init() {
    supplierName = '';
    getCartItems();
    getDemadersAddressList();
  }

  void getSupplierDetails() async {
    setBusy(true);
    Supplier response = await _commonDashBoardApis.getSupplierDetails(
      supplierId: cart.supplyId!,
    );
    setBusy(false);
    supplierName = response.businessName;
  }

  void getCartItems() async {
    cart = await _demandCartApi.getCart();
    cart.supplyId;
    addToCartObject = AddToCart(
      supplierId: cart.supplyId!,
    );

    if (cart.supplyId != null) {
      getSupplierDetails();
    }
    cartApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  void editCartItemAt({required int index, required CartItem cartItem}) async {
    DialogResponse? editCartItemResponse;

    editCartItemResponse = await dialogService.showCustomDialog(
      variant: DialogType.ADD_PRODUCT_TO_CART,
      data: ProductAddToCartDialogBoxViewArguments.fromCartPage(
        title: cartItem.itemTitle!,
        productId: cartItem.id!,
        supplierId: cart.supplyId,
        quantity: cartItem.itemQuantity,
      ),
    );

    if (editCartItemResponse != null && editCartItemResponse.confirmed) {
      ProductAddToCartDialogBoxViewOutArguments args =
          editCartItemResponse.data;
      addToCartObject
          .updateProductInCart(
        cartItem: cartItem.copyWith(
          itemQuantity: args.quantity,
        ),
      )
          .then((value) {
        if (value != null) {
          cart = value;
          notifyListeners();
        }
      });
    }
  }

  void deleteCartItemAt({
    required CartItem cartItem,
  }) async {
    DialogResponse? deleteCartItemResponse;

    deleteCartItemResponse = await dialogService.showConfirmationDialog(
      title: 'Delete ${cartItem.itemTitle} ?',
      description: 'Are you sure you want to delete this item from your cart?',
      barrierDismissible: true,
      cancelTitle: labelCancel,
      confirmationTitle: labelYes,
      dialogPlatform: DialogPlatform.Material,
    );

    if (deleteCartItemResponse != null && deleteCartItemResponse.confirmed) {
      addToCartObject
          .updateProductInCart(
        cartItem: cartItem.copyWith(
          itemQuantity: 0,
        ),
      )
          .then((value) {
        if (value != null) {
          cart = value;
          notifyListeners();
        }
      });
    }
  }

  void openProductDetails({
    required int productId,
    required String productTitle,
  }) async {
    await dialogService.showCustomDialog(
      variant: DialogType.PRODUCT_DETAILS,
      data: ProductDetailDialogBoxViewArguments(
        // title: product.title ?? '',
        title: productTitle,
        productId: productId, product: null,
      ),
    );
  }

  void getDemadersAddressList() async {
    addressList = await _addressApis.getAddressList();
    // if (addressList.isNotEmpty) {
    //   selectedAddress = addressList.first;
    // }
    getAddressListApiStatus = ApiStatus.FETCHED;
    notifyListeners();
  }

  void setSelectedAddress(
      {required demanders_address.Address selectedAddress}) {
    this.selectedAddress = selectedAddress;
    notifyListeners();
  }

  void addAddress({
    demanders_address.Address? selectedAddress,
  }) async {
    DialogResponse? addNewAddressDialogBoxResponse =
        await dialogService.showCustomDialog(
      variant: DialogType.ADD_ADDRESS,
      data: AddressDialogBoxViewArguments(
        title: 'Add New Address',
        selectedAddress: selectedAddress,
      ),
      barrierDismissible: false,
    );

    if (addNewAddressDialogBoxResponse != null &&
        addNewAddressDialogBoxResponse.confirmed) {
      AddressDialogBoxViewOutArguments arguments =
          addNewAddressDialogBoxResponse.data;

      if (selectedAddress == null) {
        addressList.add(arguments.selectedAddress);
      } else {
        int index = -1;

        for (var element in addressList) {
          if (element.id == selectedAddress.id) {
            index = addressList.indexOf(element);
          }
        }

        if (index != -1) {
          addressList.removeAt(index);
          addressList.add(arguments.selectedAddress);
        }
      }

      AddNewAddressRequest addNewAddressRequest =
          AddNewAddressRequest(address: addressList);
      updateAddress(
        addressRequest: addNewAddressRequest.toJson(),
      );
    }
  }

  void deleteAddress(
      {required demanders_address.Address selectedAddress}) async {
    DialogResponse? deleteAddressDialogBoxResponse =
        await dialogService.showConfirmationDialog(
      barrierDismissible: true,
      cancelTitle: labelCancel,
      confirmationTitle: labelYes,
      description: labelDeleteAddressDescription,
      dialogPlatform: DialogPlatform.Material,
      title: labelDeleteAddress,
    );

    if (deleteAddressDialogBoxResponse != null &&
        deleteAddressDialogBoxResponse.confirmed) {
      addressList.removeAt(addressList.indexOf(selectedAddress));
      AddNewAddressRequest addNewAddressRequest =
          AddNewAddressRequest(address: addressList);

      updateAddress(addressRequest: addNewAddressRequest.toJson());
    }
  }

  updateAddress({
    required String addressRequest,
  }) async {
    ApiResponse apiResponse = await _addressApis.updateAddress(
      addressJsonBody: addressRequest,
    );

    if (apiResponse.isSuccessful()) {
      getDemadersAddressList();
    } else {
      showErrorSnackBar(
        message: apiResponse.message,
      );
    }
  }

  void placeOrder() async {
    ApiResponse apiResponse = await _commonDashBoardApis.placeOrder(
      postOrderRequest: PostOrderRequest(
        billingAddress: selectedAddress!.copyWith(id: null),
        shippingAddress: selectedAddress!.copyWith(id: null),
      ),
    );

    if (apiResponse.isSuccessful()) {
      showInfoSnackBar(message: apiResponse.message);
      navigationService.back();
    } else {
      showErrorSnackBar(message: apiResponse.message);
    }
  }
}
