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
  static const String submit='Submit';
  static const String skipForm='Skip Form & Share Pin Location';
  static const String sharePinLocation='Proceed & Share Location';
  static const String ok='Ok';
  static const String locationSharedMessage='Your location has been shared successfully. Ambulance will arrive shortly.';
  static const String reportFormDesc='Please fill the form below in order to report a death';
  static const String otpError='Please enter OTP';
  static const String generalLocation='Generalized Location';





  // Empty String
  static const String emptyString = '';
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
