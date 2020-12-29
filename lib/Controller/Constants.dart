
    class Constants {
        static const Map header = {"Content-Type":"application/x-www-form-urlencoded",
            "Accept":"application/json",
            "Accept-Language": "en"};
        static const baseUrl = "http://10.0.0.175/CarsSale/";
        static const apiUrl = "${Constants.baseUrl}";
    }

    class HomeConstant {
    }

    class UserUrl {
        static const userAuthUrl = "${Constants.apiUrl}export.php?";
    }

    class ProductsNewOrder {
        static const getItem  = "${Constants.apiUrl}import.php?FLAG=1";
        static const getItemByBarcode  = "${Constants.apiUrl}export.php";
        static const addVoucher  = "${Constants.apiUrl}export.php";
    }

    class items {
    static const rateProductUrl = "${Constants.apiUrl}product/productreviewsadd/";
    static const productDetails = "${Constants.apiUrl}productdetails";
    static const favListUrl = "${Constants.apiUrl}shoppingCart/wishlist";
    static const removeFavUrl = "${Constants.apiUrl}ShoppingCart/UpdateWishlist";
    }

    class Cart{
        static const addToCart = "${Constants.apiUrl}P_AddToCart";
        static const removeFromCart = "${Constants.apiUrl}P_RemoveFromCart";
        static const getMyCart = "${Constants.apiUrl}P_GetMyCart";
        static const deleteProduct = "${Constants.apiUrl}P_DeleteProduct";
        static const confirmCart = "${Constants.apiUrl}P_ConfirmCart";
        static const emptyTheCart = "${Constants.apiUrl}P_EmptyTheCart";
        static const applyLoyaltyPoint = "${Constants.apiUrl}P_ApplyLoyaltyPoint";
        static const applyCoupon = "${Constants.apiUrl}P_ApplyCoupon";
        static const getMyOrderInfo = "${Constants.apiUrl}P_GetMyOrderInfo";
    }

    class Order{
        static const getOrdersUrl = "${Constants.apiUrl}P_GetMyOrders";
        static const getMyOrderDetails = "${Constants.apiUrl}P_GetMyOrderDetails";
    }

    class Notification{
        static const getNotifications = "${Constants.apiUrl}P_GetNotifications";
        static const setNotificationsSeen = "${Constants.apiUrl}P_SetNotificationsSeen";
    }

    class log {
        static const userSignUp = "${Constants.apiUrl}P_UserSignUp";
        static const userSignIn = "${Constants.apiUrl}P_UserSignIn";
        static const userSignOut = "${Constants.apiUrl}P_UserSignOut";
    }

    class Location {
        static const saveUserLocation = "${Constants.apiUrl}P_SaveUserLocation";
        static const getUserLocations = "${Constants.apiUrl}P_GetUserLocations";
        static const deleteUserLocation = "${Constants.apiUrl}P_DeleteUserLocation";

    }

