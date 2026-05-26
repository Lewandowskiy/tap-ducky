import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ru.dart';

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
    Locale('en'),
    Locale('ru'),
  ];

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @payloads.
  ///
  /// In en, this message translates to:
  /// **'Payloads'**
  String get payloads;

  /// No description provided for @execute.
  ///
  /// In en, this message translates to:
  /// **'Execute'**
  String get execute;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @selectedPayloadRequiresParametersOpenExecuteToConfigureAndRun.
  ///
  /// In en, this message translates to:
  /// **'Selected payload requires parameters. Open Execute to configure and run.'**
  String get selectedPayloadRequiresParametersOpenExecuteToConfigureAndRun;

  /// No description provided for @mostRecentPayloadRequiresParametersOpenExecuteToConfigureAndRun.
  ///
  /// In en, this message translates to:
  /// **'Most recent payload requires parameters. Open Execute to configure and run.'**
  String get mostRecentPayloadRequiresParametersOpenExecuteToConfigureAndRun;

  /// No description provided for @checkingSystemStatus.
  ///
  /// In en, this message translates to:
  /// **'Checking system status...'**
  String get checkingSystemStatus;

  /// No description provided for @verifyingRootAccessAndUSBGadgetSupport.
  ///
  /// In en, this message translates to:
  /// **'Verifying root access and USB gadget support'**
  String get verifyingRootAccessAndUSBGadgetSupport;

  /// No description provided for @deviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Device Info'**
  String get deviceInfo;

  /// No description provided for @panicStop.
  ///
  /// In en, this message translates to:
  /// **'Panic Stop'**
  String get panicStop;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @device.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get device;

  /// No description provided for @recentPayloads.
  ///
  /// In en, this message translates to:
  /// **'Recent Payloads'**
  String get recentPayloads;

  /// No description provided for @createNew.
  ///
  /// In en, this message translates to:
  /// **'New'**
  String get createNew;

  /// No description provided for @failedToLoadPayloads.
  ///
  /// In en, this message translates to:
  /// **'Failed to load payloads: {error}'**
  String failedToLoadPayloads(String error);

  /// No description provided for @viewAllPayloads.
  ///
  /// In en, this message translates to:
  /// **'View all payloads'**
  String get viewAllPayloads;

  /// No description provided for @moreActions.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get moreActions;

  /// No description provided for @quickAccess.
  ///
  /// In en, this message translates to:
  /// **'Quick Access'**
  String get quickAccess;

  /// No description provided for @systemStatus.
  ///
  /// In en, this message translates to:
  /// **'System Status'**
  String get systemStatus;

  /// No description provided for @payloadManager.
  ///
  /// In en, this message translates to:
  /// **'Payload Manager'**
  String get payloadManager;

  /// No description provided for @createEditImportExport.
  ///
  /// In en, this message translates to:
  /// **'Create, edit, import, export'**
  String get createEditImportExport;

  /// No description provided for @scheduler.
  ///
  /// In en, this message translates to:
  /// **'Scheduler'**
  String get scheduler;

  /// No description provided for @timeWindowsAndTriggers.
  ///
  /// In en, this message translates to:
  /// **'Time windows & triggers'**
  String get timeWindowsAndTriggers;

  /// No description provided for @themeLoggingHIDConfig.
  ///
  /// In en, this message translates to:
  /// **'Theme, logging, HID config'**
  String get themeLoggingHIDConfig;

  /// No description provided for @executionHistory.
  ///
  /// In en, this message translates to:
  /// **'Execution history'**
  String get executionHistory;

  /// No description provided for @diagnosticsAndCompatibility.
  ///
  /// In en, this message translates to:
  /// **'Diagnostics & compatibility'**
  String get diagnosticsAndCompatibility;

  /// No description provided for @emergencyStopAndGadgetTeardown.
  ///
  /// In en, this message translates to:
  /// **'Emergency stop and gadget teardown'**
  String get emergencyStopAndGadgetTeardown;

  /// No description provided for @systemNotReady.
  ///
  /// In en, this message translates to:
  /// **'System Not Ready'**
  String get systemNotReady;

  /// No description provided for @sessionDisarmed.
  ///
  /// In en, this message translates to:
  /// **'Session Disarmed'**
  String get sessionDisarmed;

  /// No description provided for @waitingForHost.
  ///
  /// In en, this message translates to:
  /// **'Waiting for Host'**
  String get waitingForHost;

  /// No description provided for @executing.
  ///
  /// In en, this message translates to:
  /// **'Executing'**
  String get executing;

  /// No description provided for @ready.
  ///
  /// In en, this message translates to:
  /// **'Ready'**
  String get ready;

  /// No description provided for @running.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get running;

  /// No description provided for @disarm.
  ///
  /// In en, this message translates to:
  /// **'Disarm'**
  String get disarm;

  /// No description provided for @armSession.
  ///
  /// In en, this message translates to:
  /// **'Arm Session'**
  String get armSession;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @rootAccessRequired.
  ///
  /// In en, this message translates to:
  /// **'Root access required'**
  String get rootAccessRequired;

  /// No description provided for @hidNotSupported.
  ///
  /// In en, this message translates to:
  /// **'USB gadget not supported'**
  String get hidNotSupported;

  /// No description provided for @tapToActivateUSBGadget.
  ///
  /// In en, this message translates to:
  /// **'Tap to activate USB gadget'**
  String get tapToActivateUSBGadget;

  /// No description provided for @connectUSBCableToTarget.
  ///
  /// In en, this message translates to:
  /// **'Connect USB cable to target'**
  String get connectUSBCableToTarget;

  /// No description provided for @payloadInProgress.
  ///
  /// In en, this message translates to:
  /// **'Payload in progress'**
  String get payloadInProgress;

  /// No description provided for @systemOperational.
  ///
  /// In en, this message translates to:
  /// **'System operational'**
  String get systemOperational;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get none;

  /// No description provided for @keyboard.
  ///
  /// In en, this message translates to:
  /// **'Keyboard'**
  String get keyboard;

  /// No description provided for @mouse.
  ///
  /// In en, this message translates to:
  /// **'Mouse'**
  String get mouse;

  /// No description provided for @composite.
  ///
  /// In en, this message translates to:
  /// **'Composite'**
  String get composite;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @schedules.
  ///
  /// In en, this message translates to:
  /// **'Schedules'**
  String get schedules;

  /// No description provided for @logging.
  ///
  /// In en, this message translates to:
  /// **'Logging'**
  String get logging;

  /// No description provided for @on.
  ///
  /// In en, this message translates to:
  /// **'ON'**
  String get on;

  /// No description provided for @off.
  ///
  /// In en, this message translates to:
  /// **'OFF'**
  String get off;

  /// No description provided for @run.
  ///
  /// In en, this message translates to:
  /// **'Run'**
  String get run;

  /// No description provided for @noPayloadsYet.
  ///
  /// In en, this message translates to:
  /// **'No payloads yet'**
  String get noPayloadsYet;

  /// No description provided for @createYourFirstPayloadToGetStarted.
  ///
  /// In en, this message translates to:
  /// **'Create your first payload to get started.'**
  String get createYourFirstPayloadToGetStarted;

  /// No description provided for @createPayload.
  ///
  /// In en, this message translates to:
  /// **'Create Payload'**
  String get createPayload;

  /// No description provided for @importFromGitHubStore.
  ///
  /// In en, this message translates to:
  /// **'Import from GitHub Store'**
  String get importFromGitHubStore;

  /// No description provided for @operationalFlow.
  ///
  /// In en, this message translates to:
  /// **'Operational Flow'**
  String get operationalFlow;

  /// No description provided for @armHIDSessionActivatesUSBGadget.
  ///
  /// In en, this message translates to:
  /// **'Arm HID session (activates USB gadget)'**
  String get armHIDSessionActivatesUSBGadget;

  /// No description provided for @connectUSBCableToTargetDevice.
  ///
  /// In en, this message translates to:
  /// **'Connect USB cable to target device'**
  String get connectUSBCableToTargetDevice;

  /// No description provided for @selectPayloadAndConfigureParameters.
  ///
  /// In en, this message translates to:
  /// **'Select payload and configure parameters'**
  String get selectPayloadAndConfigureParameters;

  /// No description provided for @executeAndReviewLogs.
  ///
  /// In en, this message translates to:
  /// **'Execute and review logs'**
  String get executeAndReviewLogs;

  /// No description provided for @rootAvailableUSBGadgetIsActive.
  ///
  /// In en, this message translates to:
  /// **'Root available. USB gadget backend is active.'**
  String get rootAvailableUSBGadgetIsActive;

  /// No description provided for @rootNotAvailableCheckDeviceScreenForDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Root not available. Check Device screen for diagnostics.'**
  String get rootNotAvailableCheckDeviceScreenForDiagnostics;

  /// No description provided for @labelCopiedToClipboard.
  ///
  /// In en, this message translates to:
  /// **'{label} copied to clipboard'**
  String labelCopiedToClipboard(String label);

  /// No description provided for @deviceInformation.
  ///
  /// In en, this message translates to:
  /// **'Device Information'**
  String get deviceInformation;

  /// No description provided for @refreshDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Refresh diagnostics'**
  String get refreshDiagnostics;

  /// No description provided for @hidReadiness.
  ///
  /// In en, this message translates to:
  /// **'HID Readiness'**
  String get hidReadiness;

  /// No description provided for @usbGadgetSystemStatus.
  ///
  /// In en, this message translates to:
  /// **'USB gadget system status'**
  String get usbGadgetSystemStatus;

  /// No description provided for @usbDeviceController.
  ///
  /// In en, this message translates to:
  /// **'USB Device Controller'**
  String get usbDeviceController;

  /// No description provided for @realTimeConnectionState.
  ///
  /// In en, this message translates to:
  /// **'Real-time connection state'**
  String get realTimeConnectionState;

  /// No description provided for @hardwareAndSoftwareDetails.
  ///
  /// In en, this message translates to:
  /// **'Hardware & software details'**
  String get hardwareAndSoftwareDetails;

  /// No description provided for @backendDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Backend Diagnostics'**
  String get backendDiagnostics;

  /// No description provided for @kernelAndSysytemConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Kernel & system configuration'**
  String get kernelAndSysytemConfiguration;

  /// No description provided for @compatibilityNotes.
  ///
  /// In en, this message translates to:
  /// **'Compatibility Notes'**
  String get compatibilityNotes;

  /// No description provided for @requirementsAndRecommendations.
  ///
  /// In en, this message translates to:
  /// **'Requirements & recommendations'**
  String get requirementsAndRecommendations;

  /// No description provided for @systemReady.
  ///
  /// In en, this message translates to:
  /// **'System Ready'**
  String get systemReady;

  /// No description provided for @allRequirementsMetForHIDOperations.
  ///
  /// In en, this message translates to:
  /// **'All requirements met for HID operations'**
  String get allRequirementsMetForHIDOperations;

  /// No description provided for @missingRequiredComponents.
  ///
  /// In en, this message translates to:
  /// **'Missing required components'**
  String get missingRequiredComponents;

  /// No description provided for @rootAccess.
  ///
  /// In en, this message translates to:
  /// **'Root Access'**
  String get rootAccess;

  /// No description provided for @avaible.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get avaible;

  /// No description provided for @unavailable.
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get unavailable;

  /// No description provided for @superUserPermissionsGranted.
  ///
  /// In en, this message translates to:
  /// **'Superuser permissions granted'**
  String get superUserPermissionsGranted;

  /// No description provided for @rootAccessRequiredForUSBGadgetControl.
  ///
  /// In en, this message translates to:
  /// **'Root access required for USB gadget control'**
  String get rootAccessRequiredForUSBGadgetControl;

  /// No description provided for @usbGadgetSupport.
  ///
  /// In en, this message translates to:
  /// **'USB Gadget Support'**
  String get usbGadgetSupport;

  /// No description provided for @supported.
  ///
  /// In en, this message translates to:
  /// **'Supported'**
  String get supported;

  /// No description provided for @unsupported.
  ///
  /// In en, this message translates to:
  /// **'Unsupported'**
  String get unsupported;

  /// No description provided for @kernelSupportsConfigFSUSBGadgets.
  ///
  /// In en, this message translates to:
  /// **'Kernel supports ConfigFS USB gadgets'**
  String get kernelSupportsConfigFSUSBGadgets;

  /// No description provided for @kernelMissingUSBGadgetConfigFSSupport.
  ///
  /// In en, this message translates to:
  /// **'Kernel missing USB gadget/ConfigFS support'**
  String get kernelMissingUSBGadgetConfigFSSupport;

  /// No description provided for @sessionState.
  ///
  /// In en, this message translates to:
  /// **'Session State'**
  String get sessionState;

  /// No description provided for @armed.
  ///
  /// In en, this message translates to:
  /// **'Armed'**
  String get armed;

  /// No description provided for @disarmed.
  ///
  /// In en, this message translates to:
  /// **'Disarmed'**
  String get disarmed;

  /// No description provided for @usbGadgetIsActiveAndReady.
  ///
  /// In en, this message translates to:
  /// **'USB gadget is active and ready'**
  String get usbGadgetIsActiveAndReady;

  /// No description provided for @activateSessionToEnableHIDOperations.
  ///
  /// In en, this message translates to:
  /// **'Activate session to enable HID operations'**
  String get activateSessionToEnableHIDOperations;

  /// No description provided for @targetConnection.
  ///
  /// In en, this message translates to:
  /// **'Target Connection'**
  String get targetConnection;

  /// No description provided for @connected.
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get connected;

  /// No description provided for @disconnected.
  ///
  /// In en, this message translates to:
  /// **'Disconnected'**
  String get disconnected;

  /// No description provided for @usbCableConnectedToTargetHost.
  ///
  /// In en, this message translates to:
  /// **'USB cable connected to target host'**
  String get usbCableConnectedToTargetHost;

  /// No description provided for @availableUDCControllers.
  ///
  /// In en, this message translates to:
  /// **'Available UDC Controllers'**
  String get availableUDCControllers;

  /// No description provided for @hostHasEnumeratedTheDeviceReadyForHIDCommunication.
  ///
  /// In en, this message translates to:
  /// **'Host has enumerated the device. Ready for HID communication.'**
  String get hostHasEnumeratedTheDeviceReadyForHIDCommunication;

  /// No description provided for @noUSBCableConnectedOrHostIsPoweredOff.
  ///
  /// In en, this message translates to:
  /// **'No USB cable connected or host is powered off.'**
  String get noUSBCableConnectedOrHostIsPoweredOff;

  /// No description provided for @usbCableConnectedWaitingForPowerNegotiation.
  ///
  /// In en, this message translates to:
  /// **'USB cable connected, waiting for power negotiation.'**
  String get usbCableConnectedWaitingForPowerNegotiation;

  /// No description provided for @deviceIsPoweredWaitingForEnumeration.
  ///
  /// In en, this message translates to:
  /// **'Device is powered, waiting for enumeration.'**
  String get deviceIsPoweredWaitingForEnumeration;

  /// No description provided for @enumerationStartedDeviceIsBeingConfigured.
  ///
  /// In en, this message translates to:
  /// **'Enumeration started, device is being configured.'**
  String get enumerationStartedDeviceIsBeingConfigured;

  /// No description provided for @deviceHasBeenAddressedByHostConfigurationInProgress.
  ///
  /// In en, this message translates to:
  /// **'Device has been addressed by host, configuration in progress.'**
  String get deviceHasBeenAddressedByHostConfigurationInProgress;

  /// No description provided for @unknownUDCState.
  ///
  /// In en, this message translates to:
  /// **'Unknown UDC state: {state}'**
  String unknownUDCState(String state);

  /// No description provided for @udcStateIsPolledEvery2SecondsWhenSessionIsActive.
  ///
  /// In en, this message translates to:
  /// **'UDC state is polled every 2 seconds when session is active'**
  String get udcStateIsPolledEvery2SecondsWhenSessionIsActive;

  /// No description provided for @rootShellID.
  ///
  /// In en, this message translates to:
  /// **'Root Shell ID'**
  String get rootShellID;

  /// No description provided for @udcControllers.
  ///
  /// In en, this message translates to:
  /// **'UDC Controllers'**
  String get udcControllers;

  /// No description provided for @configfsMountPoints.
  ///
  /// In en, this message translates to:
  /// **'ConfigFS Mount Points'**
  String get configfsMountPoints;

  /// No description provided for @activeGadgetDirectories.
  ///
  /// In en, this message translates to:
  /// **'Active Gadget Directories'**
  String get activeGadgetDirectories;

  /// No description provided for @kernelConfigFlags.
  ///
  /// In en, this message translates to:
  /// **'Kernel Config Flags ({length})'**
  String kernelConfigFlags(int length);

  /// No description provided for @systemPaths.
  ///
  /// In en, this message translates to:
  /// **'System Paths'**
  String get systemPaths;

  /// No description provided for @rawKernelConfig.
  ///
  /// In en, this message translates to:
  /// **'Raw Kernel Config ({length} lines)'**
  String rawKernelConfig(int length);

  /// No description provided for @physicalDeviceDetected.
  ///
  /// In en, this message translates to:
  /// **'Physical device detected'**
  String get physicalDeviceDetected;

  /// No description provided for @emulatorDetected.
  ///
  /// In en, this message translates to:
  /// **'Emulator detected'**
  String get emulatorDetected;

  /// No description provided for @thisIsAPhysicalDevice.
  ///
  /// In en, this message translates to:
  /// **'This is a physical device - the recommended environment for USB gadget operations. All HID features should work as expected.'**
  String get thisIsAPhysicalDevice;

  /// No description provided for @thisIsAnEmulator.
  ///
  /// In en, this message translates to:
  /// **'This appears to be an emulator. Emulators typically cannot validate USB gadget/ConfigFS behavior. Use a physical rooted device for real HID operations.'**
  String get thisIsAnEmulator;

  /// No description provided for @requirementsForRealHID.
  ///
  /// In en, this message translates to:
  /// **'Requirements for Real HID'**
  String get requirementsForRealHID;

  /// No description provided for @rootAccessMagiskKernelSUOrSuperSU.
  ///
  /// In en, this message translates to:
  /// **'Root access (Magisk, Kernel SU, or SuperSU)'**
  String get rootAccessMagiskKernelSUOrSuperSU;

  /// No description provided for @usbGadgetConfigFSKernelSupport.
  ///
  /// In en, this message translates to:
  /// **'USB gadget / ConfigFS kernel support'**
  String get usbGadgetConfigFSKernelSupport;

  /// No description provided for @usbOTGCableOrUSBCDataCable.
  ///
  /// In en, this message translates to:
  /// **'USB OTG cable or USB-C data cable'**
  String get usbOTGCableOrUSBCDataCable;

  /// No description provided for @targetHostWithUSBHIDSupport.
  ///
  /// In en, this message translates to:
  /// **'Target host with USB HID support'**
  String get targetHostWithUSBHIDSupport;

  /// No description provided for @failedToLoadDeviceInfo.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Device Info'**
  String get failedToLoadDeviceInfo;

  /// No description provided for @failedToLoadDiagnostics.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Diagnostics'**
  String get failedToLoadDiagnostics;
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
      <String>['en', 'ru'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ru':
      return AppLocalizationsRu();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
