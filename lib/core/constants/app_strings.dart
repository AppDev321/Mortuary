class AppStrings {
  // Literals for Page Title
  static const String appTitle = 'Mortuary App';
  static const String splashTitle1='Mortuary Management System';
  static const String splashTitle2='Hajj operations 2024';
  static const String username='User Name';
  static const String password='Password';
  static const String forgotPassword = "Forgot Password";
  static const String verification = "Verification";
  static const String verificationLabelMsg = 'Please verify your phone number below. We will send you a 6-digit OTP in order to reset your password';
  static const String verificationScreenLabelMsg = 'Please enter the 6-digit OTP sent to your phone number';

  static const String phoneNumber='Phone Number';
  static const String requestCode = 'Request Code';
  static const String verify = 'Verify';
  static const String login = 'Login';
  static const String update = 'Update';
  static const String updatePassword = 'Update Password';
  static const String updatePasswordScreenLabelMsg = 'Please provide new password in order to update your password';
  static const String newPassword='New Password';
  static const String retypePassword='Re-type New Password';

  static const String reportDeath='Report a death';
  static const String reportDeathLabelMsg='Please click on the button below\n in order to report a death';
  static const String viewLiveMap='View Live Map';
  static const String liveMap='Live Map';
  static const String viewDeathReportList='View List of Death Reports';
  static const String deathReportList='Death Reports List';

  static const String idType='ID Type';
  static const String idNumber='ID Number';
  static const String gender='Gender';
  static const String ageGroup='Age Group';
  static const String onWayToProcess='Ambulance on way to processing centre';
  static const String handedToProcess='Handed over to processing centre';
  static const String pickBodyToProcess='Ambulance on way to pick the body';
  static const String numberOfDeaths='Number of Deaths';
  static const String next='Next';
  static const String scanCode='Scan QR Code';
  static const String scan='Scan';
  static const String submit='submit';
  static const String skipForm='Skip Form & Share Pin Location';
  static const String sharePinLocation='share Pin Location';
  static const String ok='Ok';
  static const String locationSharedMessage='Your location has been shared successfully. Ambulance will arrive shortly.';



  static const String loginViaEmail = 'LOGIN VIA EMAIL';
  static const String loginViaPhone = 'LOGIN VIA PHONE';
  static const String signUpHere = 'Sign up here';
  static const String loginAsGuest = 'Login as a Guest';


  static const String resetFiltersButtonText = 'Reset Filters';
  static const String applyFiltersButtonText = 'Apply Filters';
  // Empty String
  static const String emptyString = '';




  static RegExp get emailRegExp => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp get priceRegExp => RegExp(r'^\d+\.?\d*');

  // Info/Error Messages
  static const String successTitle = 'Success';
  static const String stockValidatedText = 'Stock Transfer Validated';
  static const String productNotFoundTitle = 'Product Not Found';
  static const String productNotFoundMessage =
      'This Product is Not Available in the Warehouse.';

  // App literals for [CustomError]
  static const String defaultClientErrorTitle = 'Client Authentication Error';
  static const String defaultClientErrorMessage =
      'Some error occurred in client Authentication, try later.';

  static const String defaultAuthenticationErrorTitle = 'Authentication Error';
  static const String defaultAuthenticationErrorMessage =
      'Your email and password did not match.';

  static const String defaultNotFoundErrorTitle = 'Not Found';
  static const String defaultNotFoundErrorMessage =
      'The requested item was not found.';

  static const String defaultNetworkErrorTitle = 'Network Error';
  static const String defaultNetworkErrorMessage =
      'Unable to connect to internet.';

  static const String defaultGeneralErrorTitle = 'Problem Occurred';
  static const String defaultGeneralErrorMessage =
      'Unable to process your request, try again, or contact customer support.';

  //literals for text widget
  static const String demandText = 'Demand';
  static const String receivedText = 'Received';
  static const String demandQtyText = 'Demand Quantity';
  static const String doneText = 'Done';
  static const String doneQtyText = 'Done Quantity';
  static const String reservedText = 'Reserved';
  static const String dispatcherText = 'Dispatcher';
  static const String destinationText = 'Destination';
  static const String addressText = 'Address';
  static const String titleText = 'Title';
  static const String messageText = 'Message';
  static const String yesText = 'Yes';
  static const String noText = 'No';
  static const String backOrderButtonText = 'Create Back Order';
  static const String noBackOrderButtonText = 'No Back Order';
  static const String okButtonText = 'OK';
  static const String applyButtonText = 'Apply';
  static const String cancelButtonText = 'Cancel';
  static const String termsAndConditions =
      'This section outlines that by using the app, the user agrees to the terms and conditions. This section describes the rules around creating an account, including age restrictions and the requirement for accurate personal information.This section explains the rules around product listings, including prohibited items and requirements for accurate product descriptions.This section outlines the rules around payment processing, including fees, refund policies, and chargeback policies.This section explains the rules around shipping and delivery, including delivery timelines and shipping costs. This section outlines the rules around intellectual property, including copyright infringement and trademarks.';

  // Cart Microcopy
  static const String titleCart = "Your Cart Awaits";
  static const String descriptionCart =
      "An empty cart is an opportunity for superior cooling. Discover our quality aircon products and services.";

  // Orders Microcopy
  static const String titleOrders = "No Orders Yet!";
  static const String descriptionOrders =
      "Your orders list is empty, but there's plenty to explore. Start adding aircon products and services to your cart to place your first order.";

  // Invoices Microcopy
  static const String titleInvoices = "No Invoices Found";
  static const String descriptionInvoices =
      "Your invoices list is currently empty. Once you make a purchase, your invoices will be displayed here for your records.";

  // Appointments Microcopy
  static const String titleAppointments = "Schedule your Appointment";
  static const String descriptionAppointments =
      "Your appointments list is currently empty. Take the first step in optimizing your indoor climate by booking an appointment with our seasoned experts by tapping the “+” button below.";

  // Reward Points Microcopy
  static const String titleRewardPoints = "Unlock Exciting Rewards";
  static const String descriptionRewardPoints =
      "No points yet, but there's plenty to gain. Earn points with every order and save big on your favorite aircon products and services.";

  // Addresses Microcopy
  static const String titleAddresses = "Add your Delivery Address";
  static const String descriptionAddresses =
      "Your addresses list is currently empty. Ensure smooth and timely deliveries of your products and services by adding your address below by tapping the add button.";

  // Purchased Contracts Microcopy
  static const String titlePurchasedContracts = "No Contracts Found";
  static const String descriptionPurchasedContracts =
      "Your purchased contracts list is empty. Explore our premium service contracts and secure your maintenance today.";

  // Transactions Microcopy
  static const String titleTransactions = "No Transactions Found";
  static const String descriptionTransactions =
      "Your transactions list is currently empty. Once you make a purchase, your transactions will be displayed here for your records.";

  static const String titlePromotions = "Unlock Limited Time Offers";
  static const String descriptionPromotions =
      "There are no promotions at the moment. Keep an eye on this space for upcoming deals on top-notch aircon solutions.";
  static const String titleVouchers = "No Vouchers Available";
  static const String descriptionVouchers =
      "Your vouchers list is currently empty. Stay tuned for upcoming voucher offers and discounts on aircon products and services.";

  // Cards Microcopy
  static const String descriptionCards =
      "Your cards list is currently empty. Click 'Add New' to securely store your preferred payment method for seamless aircon purchases.";

// Action Button Texts
  static const String emptyActionButtonText = "Add Products";
  static const String browseProductsButtonText = "Browse our Products";
  static const String contractsButtonText = "Browse Servicing Contract";

  static const String receiveTimeOutMessage =
      "Looks like the server is taking to long to respond, please try again in sometime";
  static const String connectTimeOutMessage =
      "Looks like you have an unstable network at the moment, please try again when network stabilizes.";


}
