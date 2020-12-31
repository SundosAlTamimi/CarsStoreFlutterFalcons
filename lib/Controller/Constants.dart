
    class Constants {
        static const Map header = {"Content-Type":"application/x-www-form-urlencoded",
            "Accept":"application/json",
            "Accept-Language": "en"};
        static const baseUrl = "http://10.0.0.175/CarsSale/";
        static const apiUrl = "${Constants.baseUrl}";
    }

    class UserUrl {
        static const userAuthUrl = "${Constants.apiUrl}export.php?";
    }

    class ProductsNewOrder {
        static const getItem  = "${Constants.apiUrl}import.php?FLAG=1";
        static const getItemByBarcode  = "${Constants.apiUrl}export.php";
        static const addVoucher  = "${Constants.apiUrl}export.php";
    }

    class Order{
        static const getOrdersUrl = "${Constants.apiUrl}import.php?FLAG=7&";
        static const getMyOrderDetails = "${Constants.apiUrl}import.php?FLAG=8&";
    }

    class SalesInvoice{
        static const getSalesInvoice = "${Constants.apiUrl}import.php?FLAG=9&";
        static const getSalesInvoiceDetails = "${Constants.apiUrl}import.php?FLAG=10&";
    }

    // class Notification{
    //     static const getNotifications = "${Constants.apiUrl}P_GetNotifications";
    //     static const setNotificationsSeen = "${Constants.apiUrl}P_SetNotificationsSeen";
    // }
    //
    // class log {
    //     static const userSignUp = "${Constants.apiUrl}P_UserSignUp";
    //     static const userSignIn = "${Constants.apiUrl}P_UserSignIn";
    //     static const userSignOut = "${Constants.apiUrl}P_UserSignOut";
    // }
    //
    // class Location {
    //     static const saveUserLocation = "${Constants.apiUrl}P_SaveUserLocation";
    //     static const getUserLocations = "${Constants.apiUrl}P_GetUserLocations";
    //     static const deleteUserLocation = "${Constants.apiUrl}P_DeleteUserLocation";
    //
    // }

