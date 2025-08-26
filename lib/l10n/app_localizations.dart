import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ar.dart';
import 'app_localizations_en.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ar'),
    Locale('en'),
  ];

  /// No description provided for @hello.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get hello;

  /// No description provided for @welcome.
  ///
  /// In en, this message translates to:
  /// **'Welcome to my app'**
  String get welcome;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @signup.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signup;

  /// No description provided for @or.
  ///
  /// In en, this message translates to:
  /// **'Or'**
  String get or;

  /// No description provided for @next.
  ///
  /// In en, this message translates to:
  /// **'Next'**
  String get next;

  /// No description provided for @joinusviaphonenumber.
  ///
  /// In en, this message translates to:
  /// **'Join us via phone number'**
  String get joinusviaphonenumber;

  /// No description provided for @wewilltextacodetoverfiyyournumber.
  ///
  /// In en, this message translates to:
  /// **'We will text a code to verify your number'**
  String get wewilltextacodetoverfiyyournumber;

  /// No description provided for @enterthecode.
  ///
  /// In en, this message translates to:
  /// **'Enter the code'**
  String get enterthecode;

  /// No description provided for @wesentyouacode.
  ///
  /// In en, this message translates to:
  /// **'We sent you a code'**
  String get wesentyouacode;

  /// No description provided for @wesentitto.
  ///
  /// In en, this message translates to:
  /// **'We sent it to'**
  String get wesentitto;

  /// No description provided for @request_code_again_timer.
  ///
  /// In en, this message translates to:
  /// **'You can request code again in {time} s'**
  String request_code_again_timer(Object time);

  /// No description provided for @request_code_again.
  ///
  /// In en, this message translates to:
  /// **'You can request the code again'**
  String get request_code_again;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @resendcode.
  ///
  /// In en, this message translates to:
  /// **'Resend code'**
  String get resendcode;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @confirmpassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmpassword;

  /// No description provided for @location.
  ///
  /// In en, this message translates to:
  /// **'Location'**
  String get location;

  /// No description provided for @gender.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get gender;

  /// No description provided for @male.
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get male;

  /// No description provided for @female.
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get female;

  /// No description provided for @selectahotel.
  ///
  /// In en, this message translates to:
  /// **'Select a Hotel'**
  String get selectahotel;

  /// No description provided for @selectactivity.
  ///
  /// In en, this message translates to:
  /// **'Select Activity'**
  String get selectactivity;

  /// No description provided for @finish.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get finish;

  /// No description provided for @tourismcompany.
  ///
  /// In en, this message translates to:
  /// **'Tourism Company'**
  String get tourismcompany;

  /// No description provided for @flyingcompany.
  ///
  /// In en, this message translates to:
  /// **'Flying Company'**
  String get flyingcompany;

  /// No description provided for @reserveacar.
  ///
  /// In en, this message translates to:
  /// **'Reserve a Car'**
  String get reserveacar;

  /// No description provided for @bookinghotel.
  ///
  /// In en, this message translates to:
  /// **'Booking Hotel'**
  String get bookinghotel;

  /// No description provided for @price.
  ///
  /// In en, this message translates to:
  /// **'Price'**
  String get price;

  /// No description provided for @gold.
  ///
  /// In en, this message translates to:
  /// **'Gold'**
  String get gold;

  /// No description provided for @diamond.
  ///
  /// In en, this message translates to:
  /// **'Diamond'**
  String get diamond;

  /// No description provided for @platinum.
  ///
  /// In en, this message translates to:
  /// **'Platinum'**
  String get platinum;

  /// No description provided for @booknow.
  ///
  /// In en, this message translates to:
  /// **'Book Now'**
  String get booknow;

  /// No description provided for @category.
  ///
  /// In en, this message translates to:
  /// **'Category'**
  String get category;

  /// No description provided for @date.
  ///
  /// In en, this message translates to:
  /// **'Date'**
  String get date;

  /// No description provided for @hotel.
  ///
  /// In en, this message translates to:
  /// **'Hotel'**
  String get hotel;

  /// No description provided for @car.
  ///
  /// In en, this message translates to:
  /// **'Car'**
  String get car;

  /// No description provided for @activities.
  ///
  /// In en, this message translates to:
  /// **'Activities'**
  String get activities;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @info.
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get info;

  /// No description provided for @book.
  ///
  /// In en, this message translates to:
  /// **'Book'**
  String get book;

  /// No description provided for @saved.
  ///
  /// In en, this message translates to:
  /// **'Saved'**
  String get saved;

  /// No description provided for @history.
  ///
  /// In en, this message translates to:
  /// **'History'**
  String get history;

  /// No description provided for @unsave.
  ///
  /// In en, this message translates to:
  /// **'Unsave'**
  String get unsave;

  /// No description provided for @rebook.
  ///
  /// In en, this message translates to:
  /// **'Rebook'**
  String get rebook;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @less.
  ///
  /// In en, this message translates to:
  /// **'Less'**
  String get less;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination '**
  String get destination;

  /// No description provided for @numberofpeople.
  ///
  /// In en, this message translates to:
  /// **'Number of People '**
  String get numberofpeople;

  /// No description provided for @payment.
  ///
  /// In en, this message translates to:
  /// **'Payment'**
  String get payment;

  /// No description provided for @cardnumber.
  ///
  /// In en, this message translates to:
  /// **'Card Number'**
  String get cardnumber;

  /// No description provided for @expiry.
  ///
  /// In en, this message translates to:
  /// **'Expiry'**
  String get expiry;

  /// No description provided for @cvv.
  ///
  /// In en, this message translates to:
  /// **'CVV'**
  String get cvv;

  /// No description provided for @pay.
  ///
  /// In en, this message translates to:
  /// **'Pay'**
  String get pay;

  /// No description provided for @checkout.
  ///
  /// In en, this message translates to:
  /// **'Checkout'**
  String get checkout;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'For'**
  String get duration;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'min'**
  String get min;

  /// No description provided for @selectacar.
  ///
  /// In en, this message translates to:
  /// **'Select a Car'**
  String get selectacar;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @phone.
  ///
  /// In en, this message translates to:
  /// **'Phone'**
  String get phone;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @pleaseselectanactivityfirsttoFinish.
  ///
  /// In en, this message translates to:
  /// **'Please select an activity first to Finish'**
  String get pleaseselectanactivityfirsttoFinish;

  /// No description provided for @customtrip.
  ///
  /// In en, this message translates to:
  /// **'Custom Trip'**
  String get customtrip;

  /// No description provided for @customTripMessage.
  ///
  /// In en, this message translates to:
  /// **'Hello, I would like to inquire about a custom trip.'**
  String get customTripMessage;

  /// No description provided for @cannotOpenWhatsapp.
  ///
  /// In en, this message translates to:
  /// **'Cannot open WhatsApp on this device'**
  String get cannotOpenWhatsapp;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @year.
  ///
  /// In en, this message translates to:
  /// **'Year'**
  String get year;

  /// No description provided for @pleaseEnterYourName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterYourName;

  /// No description provided for @pleaseEnterYourPhoneNumber.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterYourPhoneNumber;

  /// No description provided for @phoneNumberTooShort.
  ///
  /// In en, this message translates to:
  /// **'Phone number is too short'**
  String get phoneNumberTooShort;

  /// No description provided for @pleaseEnterYourEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterYourEmail;

  /// No description provided for @pleaseEnterValidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get pleaseEnterValidEmail;

  /// No description provided for @pleaseEnterYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterYourPassword;

  /// No description provided for @passwordTooShort.
  ///
  /// In en, this message translates to:
  /// **'Password is too short (min 6 characters)'**
  String get passwordTooShort;

  /// No description provided for @pleaseConfirmYourPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmYourPassword;

  /// No description provided for @passwordsDoNotMatch.
  ///
  /// In en, this message translates to:
  /// **'Passwords do not match'**
  String get passwordsDoNotMatch;

  /// No description provided for @atLeast8Chars.
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get atLeast8Chars;

  /// No description provided for @atLeastOneLowercase.
  ///
  /// In en, this message translates to:
  /// **'At least one lowercase letter'**
  String get atLeastOneLowercase;

  /// No description provided for @atLeastOneUppercase.
  ///
  /// In en, this message translates to:
  /// **'At least one uppercase letter'**
  String get atLeastOneUppercase;

  /// No description provided for @atLeastOneDigit.
  ///
  /// In en, this message translates to:
  /// **'At least one digit'**
  String get atLeastOneDigit;

  /// No description provided for @passwordNotStrongEnough.
  ///
  /// In en, this message translates to:
  /// **'Password is not strong enough. Please meet all requirements.'**
  String get passwordNotStrongEnough;

  /// No description provided for @registrationSuccess.
  ///
  /// In en, this message translates to:
  /// **'Registration successful!'**
  String get registrationSuccess;

  /// No description provided for @registrationFailed.
  ///
  /// In en, this message translates to:
  /// **'Registration failed. Please try again.'**
  String get registrationFailed;

  /// No description provided for @unexpectedError.
  ///
  /// In en, this message translates to:
  /// **'An unexpected error occurred. Please try again later.'**
  String get unexpectedError;

  /// No description provided for @loading.
  ///
  /// In en, this message translates to:
  /// **'Loading...'**
  String get loading;

  /// No description provided for @failedToSend.
  ///
  /// In en, this message translates to:
  /// **'Failed to send request.'**
  String get failedToSend;

  /// No description provided for @fly.
  ///
  /// In en, this message translates to:
  /// **'Fly'**
  String get fly;

  /// No description provided for @confirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Confirm Password'**
  String get confirmPassword;

  /// No description provided for @pleaseEnterName.
  ///
  /// In en, this message translates to:
  /// **'Please enter your name'**
  String get pleaseEnterName;

  /// No description provided for @pleaseEnterPhone.
  ///
  /// In en, this message translates to:
  /// **'Please enter your phone number'**
  String get pleaseEnterPhone;

  /// No description provided for @phoneTooShort.
  ///
  /// In en, this message translates to:
  /// **'Phone number is too short'**
  String get phoneTooShort;

  /// No description provided for @pleaseEnterEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter your email'**
  String get pleaseEnterEmail;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid email'**
  String get invalidEmail;

  /// No description provided for @pleaseEnterPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter your password'**
  String get pleaseEnterPassword;

  /// No description provided for @pleaseConfirmPassword.
  ///
  /// In en, this message translates to:
  /// **'Please confirm your password'**
  String get pleaseConfirmPassword;

  /// No description provided for @signUp.
  ///
  /// In en, this message translates to:
  /// **'Sign Up'**
  String get signUp;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Successful ✅'**
  String get success;

  /// No description provided for @ok.
  ///
  /// In en, this message translates to:
  /// **'OK'**
  String get ok;

  /// No description provided for @error.
  ///
  /// In en, this message translates to:
  /// **'Error!'**
  String get error;

  /// No description provided for @passwordNotStrong.
  ///
  /// In en, this message translates to:
  /// **'Password is not strong enough'**
  String get passwordNotStrong;

  /// No description provided for @atLeast6Chars.
  ///
  /// In en, this message translates to:
  /// **'At least 6 characters'**
  String get atLeast6Chars;

  /// No description provided for @atLeastOneLowercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'At least one lowercase letter'**
  String get atLeastOneLowercaseLetter;

  /// No description provided for @atLeastOneUppercaseLetter.
  ///
  /// In en, this message translates to:
  /// **'At least one uppercase letter'**
  String get atLeastOneUppercaseLetter;

  /// No description provided for @atLeastOneSpecialCharacter.
  ///
  /// In en, this message translates to:
  /// **'At least one special character'**
  String get atLeastOneSpecialCharacter;

  /// No description provided for @pleaseEnterPhoneAndPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter phone number and password'**
  String get pleaseEnterPhoneAndPassword;

  /// No description provided for @choose_from_to.
  ///
  /// In en, this message translates to:
  /// **'Choose from {from} to {to}'**
  String choose_from_to(Object from, Object to);

  /// No description provided for @the_period_is.
  ///
  /// In en, this message translates to:
  /// **'The period is: {start} to {end}'**
  String the_period_is(Object end, Object start);

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @totalPriceForStay.
  ///
  /// In en, this message translates to:
  /// **'Total price for stay'**
  String get totalPriceForStay;

  /// No description provided for @continueButton.
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get continueButton;

  /// No description provided for @cancelHotel.
  ///
  /// In en, this message translates to:
  /// **'Cancel Hotel'**
  String get cancelHotel;

  /// No description provided for @cancelActivity.
  ///
  /// In en, this message translates to:
  /// **'Cancel Activity'**
  String get cancelActivity;

  /// No description provided for @cancelCar.
  ///
  /// In en, this message translates to:
  /// **'Cancel car'**
  String get cancelCar;

  /// No description provided for @noDescription.
  ///
  /// In en, this message translates to:
  /// **'No description available'**
  String get noDescription;

  /// No description provided for @wifi.
  ///
  /// In en, this message translates to:
  /// **'WiFi'**
  String get wifi;

  /// No description provided for @parking.
  ///
  /// In en, this message translates to:
  /// **'Parking'**
  String get parking;

  /// No description provided for @pool.
  ///
  /// In en, this message translates to:
  /// **'Pool'**
  String get pool;

  /// No description provided for @gym.
  ///
  /// In en, this message translates to:
  /// **'Gym'**
  String get gym;

  /// No description provided for @spa.
  ///
  /// In en, this message translates to:
  /// **'Spa'**
  String get spa;

  /// No description provided for @restaurant.
  ///
  /// In en, this message translates to:
  /// **'Restaurant'**
  String get restaurant;

  /// No description provided for @roomService.
  ///
  /// In en, this message translates to:
  /// **'Room Service'**
  String get roomService;

  /// No description provided for @petFriendly.
  ///
  /// In en, this message translates to:
  /// **'Pet Friendly'**
  String get petFriendly;

  /// No description provided for @roomType.
  ///
  /// In en, this message translates to:
  /// **'Room Type'**
  String get roomType;

  /// No description provided for @services.
  ///
  /// In en, this message translates to:
  /// **'Services'**
  String get services;

  /// No description provided for @forNight.
  ///
  /// In en, this message translates to:
  /// **'For Night:'**
  String get forNight;

  /// No description provided for @pricePerNight.
  ///
  /// In en, this message translates to:
  /// **'\${price}/night'**
  String pricePerNight(Object price);

  /// No description provided for @totalTrip.
  ///
  /// In en, this message translates to:
  /// **'Total Trip ({nights} nights): \${totalPrice}'**
  String totalTrip(Object nights, Object totalPrice);

  /// No description provided for @tripAvailableFrom.
  ///
  /// In en, this message translates to:
  /// **'Trip available from {date}'**
  String tripAvailableFrom(Object date);

  /// No description provided for @tripAvailableTo.
  ///
  /// In en, this message translates to:
  /// **'To {date}'**
  String tripAvailableTo(Object date);

  /// No description provided for @youChoseFrom.
  ///
  /// In en, this message translates to:
  /// **'You chose from: {date}'**
  String youChoseFrom(Object date);

  /// No description provided for @youChoseTo.
  ///
  /// In en, this message translates to:
  /// **'To: {date}'**
  String youChoseTo(Object date);

  /// No description provided for @userUpdated.
  ///
  /// In en, this message translates to:
  /// **'User updated successfully'**
  String get userUpdated;

  /// No description provided for @aboutus.
  ///
  /// In en, this message translates to:
  /// **'About-Us'**
  String get aboutus;

  /// No description provided for @aboutus1.
  ///
  /// In en, this message translates to:
  /// **'We are a passionate mobile application development agency, specializing in tourism. With'**
  String get aboutus1;

  /// No description provided for @aboutus2.
  ///
  /// In en, this message translates to:
  /// **'20 years of experience '**
  String get aboutus2;

  /// No description provided for @aboutus3.
  ///
  /// In en, this message translates to:
  /// **'in France and Egypt, our company is '**
  String get aboutus3;

  /// No description provided for @aboutus4.
  ///
  /// In en, this message translates to:
  /// **'managed from Belgium. '**
  String get aboutus4;

  /// No description provided for @aboutus5.
  ///
  /// In en, this message translates to:
  /// **'We have designed a unique application to transform the planning and execution of your travels. We work with trusted partners in Egypt and the Gulf countries to guarantee a high-quality service.'**
  String get aboutus5;

  /// No description provided for @abutus6.
  ///
  /// In en, this message translates to:
  /// **'Our app was created to offer a seamless and memorable travel experience. It provides you with a '**
  String get abutus6;

  /// No description provided for @aboutus7.
  ///
  /// In en, this message translates to:
  /// **'carefully selected range of the best hotels, apartments, cars, and airlines.'**
  String get aboutus7;

  /// No description provided for @aboutus8.
  ///
  /// In en, this message translates to:
  /// **'We offer:'**
  String get aboutus8;

  /// No description provided for @aboutus9.
  ///
  /// In en, this message translates to:
  /// **'• Flights and accommodations'**
  String get aboutus9;

  /// No description provided for @aboutus10.
  ///
  /// In en, this message translates to:
  /// **'• Car rentals and on-site activities'**
  String get aboutus10;

  /// No description provided for @aboutus11.
  ///
  /// In en, this message translates to:
  /// **'• High-level support, '**
  String get aboutus11;

  /// No description provided for @aboutus12.
  ///
  /// In en, this message translates to:
  /// **'staff, to ensure a smooth journey at every step of your trip.'**
  String get aboutus12;

  /// No description provided for @aboutus13.
  ///
  /// In en, this message translates to:
  /// **'We are committed to providing you with the best of Egypt. With our expertise and local partners, you are guaranteed an unforgettable adventure, with complete peace of mind.'**
  String get aboutus13;

  /// No description provided for @aboutus14.
  ///
  /// In en, this message translates to:
  /// **'TripTo simplifies your travels and guarantees 24/7 assistance in Arabic and English'**
  String get aboutus14;

  /// No description provided for @favourite.
  ///
  /// In en, this message translates to:
  /// **'Favourite'**
  String get favourite;

  /// No description provided for @sidemenu.
  ///
  /// In en, this message translates to:
  /// **'Side Menu'**
  String get sidemenu;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Logout'**
  String get logout;

  /// No description provided for @deletmyaccount.
  ///
  /// In en, this message translates to:
  /// **'Delete my account'**
  String get deletmyaccount;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['ar', 'en'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ar':
      return AppLocalizationsAr();
    case 'en':
      return AppLocalizationsEn();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
