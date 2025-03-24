import '/core/core.dart';
import '/common/common.dart';

class LocalString {
  static const String appName = "Code";

  static List<LanguageModel> appLanguages = [
    LanguageModel(
      languageFlag: MyImage.english,
      languageName: 'English',
      countryCode: 'US',
      languageCode: 'en',
    ),
    LanguageModel(
      languageFlag: MyImage.arabic,
      languageName: "العربية",
      countryCode: "SA",
      languageCode: "ar",
    ),
    LanguageModel(
      languageFlag: MyImage.spanish,
      languageName: "Spanish",
      countryCode: "ES",
      languageCode: "es",
    ),
    LanguageModel(
      languageFlag: MyImage.frensh,
      languageName: "French",
      countryCode: "FR",
      languageCode: "fr",
    ),
    LanguageModel(
      languageFlag: MyImage.german,
      languageName: "Deutsch",
      countryCode: "DE",
      languageCode: "de",
    ),
    LanguageModel(
      languageFlag: MyImage.hindi,
      languageName: "Hindi",
      countryCode: "HI",
      languageCode: "hi",
    ),
  ];

   // Onboarding Screens
  static const String onboardTitle1 = "Onboarding one";
  static const String onboardSubTitle1 = "Onboarding One Description";
  static const String onboardTitle2 = "Onboarding Two";
  static const String onboardSubTitle2 = "Onboarding Two Description.";
  static const String onboardTitle3 = "Onboarding Three";
  static const String onboardSubTitle3 = "Onboarding Three Description.";
  static const String skip = "Skip";
  static const String next = "Next";
  static const String getStarted = "Get Started";


  // Login Screen
  static const String password = "Password";
  static const String passwordHint = "Enter password";
  static const String rememberMe = "Remember Me";
  static const String forgotPassword = "Forgot Password?";
  static const String forgotPasswordTitle = "Forgot Password";
  static const String forgotPasswordDesc =
      "Enter your email below to receive a password reset verification code";
  static const String signIn = "Sign In";
  static const String login = "Login";
  static const String loginDesc = "Login to your account";
  // Register Screen
  static const String firstName = "First Name";
  static const String enterFirstName = "Enter first name";
  static const String firstNameHint = "Enter first Name";
  static const String lastName = "Last Name";
  static const String enterLastName = "Enter last name";
  static const String lastNameHint = "Enter last Name";
  static const String country = "Country";
  static const String selectCountry = "Select Country";
  static const String noCountryFound = "No Country Found";
  static const String emailAddress = "Email Address";
  static const String emailAddressHint = "Enter email address";
  static const String companyName = "Company Name";
  static const String enterCompanyName = "Enter Company Name";
  static const String email = "Email";
  static const String enterEmail = "Please, Enter Email Address";
  static RegExp emailValidatorRegExp =
      RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  static const String invalidEmailMsg = "Enter valid email";
  static const String enterYourPassword = "Enter your password";

  // Change Password
  static const String changePassword = "Change Password";
  static const String currentPassword = "Current Password";
  static const String currentPasswordHint = "Enter current password";
  static const String saveNewPassword = "Save New Password";

}
