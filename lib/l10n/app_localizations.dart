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
  /// **'Cancel hotel'**
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

  /// No description provided for @cancellation1.
  ///
  /// In en, this message translates to:
  /// **'Cancellation and Refund Policy'**
  String get cancellation1;

  /// No description provided for @cancellation2.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction and Scope of Policy'**
  String get cancellation2;

  /// No description provided for @cancellation3.
  ///
  /// In en, this message translates to:
  /// **'Welcome to [TripTo]. We strive to provide a transparent and fair booking experience. This policy \'the Policy\' explains the terms and conditions related to cancellations and refunds for services booked through our application, which include but are not limited to: flight bookings, hotel accommodations, holiday packages, tours, and recreational activities \'the Services\'.'**
  String get cancellation3;

  /// No description provided for @cancellation4.
  ///
  /// In en, this message translates to:
  /// **'Completing a booking through [Tripto] signifies your agreement to this Policy and to the terms and conditions of the end-service provider (e.g., the airline, hotel, or tour operator).'**
  String get cancellation4;

  /// No description provided for @cancellation5.
  ///
  /// In en, this message translates to:
  /// **'2. Cancellation and Refund Policy'**
  String get cancellation5;

  /// No description provided for @cancellation6.
  ///
  /// In en, this message translates to:
  /// **'The cancellation and refund policy is primarily subject to the terms set by the end-service provider. [TripTo] acts as an intermediary, and we will clearly display the specific cancellation terms for each booking during the reservation process and before you complete the payment.'**
  String get cancellation6;

  /// No description provided for @cancellation7.
  ///
  /// In en, this message translates to:
  /// **'2.1. Flight Bookings'**
  String get cancellation7;

  /// No description provided for @cancellation8.
  ///
  /// In en, this message translates to:
  /// **'•  Non-refundable Tickets: '**
  String get cancellation8;

  /// No description provided for @cancellation9.
  ///
  /// In en, this message translates to:
  /// **'Most airline tickets, especially promotional and economy fares, are non-refundable. If the traveler cancels the booking, no part of the payment may be refunded.'**
  String get cancellation9;

  /// No description provided for @cancellation10.
  ///
  /// In en, this message translates to:
  /// **'•  Refundable Tickets: '**
  String get cancellation10;

  /// No description provided for @cancellation11.
  ///
  /// In en, this message translates to:
  /// **'Some ticket categories may allow for refunds, but a \'cancellation fee\' set by the airline will often be applied. The refunded amount will be the total amount paid minus this fee.'**
  String get cancellation11;

  /// No description provided for @cancellation12.
  ///
  /// In en, this message translates to:
  /// **'•  Cancellation by the Airline: '**
  String get cancellation12;

  /// No description provided for @cancellation13.
  ///
  /// In en, this message translates to:
  /// **'If a flight is canceled by the airline, the customer is entitled to a full refund or an alternative booking, in accordance with the airline\'s policy and the governing Egyptian law.'**
  String get cancellation13;

  /// No description provided for @cancellation14.
  ///
  /// In en, this message translates to:
  /// **'•  Modifications: '**
  String get cancellation14;

  /// No description provided for @cancellation15.
  ///
  /// In en, this message translates to:
  /// **'Any changes to a booking (such as date changes) are subject to fees determined by the airline in addition to any price difference.'**
  String get cancellation15;

  /// No description provided for @cancellation16.
  ///
  /// In en, this message translates to:
  /// **'2.2. Hotel and Accommodation Bookings'**
  String get cancellation16;

  /// No description provided for @cancellation17.
  ///
  /// In en, this message translates to:
  /// **'•  Each hotel has its own cancellation policy, which will be clearly displayed during the booking process.'**
  String get cancellation17;

  /// No description provided for @cancellation18.
  ///
  /// In en, this message translates to:
  /// **'•  Free Cancellation:'**
  String get cancellation18;

  /// No description provided for @cancellation19.
  ///
  /// In en, this message translates to:
  /// **'Many hotels offer a free cancellation period (for example, up to 48 hours before the check-in date). If the cancellation is made within this period, the customer is entitled to a full refund'**
  String get cancellation19;

  /// No description provided for @cancellation20.
  ///
  /// In en, this message translates to:
  /// **'•  Cancellation Fees: '**
  String get cancellation20;

  /// No description provided for @cancellation21.
  ///
  /// In en, this message translates to:
  /// **'After the free cancellation period expires, the hotel may impose a cancellation fee, which could be equivalent to the cost of the first night or the entire booking value'**
  String get cancellation21;

  /// No description provided for @cancellation22.
  ///
  /// In en, this message translates to:
  /// **'•  No-Show: '**
  String get cancellation22;

  /// No description provided for @cancellation23.
  ///
  /// In en, this message translates to:
  /// **'Any changes to a booking (such as date changes) are subject to fees determined by the airline in addition to any price difference.'**
  String get cancellation23;

  /// No description provided for @cancellation24.
  ///
  /// In en, this message translates to:
  /// **'2.3. Holiday Packages, Tours, and Activities'**
  String get cancellation24;

  /// No description provided for @cancellation25.
  ///
  /// In en, this message translates to:
  /// **'•  Packages and tours are subject to the specific cancellation policy of the tour operator.'**
  String get cancellation25;

  /// No description provided for @cancellation26.
  ///
  /// In en, this message translates to:
  /// **'•  Cancellation fees are often tiered; the closer the cancellation date is to the start date of the trip, the higher the fee. For example:'**
  String get cancellation26;

  /// No description provided for @cancellation27.
  ///
  /// In en, this message translates to:
  /// **'o  Cancellation more than 30 days prior: 25% deduction from the package price.'**
  String get cancellation27;

  /// No description provided for @cancellation28.
  ///
  /// In en, this message translates to:
  /// **'o  Cancellation between 15 and 29 days prior: 50% deduction from the package price.'**
  String get cancellation28;

  /// No description provided for @cancellation29.
  ///
  /// In en, this message translates to:
  /// **'o  Cancellation less than 15 days prior: 100% deduction from the package price.'**
  String get cancellation29;

  /// No description provided for @cancellation30.
  ///
  /// In en, this message translates to:
  /// **'o  The specific cancellation fee schedule for each package will be clarified before the booking is confirmed.'**
  String get cancellation30;

  /// No description provided for @cancellation31.
  ///
  /// In en, this message translates to:
  /// **'3. Cancellation Request Procedure'**
  String get cancellation31;

  /// No description provided for @cancellation32.
  ///
  /// In en, this message translates to:
  /// **'•  All cancellation requests must be submitted through your personal account in the [Trip To] application.'**
  String get cancellation32;

  /// No description provided for @cancellation33.
  ///
  /// In en, this message translates to:
  /// **'•  You can find the cancellation option within the booking details under the \'My Bookings\' section.'**
  String get cancellation33;

  /// No description provided for @cancellation34.
  ///
  /// In en, this message translates to:
  /// **'•  The date and time we receive the cancellation request will be the basis for applying the cancellation terms.'**
  String get cancellation34;

  /// No description provided for @cancellation35.
  ///
  /// In en, this message translates to:
  /// **'•  For assistance, you can contact our customer service team via [Support Email] or [Support Phone Number].'**
  String get cancellation35;

  /// No description provided for @cancellation36.
  ///
  /// In en, this message translates to:
  /// **'4. Refund Processing'**
  String get cancellation36;

  /// No description provided for @cancellation37.
  ///
  /// In en, this message translates to:
  /// **'•  Once the refund request is approved by the service provider, we will process the amount.'**
  String get cancellation37;

  /// No description provided for @cancellation38.
  ///
  /// In en, this message translates to:
  /// **'•  Refunds will be issued to the '**
  String get cancellation38;

  /// No description provided for @cancellation39.
  ///
  /// In en, this message translates to:
  /// **'original payment method '**
  String get cancellation39;

  /// No description provided for @cancellation40.
  ///
  /// In en, this message translates to:
  /// **'used for the booking. '**
  String get cancellation40;

  /// No description provided for @cancellation41.
  ///
  /// In en, this message translates to:
  /// **'•  The refund process may take from  '**
  String get cancellation41;

  /// No description provided for @cancellation42.
  ///
  /// In en, this message translates to:
  /// **'7 to 21 business days '**
  String get cancellation42;

  /// No description provided for @cancellation43.
  ///
  /// In en, this message translates to:
  /// **'to appear in your bank account or on your credit card statement, depending on the policies of the respective bank'**
  String get cancellation43;

  /// No description provided for @cancellation44.
  ///
  /// In en, this message translates to:
  /// **'•  The service/booking fees for the [Trip] application (if any) are administrative fees and are non-refundable, except in cases of cancellation by the service provider.'**
  String get cancellation44;

  /// No description provided for @cancellation45.
  ///
  /// In en, this message translates to:
  /// **'5. Force Majeure'**
  String get cancellation45;

  /// No description provided for @cancellation46.
  ///
  /// In en, this message translates to:
  /// **'In cases of force majeure events beyond the control of any party (such as natural disasters, pandemics, wars, sudden government decisions) that prevent the service from being rendered, we will adhere to the policies set by the end-service providers and Egyptian law. We will do our utmost to assist our customers in finding the best possible solutions, which may include refunds or vouchers for future use.'**
  String get cancellation46;

  /// No description provided for @cancellation47.
  ///
  /// In en, this message translates to:
  /// **'6. Governing Law'**
  String get cancellation47;

  /// No description provided for @cancellation48.
  ///
  /// In en, this message translates to:
  /// **'This Policy shall be governed and construed in accordance with the laws of the Arab Republic of Egypt, particularly the Consumer Protection Law. In the event of any dispute, the competent Egyptian courts shall have exclusive jurisdiction.'**
  String get cancellation48;

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

  /// No description provided for @single.
  ///
  /// In en, this message translates to:
  /// **'Single'**
  String get single;

  /// No description provided for @double.
  ///
  /// In en, this message translates to:
  /// **'Double'**
  String get double;

  /// No description provided for @triple.
  ///
  /// In en, this message translates to:
  /// **'Triple'**
  String get triple;

  /// No description provided for @quad.
  ///
  /// In en, this message translates to:
  /// **'Quad'**
  String get quad;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @privacypolicy.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy'**
  String get privacypolicy;

  /// No description provided for @privacypolicy1.
  ///
  /// In en, this message translates to:
  /// **'Privacy policy for [Trip To]'**
  String get privacypolicy1;

  /// No description provided for @introduction.
  ///
  /// In en, this message translates to:
  /// **'1. Introduction'**
  String get introduction;

  /// No description provided for @privacypolicy2.
  ///
  /// In en, this message translates to:
  /// **'At [TripTo], we are committed to protecting the privacy of our users. This Privacy Policy explains how we collect, use, share, and safeguard your personal information when you use our application and related services.'**
  String get privacypolicy2;

  /// No description provided for @privacypolicy3.
  ///
  /// In en, this message translates to:
  /// **'By accessing or using the TripTo application, you consent to the practices described in this Privacy Policy.'**
  String get privacypolicy3;

  /// No description provided for @privacypolicy4.
  ///
  /// In en, this message translates to:
  /// **'2. Information We Collect'**
  String get privacypolicy4;

  /// No description provided for @privacypolicy5.
  ///
  /// In en, this message translates to:
  /// **'Information You Provide Directly:'**
  String get privacypolicy5;

  /// No description provided for @privacypolicy6.
  ///
  /// In en, this message translates to:
  /// **'Payment details (credit/debit cards, e-wallets)'**
  String get privacypolicy6;

  /// No description provided for @privacypolicy7.
  ///
  /// In en, this message translates to:
  /// **' Phone number'**
  String get privacypolicy7;

  /// No description provided for @privacypolicy8.
  ///
  /// In en, this message translates to:
  /// **' Passport or ID information when required for travel bookings'**
  String get privacypolicy8;

  /// No description provided for @privacypolicy9.
  ///
  /// In en, this message translates to:
  /// **' Information Collected Automatically:'**
  String get privacypolicy9;

  /// No description provided for @privacypolicy10.
  ///
  /// In en, this message translates to:
  /// **'Device information (model, operating system, unique identifiers) '**
  String get privacypolicy10;

  /// No description provided for @privacypolicy11.
  ///
  /// In en, this message translates to:
  /// **'IP address'**
  String get privacypolicy11;

  /// No description provided for @privacypolicy12.
  ///
  /// In en, this message translates to:
  /// **'Location data (if permitted by the user)'**
  String get privacypolicy12;

  /// No description provided for @privacypolicy13.
  ///
  /// In en, this message translates to:
  /// **'Usage data (search history, booking history, interactions within the App)'**
  String get privacypolicy13;

  /// No description provided for @privacypolicy14.
  ///
  /// In en, this message translates to:
  /// **'3. How We Use Your Information '**
  String get privacypolicy14;

  /// No description provided for @privacypolicy15.
  ///
  /// In en, this message translates to:
  /// **'We use the information we collect for purposes including, but not limited to: '**
  String get privacypolicy15;

  /// No description provided for @privacypolicy16.
  ///
  /// In en, this message translates to:
  /// **'Processing bookings and payments. '**
  String get privacypolicy16;

  /// No description provided for @privacypolicy17.
  ///
  /// In en, this message translates to:
  /// **'Sending booking confirmations and important notifications.'**
  String get privacypolicy17;

  /// No description provided for @privacypolicy18.
  ///
  /// In en, this message translates to:
  /// **'Providing customer support and technical assistance.'**
  String get privacypolicy18;

  /// No description provided for @privacypolicy19.
  ///
  /// In en, this message translates to:
  /// **'Improving and personalizing the user experience.'**
  String get privacypolicy19;

  /// No description provided for @privacypolicy20.
  ///
  /// In en, this message translates to:
  /// **'Sending promotional offers or marketing communications (with your consent). '**
  String get privacypolicy20;

  /// No description provided for @privacypolicy21.
  ///
  /// In en, this message translates to:
  /// **'Complying with applicable legal and regulatory requirements.'**
  String get privacypolicy21;

  /// No description provided for @privacypolicy22.
  ///
  /// In en, this message translates to:
  /// **'4. Sharing of Information'**
  String get privacypolicy22;

  /// No description provided for @privacypolicy23.
  ///
  /// In en, this message translates to:
  /// **'We may share your data in the following circumstances:'**
  String get privacypolicy23;

  /// No description provided for @privacypolicy24.
  ///
  /// In en, this message translates to:
  /// **'With service providers (e.g., airlines, hotels, tour operators) to complete your booking. '**
  String get privacypolicy24;

  /// No description provided for @privacypolicy25.
  ///
  /// In en, this message translates to:
  /// **'With payment processors to facilitate secure transactions.'**
  String get privacypolicy25;

  /// No description provided for @privacypolicy26.
  ///
  /// In en, this message translates to:
  /// **'With legal or regulatory authorities if required by law.'**
  String get privacypolicy26;

  /// No description provided for @privacypolicy27.
  ///
  /// In en, this message translates to:
  /// **'With business partners in joint marketing campaigns (only with your prior consent).'**
  String get privacypolicy27;

  /// No description provided for @privacypolicy28.
  ///
  /// In en, this message translates to:
  /// **'We do not sell or rent your personal information to third parties.'**
  String get privacypolicy28;

  /// No description provided for @privacypolicy29.
  ///
  /// In en, this message translates to:
  /// **'5. Data Security'**
  String get privacypolicy29;

  /// No description provided for @privacypolicy30.
  ///
  /// In en, this message translates to:
  /// **'We implement industry-standard security measures, including encryption, to protect your data.'**
  String get privacypolicy30;

  /// No description provided for @privacypolicy31.
  ///
  /// In en, this message translates to:
  /// **'Access to personal information is restricted to authorized employees only.'**
  String get privacypolicy31;

  /// No description provided for @privacypolicy32.
  ///
  /// In en, this message translates to:
  /// **'However, no method of transmission over the internet is 100% secure, and we cannot guarantee absolute protection.'**
  String get privacypolicy32;

  /// No description provided for @privacypolicy33.
  ///
  /// In en, this message translates to:
  /// **'6. Cookies and Tracking Technologies'**
  String get privacypolicy33;

  /// No description provided for @privacypolicy34.
  ///
  /// In en, this message translates to:
  /// **'Our application may use cookies or similar technologies to:'**
  String get privacypolicy34;

  /// No description provided for @privacypolicy35.
  ///
  /// In en, this message translates to:
  /// **'Remember user preferences and settings.'**
  String get privacypolicy35;

  /// No description provided for @privacypolicy36.
  ///
  /// In en, this message translates to:
  /// **'Analyze usage patterns and improve service quality.'**
  String get privacypolicy36;

  /// No description provided for @privacypolicy37.
  ///
  /// In en, this message translates to:
  /// **'Provide relevant offers and promotions.'**
  String get privacypolicy37;

  /// No description provided for @privacypolicy38.
  ///
  /// In en, this message translates to:
  /// **'You may adjust your device settings to refuse or limit cookies.'**
  String get privacypolicy38;

  /// No description provided for @privacypolicy39.
  ///
  /// In en, this message translates to:
  /// **'7. User Rights'**
  String get privacypolicy39;

  /// No description provided for @privacypolicy40.
  ///
  /// In en, this message translates to:
  /// **'In line with the Egyptian Consumer Protection Law and applicable regulations, you have the right to:'**
  String get privacypolicy40;

  /// No description provided for @privacypolicy41.
  ///
  /// In en, this message translates to:
  /// **'Request access to your personal data.'**
  String get privacypolicy41;

  /// No description provided for @privacypolicy42.
  ///
  /// In en, this message translates to:
  /// **'Request corrections of inaccurate or incomplete data.'**
  String get privacypolicy42;

  /// No description provided for @privacypolicy43.
  ///
  /// In en, this message translates to:
  /// **'Request deletion of your data, except where retention is required by law.'**
  String get privacypolicy43;

  /// No description provided for @privacypolicy44.
  ///
  /// In en, this message translates to:
  /// **'Opt-out of marketing communications at any time.'**
  String get privacypolicy44;

  /// No description provided for @privacypolicy45.
  ///
  /// In en, this message translates to:
  /// **'8. Data Retention'**
  String get privacypolicy45;

  /// No description provided for @privacypolicy46.
  ///
  /// In en, this message translates to:
  /// **'We retain your personal information as long as your account is active or as necessary to provide services.'**
  String get privacypolicy46;

  /// No description provided for @privacypolicy47.
  ///
  /// In en, this message translates to:
  /// **'Some data may be retained longer to comply with legal obligations, resolve disputes, or enforce agreements.'**
  String get privacypolicy47;

  /// No description provided for @privacypolicy48.
  ///
  /// In en, this message translates to:
  /// **'9. Third-Party Links'**
  String get privacypolicy48;

  /// No description provided for @privacypolicy49.
  ///
  /// In en, this message translates to:
  /// **'The App may contain links to third-party websites or applications. TripTo is not responsible for the privacy practices or content of those external services.'**
  String get privacypolicy49;

  /// No description provided for @privacypolicy50.
  ///
  /// In en, this message translates to:
  /// **'10. Changes to this Privacy Policy'**
  String get privacypolicy50;

  /// No description provided for @privacypolicy51.
  ///
  /// In en, this message translates to:
  /// **'We may update this Privacy Policy periodically. If significant changes are made, we will notify you via email or within the application.'**
  String get privacypolicy51;

  /// No description provided for @privacypolicy52.
  ///
  /// In en, this message translates to:
  /// **'11. Contact Us'**
  String get privacypolicy52;

  /// No description provided for @privacypolicy53.
  ///
  /// In en, this message translates to:
  /// **'For questions, complaints, or to exercise your rights, please contact us at:'**
  String get privacypolicy53;

  /// No description provided for @privacypolicy54.
  ///
  /// In en, this message translates to:
  /// **'Email: [Support Email]'**
  String get privacypolicy54;

  /// No description provided for @privacypolicy55.
  ///
  /// In en, this message translates to:
  /// **' Phone: [Support Phone Number]'**
  String get privacypolicy55;

  /// No description provided for @termsandcondations.
  ///
  /// In en, this message translates to:
  /// **'Terms and Condations'**
  String get termsandcondations;

  /// No description provided for @termsandcondations1.
  ///
  /// In en, this message translates to:
  /// **'Terms and Condations for [Trip To]'**
  String get termsandcondations1;

  /// No description provided for @termsandcondations2.
  ///
  /// In en, this message translates to:
  /// **'Welcome to [TripTo], an application that provides online booking services for flights, hotels, holiday packages, tours, and recreational activities (collectively referred to as the Services). By downloading, accessing, or using our application, you agree to be bound by these Terms and Conditions (the Terms). If you do not agree with these Terms, you must discontinue use of the application immediately.'**
  String get termsandcondations2;

  /// No description provided for @termsandcondations3.
  ///
  /// In en, this message translates to:
  /// **'2. Definitions'**
  String get termsandcondations3;

  /// No description provided for @termsandcondations4.
  ///
  /// In en, this message translates to:
  /// **'Application (\'App\'): Refers to the TripTo mobile and web-based application.'**
  String get termsandcondations4;

  /// No description provided for @termsandcondations5.
  ///
  /// In en, this message translates to:
  /// **'User (\'You\', \'Customer\'): Any person using the application to book services.'**
  String get termsandcondations5;

  /// No description provided for @termsandcondations6.
  ///
  /// In en, this message translates to:
  /// **'Service Providers: Third-party entities such as airlines, hotels, tour operators, and others whose services are offered via the App.'**
  String get termsandcondations6;

  /// No description provided for @termsandcondations7.
  ///
  /// In en, this message translates to:
  /// **'We/Us/Our: TripTo, its owners, employees, and affiliates.'**
  String get termsandcondations7;

  /// No description provided for @termsandcondations8.
  ///
  /// In en, this message translates to:
  /// **'3. Scope of Services'**
  String get termsandcondations8;

  /// No description provided for @termsandcondations9.
  ///
  /// In en, this message translates to:
  /// **'TripTo acts solely as an intermediary between you and the service providers.'**
  String get termsandcondations9;

  /// No description provided for @termsandcondations10.
  ///
  /// In en, this message translates to:
  /// **'All bookings are subject to the availability and conditions of the end-service provider.'**
  String get termsandcondations10;

  /// No description provided for @termsandcondations11.
  ///
  /// In en, this message translates to:
  /// **'We do not own, operate, or control flights, hotels, or activities.'**
  String get termsandcondations11;

  /// No description provided for @termsandcondations12.
  ///
  /// In en, this message translates to:
  /// **'4. User Responsibilities'**
  String get termsandcondations12;

  /// No description provided for @termsandcondations13.
  ///
  /// In en, this message translates to:
  /// **'By using the App, you agree to:'**
  String get termsandcondations13;

  /// No description provided for @termsandcondations14.
  ///
  /// In en, this message translates to:
  /// **'Provide accurate and complete personal details when making a booking.'**
  String get termsandcondations14;

  /// No description provided for @termsandcondations15.
  ///
  /// In en, this message translates to:
  /// **'Ensure that you meet the requirements (e.g., passport validity, visas, vaccination certificates) for travel.'**
  String get termsandcondations15;

  /// No description provided for @termsandcondations16.
  ///
  /// In en, this message translates to:
  /// **'Refrain from using the application for fraudulent, speculative, or unlawful purposes.'**
  String get termsandcondations16;

  /// No description provided for @termsandcondations17.
  ///
  /// In en, this message translates to:
  /// **'5. Bookings and Payments'**
  String get termsandcondations17;

  /// No description provided for @termsandcondations18.
  ///
  /// In en, this message translates to:
  /// **'All bookings are considered confirmed once payment is successfully processed.'**
  String get termsandcondations18;

  /// No description provided for @termsandcondations19.
  ///
  /// In en, this message translates to:
  /// **'Prices displayed include applicable taxes, fees, and service charges unless otherwise indicated.'**
  String get termsandcondations19;

  /// No description provided for @termsandcondations20.
  ///
  /// In en, this message translates to:
  /// **'TripTo reserves the right to modify prices at any time prior to booking confirmation.'**
  String get termsandcondations20;

  /// No description provided for @termsandcondations21.
  ///
  /// In en, this message translates to:
  /// **'6. Cancellation and Refund Policy'**
  String get termsandcondations21;

  /// No description provided for @termsandcondations22.
  ///
  /// In en, this message translates to:
  /// **'Cancellations and refunds are subject to our Cancellation and Refund Policy, which forms an integral part of these Terms. By accepting these Terms, you confirm that you have read and agreed to the Cancellation and Refund Policy.'**
  String get termsandcondations22;

  /// No description provided for @termsandcondations23.
  ///
  /// In en, this message translates to:
  /// **'7. Modifications and Changes'**
  String get termsandcondations23;

  /// No description provided for @termsandcondations24.
  ///
  /// In en, this message translates to:
  /// **'Service providers may modify schedules, accommodations, or services due to operational needs.'**
  String get termsandcondations24;

  /// No description provided for @termsandcondations25.
  ///
  /// In en, this message translates to:
  /// **'TripTo is not liable for such changes but will make reasonable efforts to notify you and assist in finding alternatives.'**
  String get termsandcondations25;

  /// No description provided for @termsandcondations26.
  ///
  /// In en, this message translates to:
  /// **'8. Intellectual Property'**
  String get termsandcondations26;

  /// No description provided for @termsandcondations27.
  ///
  /// In en, this message translates to:
  /// **'All content in the App (designs, logos, texts, graphics, and software) is the property of TripTo and protected by copyright laws.'**
  String get termsandcondations27;

  /// No description provided for @termsandcondations28.
  ///
  /// In en, this message translates to:
  /// **'You may not copy, reproduce, distribute, or exploit any part of the App without prior written consent.'**
  String get termsandcondations28;

  /// No description provided for @termsandcondations29.
  ///
  /// In en, this message translates to:
  /// **'9. Limitation of Liability'**
  String get termsandcondations29;

  /// No description provided for @termsandcondations30.
  ///
  /// In en, this message translates to:
  /// **'TripTo shall not be held responsible for delays, cancellations, accidents, losses, or damages arising from services provided by third parties.'**
  String get termsandcondations30;

  /// No description provided for @termsandcondations31.
  ///
  /// In en, this message translates to:
  /// **'Our liability, if any, shall not exceed the total amount paid for the booking made through the App.'**
  String get termsandcondations31;

  /// No description provided for @termsandcondations32.
  ///
  /// In en, this message translates to:
  /// **'10. Privacy Policy'**
  String get termsandcondations32;

  /// No description provided for @termsandcondations33.
  ///
  /// In en, this message translates to:
  /// **'Your use of the App is also governed by our Privacy Policy, which explains how we collect, store, and protect your personal data.'**
  String get termsandcondations33;

  /// No description provided for @termsandcondations34.
  ///
  /// In en, this message translates to:
  /// **'11. Force Majeure'**
  String get termsandcondations34;

  /// No description provided for @termsandcondations35.
  ///
  /// In en, this message translates to:
  /// **'TripTo shall not be liable for failure to perform any obligation under these Terms due to events beyond our reasonable control, including but not limited to natural disasters, pandemics, government restrictions, strikes, or wars.'**
  String get termsandcondations35;

  /// No description provided for @termsandcondations36.
  ///
  /// In en, this message translates to:
  /// **'12. Governing Law and Jurisdiction'**
  String get termsandcondations36;

  /// No description provided for @termsandcondations37.
  ///
  /// In en, this message translates to:
  /// **'These Terms are governed by the laws of the Arab Republic of Egypt. Any disputes shall be subject to the exclusive jurisdiction of the competent Egyptian courts.'**
  String get termsandcondations37;

  /// No description provided for @termsandcondations38.
  ///
  /// In en, this message translates to:
  /// **'13. Contact Information'**
  String get termsandcondations38;

  /// No description provided for @termsandcondations39.
  ///
  /// In en, this message translates to:
  /// **'For inquiries, complaints, or customer support, you may reach us at:'**
  String get termsandcondations39;

  /// No description provided for @termsandcondations40.
  ///
  /// In en, this message translates to:
  /// **'Email: [Support Email]'**
  String get termsandcondations40;

  /// No description provided for @termsandcondations41.
  ///
  /// In en, this message translates to:
  /// **'Phone: [Support Phone Number]'**
  String get termsandcondations41;

  /// No description provided for @searchOnTrips.
  ///
  /// In en, this message translates to:
  /// **'Search on trips'**
  String get searchOnTrips;

  /// No description provided for @enterSearchText.
  ///
  /// In en, this message translates to:
  /// **'Enter search text'**
  String get enterSearchText;

  /// No description provided for @startDate.
  ///
  /// In en, this message translates to:
  /// **'Start Date'**
  String get startDate;

  /// No description provided for @endDate.
  ///
  /// In en, this message translates to:
  /// **'End Date'**
  String get endDate;

  /// No description provided for @contactus.
  ///
  /// In en, this message translates to:
  /// **'Contact-Us'**
  String get contactus;

  /// No description provided for @messagebody.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get messagebody;

  /// No description provided for @submitmessage.
  ///
  /// In en, this message translates to:
  /// **'Submit Message'**
  String get submitmessage;

  /// No description provided for @report.
  ///
  /// In en, this message translates to:
  /// **'Report'**
  String get report;

  /// No description provided for @sendreport.
  ///
  /// In en, this message translates to:
  /// **'Send Report'**
  String get sendreport;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @enterHotelName.
  ///
  /// In en, this message translates to:
  /// **'Enter hotel name'**
  String get enterHotelName;

  /// No description provided for @noTrips.
  ///
  /// In en, this message translates to:
  /// **'No trips available'**
  String get noTrips;

  /// No description provided for @backToAllTrips.
  ///
  /// In en, this message translates to:
  /// **'Back to all trips'**
  String get backToAllTrips;

  /// No description provided for @issue.
  ///
  /// In en, this message translates to:
  /// **'Description issue'**
  String get issue;
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
