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
  static const String email='Email';
  static const String name='Name';
  static const String contact='Contact';
  static const String phoneNumber='Phone Number';
  static const String requestCode = 'Request Code';
  static const String verify = 'Verify';
  static const String login = 'Login';
  static const String update = 'Update';
  static const String resetPassword = 'Reset Password';
  static const String resetPasswordScreenLabelMsg = 'Please provide new password in order to update your password';
  static const String newPassword='New Password';
  static const String retypePassword='Re-type New Password';

  static const String reportDeath='Report a death';
  static const String reportDeathLabelMsg='Please click on the button below\n in order to report a death';
  static const String viewLiveMap='View Live Map';
  static const String liveMap='Live Map';
  static const String viewDeathReportList='View List of Death Reports';
  static const String deathReportList='Death Reports List';
  static const String driverName = "Driver Name";
  static const String vehicleNo = "Vehicle No";
  static const String capacity = "Capacity";

  static const String detailReport = "Death report Details";
  static const String alertDetail = "Death Alert Details";
  static const String transportDetail = "Transport Details";
  static const String emergencyDetail = "Emergency Department Details";
  static const String morgueDetail = "Morgue Department Details";
  static const String emergencyDepartment = "Emergency Department";
  static const String morgueDepartment = "Morgue Department";
  static const String pocName= "POC Name";
  static const String totalSpace = "Total Space";
  static const String clickToUpload = "Click here to upload";

  static const String policeStation = "Police station";
  static const String policeFormDesc='Please select the police station in order to continue';
  static const String policeRepresentative = "Police Representatives";

  static const String processCenterLoc = 'Processing centre\nlocation';
  static const String pickupMapLoc = 'Pick up location';
  static const String pickupMapLabel = "Please reach the death alert location in order to receive the dead body.";
  static const String spaceAvailabilityCenter='Space Availability in Processing Centre';
  static const String callVolunteer = "Call the Volunteer";
  static const String arrived = "Arrived";
  static const String scanNextBody = "Proceed to scanned next";
  static const String scanSuccess = "Scan Successful";
  static const String scanSuccessMsg = "QR code Scanned successfully";
  static const String select = "Select";
  static const String handOverBody='Hand Over Dead Body';
  static const String success = "Success";



  static const String processingCenter = "Processing centre";
  static const String processingCenterLabel = "Please select a processing centre to drop body";
  static const String availableSpace = "Available Space: ";


  static const String processingDepartment = "Processing Departments";
  static const String cleaningStation = "Cleaning Station";
  static const String autopsyPostMartam = "Autopsy / Post Mortem";
  static const String refrigerator = "Refrigerator";
  static const String cementry = "Cemetery (Local Burial)";
  static const String shipToLocal = "Ship to local country";


  static const String inProcess = "Inprocess";
  static const String completed = "Completed";



  static const String idType='ID Type';
  static const String idNumber='ID Number';
  static const String gender='Gender';
  static const String age='Age';
  static const String ageGroup='Age Group';
  static const String nationality='Nationality';
  static const String deathType='Death Type';
  static const String onWayToProcess='Ambulance on way to processing centre';
  static const String handedToProcess='Handed over to processing centre';
  static const String pickBodyToProcess='Ambulance on way to pick the body';
  static const String numberOfDeaths='Number of Deaths';
  static const String next='Next';
  static const String scanCode='Scan QR Code';
  static const String scan='Scan';
  static const String scanScreenLabel = "Please scan the QR code in order to continue";
  static const String submit='Submit';
  static const String skipForm='Skip Form & Share Pin Location';
  static const String sharePinLocation='Proceed & Share Location';
  static const String ok='Ok';
  static const String locationSharedMessage='Your location has been shared successfully. Ambulance will arrive shortly.';
  static const String reportFormDesc='Please fill the form below in order to report a death';
  static const String otpError='Please enter OTP';
  static const String generalLocation='Generalized Location';
  static const String selectLocation = "Select Location";
  static const String qrNumber = "QR Number";
  static const String selectAgeGroup = "Select Age Group";
  static const String selectVisaType = "Select Visa Type";
  static const String selectPoliceStation = "Select Police Station";
  static const String selectGender = "Select Gender";
  static const String allDeathReportsPosted = "You have complete your Report task";
  static const String deathAlert='Death Alert';
  static const String deathAlertAt='Death Alert at ';
  static const String shareOnlyLatLng='Force Share';
  static const String newDeathAlertTitle = "New death Alert\nreceived";
  static const String newDeathLabelMsg = "Please click on the button below in order to Initiate your journey";
  static const String reportDetail = "Report Details:";
  static const String noOfDeath = "No of deaths";
  static const String date = "Date";
  static const String time = "Time";
  static const String address = "Address";
  static const String documents = "Documents";
  static const String document = "Document";
  static const String documentsLabel = "Please upload the documents mentioned below";
  static const String upload = "Upload";
  static const String uploadDocument = "Upload Document";
  static const String selectImageSource = "Select Image Source";
  static const String camera = "Camera";
  static const String gallery = "Gallery";
  static const String skip = "Skip";
  static const String search = "Search";
  static const String searchCountry = "Search Country";
  static const String chooseCountry = "Choose Country";
  static const String selectType = "Select Type";
  static const String uploadPic = "Upload Picture";
  static const String uploadPicMsgLabel = "Please upload the captured picture in order to confirm handing over the dead body to Burial Company / Courier.";
  static const String download = "Download";


  // Empty String
  static const String emptyString = '';

  static const String logout = "Logout";

  static RegExp get emailRegExp => RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static RegExp get priceRegExp => RegExp(r'^\d+\.?\d*');


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

  static const String defaultGeneralErrorTitle = 'Error';
  static const String defaultGeneralErrorMessage =
      'Unable to process your request, try again, or contact customer support.';

  //literals for text widget
  static const String receivedText = 'Received';
  static const String doneText = 'Done';
  static const String reservedText = 'Reserved';
  static const String destinationText = 'Destination';
  static const String addressText = 'Address';
  static const String titleText = 'Title';
  static const String messageText = 'Message';
  static const String yesText = 'Yes';
  static const String noText = 'No';
  static const String okButtonText = 'OK';
  static const String applyButtonText = 'Apply';
  static const String cancelButtonText = 'Cancel';
  static const String termsAndConditions =
      'This section outlines that by using the app, the user agrees to the terms and conditions. This section describes the rules around creating an account, including age restrictions and the requirement for accurate personal information.This section explains the rules around product listings, including prohibited items and requirements for accurate product descriptions.This section outlines the rules around payment processing, including fees, refund policies, and chargeback policies.This section explains the rules around shipping and delivery, including delivery timelines and shipping costs. This section outlines the rules around intellectual property, including copyright infringement and trademarks.';



  static const String usernameIsRequired = 'Username is required';
  static const String emailIsRequired = 'Email is required';
  static const String invalidEmailAddress = 'Invalid Email Address';
  static const String passwordIsRequired = 'Password is required';
  static const String confirmPasswordIsRequired = 'Confirm Password is required';
  static const String passwordLengthError = 'Min. Password Length is 6';
  static const String passwordDoesNotMatch = 'Password does not match';
  static const String otpFieldIsRequired = 'OTP Field is required';
  static const String dateOfBirthIsRequired = 'Date of birth is required';
  static const String emptyFieldIsRequired = 'This field is required.';
  static const String genderIsRequired = 'Gender is required';
  static const String phoneNumberIsRequired = 'Phone number is required';
  static const String agreeToTermsIsRequired = 'You have to agree to Terms & Conditions';
}
