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

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

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

  /// No description provided for @failedToLoadPayloadsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load payloads: {error}'**
  String failedToLoadPayloadsError(String error);

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

  /// No description provided for @available.
  ///
  /// In en, this message translates to:
  /// **'Available'**
  String get available;

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

  /// No description provided for @failedToLoadPayloads.
  ///
  /// In en, this message translates to:
  /// **'Failed to Load Payloads'**
  String get failedToLoadPayloads;

  /// No description provided for @noPayloadsAvailable.
  ///
  /// In en, this message translates to:
  /// **'No payloads available'**
  String get noPayloadsAvailable;

  /// No description provided for @createOrImportAPayloadFirst.
  ///
  /// In en, this message translates to:
  /// **'Create or import a payload first.'**
  String get createOrImportAPayloadFirst;

  /// No description provided for @executionSpeed.
  ///
  /// In en, this message translates to:
  /// **'Execution Speed'**
  String get executionSpeed;

  /// No description provided for @ultra.
  ///
  /// In en, this message translates to:
  /// **'Ultra'**
  String get ultra;

  /// No description provided for @fast.
  ///
  /// In en, this message translates to:
  /// **'Fast'**
  String get fast;

  /// No description provided for @normal.
  ///
  /// In en, this message translates to:
  /// **'Normal'**
  String get normal;

  /// No description provided for @slow.
  ///
  /// In en, this message translates to:
  /// **'Slow'**
  String get slow;

  /// No description provided for @speedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'Speed Multiplier'**
  String get speedMultiplier;

  /// No description provided for @executionSpeedScalesScriptDelaysTypingSpeedIsSetInSettings.
  ///
  /// In en, this message translates to:
  /// **'Execution speed scales script delays. Typing speed is set in Settings.'**
  String get executionSpeedScalesScriptDelaysTypingSpeedIsSetInSettings;

  /// No description provided for @estimatedDuration.
  ///
  /// In en, this message translates to:
  /// **'Estimated Duration'**
  String get estimatedDuration;

  /// No description provided for @original.
  ///
  /// In en, this message translates to:
  /// **'Original'**
  String get original;

  /// No description provided for @adjusted.
  ///
  /// In en, this message translates to:
  /// **'Adjusted'**
  String get adjusted;

  /// No description provided for @basedOnCountCommandsAndSecOfDelays.
  ///
  /// In en, this message translates to:
  /// **'Based on {count} command{count,plural, one{} other{s}} and {sec} sec of delays'**
  String basedOnCountCommandsAndSecOfDelays(int count, String sec);

  /// No description provided for @slowerSpeedsFasterSpeeds.
  ///
  /// In en, this message translates to:
  /// **'Use slower speeds (2×-4×) for unreliable targets or debugging. Faster speeds (0.25×-0.5×) for quick testing.'**
  String get slowerSpeedsFasterSpeeds;

  /// No description provided for @millisec.
  ///
  /// In en, this message translates to:
  /// **'{ms}ms'**
  String millisec(int ms);

  /// No description provided for @sec.
  ///
  /// In en, this message translates to:
  /// **'{sec}s'**
  String sec(String sec);

  /// No description provided for @minAndSec.
  ///
  /// In en, this message translates to:
  /// **'{min}m {sec}s'**
  String minAndSec(int min, int sec);

  /// No description provided for @verySlow.
  ///
  /// In en, this message translates to:
  /// **'Very Slow'**
  String get verySlow;

  /// No description provided for @veryFast.
  ///
  /// In en, this message translates to:
  /// **'Very Fast'**
  String get veryFast;

  /// No description provided for @rootShellAvailable.
  ///
  /// In en, this message translates to:
  /// **'Root shell available'**
  String get rootShellAvailable;

  /// No description provided for @usbHIDSupport.
  ///
  /// In en, this message translates to:
  /// **'USB HID support'**
  String get usbHIDSupport;

  /// No description provided for @usbGadgetConfigfsDetected.
  ///
  /// In en, this message translates to:
  /// **'USB gadget/configfs detected'**
  String get usbGadgetConfigfsDetected;

  /// No description provided for @deviceDoesNotSupportUSBGadgetMode.
  ///
  /// In en, this message translates to:
  /// **'Device does not support USB gadget mode'**
  String get deviceDoesNotSupportUSBGadgetMode;

  /// No description provided for @hidSessionArmed.
  ///
  /// In en, this message translates to:
  /// **'HID session armed'**
  String get hidSessionArmed;

  /// No description provided for @usbGadgetIsActive.
  ///
  /// In en, this message translates to:
  /// **'USB gadget is active'**
  String get usbGadgetIsActive;

  /// No description provided for @armSessionFromDashboardToActivateUSBGadget.
  ///
  /// In en, this message translates to:
  /// **'Arm session from Dashboard to activate USB gadget'**
  String get armSessionFromDashboardToActivateUSBGadget;

  /// No description provided for @targetDeviceConnected.
  ///
  /// In en, this message translates to:
  /// **'Target device connected'**
  String get targetDeviceConnected;

  /// No description provided for @usbCableConnectedToTarget.
  ///
  /// In en, this message translates to:
  /// **'USB cable connected to target'**
  String get usbCableConnectedToTarget;

  /// No description provided for @connectUSBCableToTargetDeviceOptionalForTesting.
  ///
  /// In en, this message translates to:
  /// **'Connect USB cable to target device (optional for testing)'**
  String get connectUSBCableToTargetDeviceOptionalForTesting;

  /// No description provided for @payloadSelected.
  ///
  /// In en, this message translates to:
  /// **'Payload selected'**
  String get payloadSelected;

  /// No description provided for @payloadName.
  ///
  /// In en, this message translates to:
  /// **'Payload: {name}'**
  String payloadName(String name);

  /// No description provided for @requiredParameters.
  ///
  /// In en, this message translates to:
  /// **'Required parameters'**
  String get requiredParameters;

  /// No description provided for @fillInAllRequiredParametersAbove.
  ///
  /// In en, this message translates to:
  /// **'Fill in all required parameters above'**
  String get fillInAllRequiredParametersAbove;

  /// No description provided for @allRequiredParametersProvided.
  ///
  /// In en, this message translates to:
  /// **'All required parameters provided'**
  String get allRequiredParametersProvided;

  /// No description provided for @preExecutionChecklist.
  ///
  /// In en, this message translates to:
  /// **'Pre-Execution Checklist'**
  String get preExecutionChecklist;

  /// No description provided for @checksPassed.
  ///
  /// In en, this message translates to:
  /// **'{passedCount} of {totalCount} checks passed'**
  String checksPassed(int passedCount, int totalCount);

  /// No description provided for @fixCriticalIssuesAboveBeforeExecuting.
  ///
  /// In en, this message translates to:
  /// **'Fix critical issues above before executing'**
  String get fixCriticalIssuesAboveBeforeExecuting;

  /// No description provided for @required.
  ///
  /// In en, this message translates to:
  /// **'REQUIRED'**
  String get required;

  /// No description provided for @rootHIDUnavailable.
  ///
  /// In en, this message translates to:
  /// **'Root/HID unavailable'**
  String get rootHIDUnavailable;

  /// No description provided for @noDeviceConnected.
  ///
  /// In en, this message translates to:
  /// **'No device connected'**
  String get noDeviceConnected;

  /// No description provided for @readyToExecute.
  ///
  /// In en, this message translates to:
  /// **'Ready to execute'**
  String get readyToExecute;

  /// No description provided for @selectedPayload.
  ///
  /// In en, this message translates to:
  /// **'Selected Payload'**
  String get selectedPayload;

  /// No description provided for @payload.
  ///
  /// In en, this message translates to:
  /// **'Payload'**
  String get payload;

  /// No description provided for @editPayload.
  ///
  /// In en, this message translates to:
  /// **'Edit Payload'**
  String get editPayload;

  /// No description provided for @parameters.
  ///
  /// In en, this message translates to:
  /// **'Parameters'**
  String get parameters;

  /// No description provided for @execution.
  ///
  /// In en, this message translates to:
  /// **'Execution'**
  String get execution;

  /// No description provided for @runPayload.
  ///
  /// In en, this message translates to:
  /// **'Run Payload'**
  String get runPayload;

  /// No description provided for @rootAccessNotAvailable.
  ///
  /// In en, this message translates to:
  /// **'Root access not available'**
  String get rootAccessNotAvailable;

  /// No description provided for @usbHIDNotSupported.
  ///
  /// In en, this message translates to:
  /// **'USB HID not supported'**
  String get usbHIDNotSupported;

  /// No description provided for @sessionIsDisarmedArmItFromDashboardFirst.
  ///
  /// In en, this message translates to:
  /// **'Session is disarmed. Arm it from Dashboard first.'**
  String get sessionIsDisarmedArmItFromDashboardFirst;

  /// No description provided for @cannotExecute.
  ///
  /// In en, this message translates to:
  /// **'Cannot execute'**
  String get cannotExecute;

  /// No description provided for @console.
  ///
  /// In en, this message translates to:
  /// **'Console'**
  String get console;

  /// No description provided for @events.
  ///
  /// In en, this message translates to:
  /// **'Events'**
  String get events;

  /// No description provided for @sendRawHIDCommands.
  ///
  /// In en, this message translates to:
  /// **'Send raw HID commands'**
  String get sendRawHIDCommands;

  /// No description provided for @saveAsPreset.
  ///
  /// In en, this message translates to:
  /// **'Save as Preset'**
  String get saveAsPreset;

  /// No description provided for @quickCommands.
  ///
  /// In en, this message translates to:
  /// **'Quick Commands'**
  String get quickCommands;

  /// No description provided for @selectAPreset.
  ///
  /// In en, this message translates to:
  /// **'Select a preset...'**
  String get selectAPreset;

  /// No description provided for @examples.
  ///
  /// In en, this message translates to:
  /// **'Examples'**
  String get examples;

  /// No description provided for @enterACommandFirstBeforeSavingAsPreset.
  ///
  /// In en, this message translates to:
  /// **'Enter a command first before saving as preset'**
  String get enterACommandFirstBeforeSavingAsPreset;

  /// No description provided for @presetNameOptional.
  ///
  /// In en, this message translates to:
  /// **'Preset Name (optional)'**
  String get presetNameOptional;

  /// No description provided for @egOpenNotepad.
  ///
  /// In en, this message translates to:
  /// **'e.g., Open Notepad'**
  String get egOpenNotepad;

  /// No description provided for @command.
  ///
  /// In en, this message translates to:
  /// **'Command'**
  String get command;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @presetSavedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Preset saved successfully'**
  String get presetSavedSuccessfully;

  /// No description provided for @runAPayloadToSeeExecutionEvents.
  ///
  /// In en, this message translates to:
  /// **'Run a payload to see execution events'**
  String get runAPayloadToSeeExecutionEvents;

  /// No description provided for @noEventsYet.
  ///
  /// In en, this message translates to:
  /// **'No events yet'**
  String get noEventsYet;

  /// No description provided for @secAgo.
  ///
  /// In en, this message translates to:
  /// **'{sec}s ago'**
  String secAgo(int sec);

  /// No description provided for @minAgo.
  ///
  /// In en, this message translates to:
  /// **'{min}m ago'**
  String minAgo(int min);

  /// No description provided for @noBrowserAvailable.
  ///
  /// In en, this message translates to:
  /// **'No browser available'**
  String get noBrowserAvailable;

  /// No description provided for @failedToOpenError.
  ///
  /// In en, this message translates to:
  /// **'Failed to open: {error}'**
  String failedToOpenError(String error);

  /// No description provided for @resetAllSettingsQuestionMark.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings?'**
  String get resetAllSettingsQuestionMark;

  /// No description provided for @thisWillRestoreAllSettingsToTheirDefaults.
  ///
  /// In en, this message translates to:
  /// **'This will restore all settings to their defaults.'**
  String get thisWillRestoreAllSettingsToTheirDefaults;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @settingsResetToDefaults.
  ///
  /// In en, this message translates to:
  /// **'Settings reset to defaults'**
  String get settingsResetToDefaults;

  /// No description provided for @failedToLoadSettingsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load settings: {error}'**
  String failedToLoadSettingsError(String error);

  /// No description provided for @resetAllSettings.
  ///
  /// In en, this message translates to:
  /// **'Reset all settings'**
  String get resetAllSettings;

  /// No description provided for @supportDevelopment.
  ///
  /// In en, this message translates to:
  /// **'Support Development'**
  String get supportDevelopment;

  /// No description provided for @keepThisAppFastFreeAndMaintained.
  ///
  /// In en, this message translates to:
  /// **'Keep this app fast, free, and maintained'**
  String get keepThisAppFastFreeAndMaintained;

  /// No description provided for @supportDescription.
  ///
  /// In en, this message translates to:
  /// **'No ads, no tracking, no locked features. Your support keeps this Rubber Ducky alternative independent and freely available to penetration testers worldwide.'**
  String get supportDescription;

  /// No description provided for @donate.
  ///
  /// In en, this message translates to:
  /// **'Donate'**
  String get donate;

  /// No description provided for @repositoryLinkCopied.
  ///
  /// In en, this message translates to:
  /// **'Repository link copied'**
  String get repositoryLinkCopied;

  /// No description provided for @starRepo.
  ///
  /// In en, this message translates to:
  /// **'Star Repo'**
  String get starRepo;

  /// No description provided for @localOnly.
  ///
  /// In en, this message translates to:
  /// **'Local-only'**
  String get localOnly;

  /// No description provided for @noTracking.
  ///
  /// In en, this message translates to:
  /// **'No Tracking'**
  String get noTracking;

  /// No description provided for @lightweight.
  ///
  /// In en, this message translates to:
  /// **'Lightweight'**
  String get lightweight;

  /// No description provided for @openSource.
  ///
  /// In en, this message translates to:
  /// **'Open Source'**
  String get openSource;

  /// No description provided for @appearance.
  ///
  /// In en, this message translates to:
  /// **'Appearance'**
  String get appearance;

  /// No description provided for @customizeYourVisualExperience.
  ///
  /// In en, this message translates to:
  /// **'Customize your visual experience'**
  String get customizeYourVisualExperience;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @controlPayloadBehaviorAndTiming.
  ///
  /// In en, this message translates to:
  /// **'Control payload behavior and timing'**
  String get controlPayloadBehaviorAndTiming;

  /// No description provided for @speedAndTiming.
  ///
  /// In en, this message translates to:
  /// **'Speed & timing'**
  String get speedAndTiming;

  /// No description provided for @resetDefaults.
  ///
  /// In en, this message translates to:
  /// **'Reset defaults'**
  String get resetDefaults;

  /// No description provided for @adjustScriptDelaysAndRawKeyPressTiming.
  ///
  /// In en, this message translates to:
  /// **'Adjust script delays and raw key press timing.'**
  String get adjustScriptDelaysAndRawKeyPressTiming;

  /// No description provided for @executionSpeedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'{label} • {multiplier}×'**
  String executionSpeedMultiplier(String label, String multiplier);

  /// No description provided for @typingSpeed.
  ///
  /// In en, this message translates to:
  /// **'Typing speed'**
  String get typingSpeed;

  /// No description provided for @typingSpeedMultiplier.
  ///
  /// In en, this message translates to:
  /// **'{label} • {multiplier}×'**
  String typingSpeedMultiplier(String label, String multiplier);

  /// No description provided for @lowerIsFaster.
  ///
  /// In en, this message translates to:
  /// **'Lower is faster. Controls raw key press timing (STRING typing).'**
  String get lowerIsFaster;

  /// No description provided for @ultraFast.
  ///
  /// In en, this message translates to:
  /// **'Ultra Fast'**
  String get ultraFast;

  /// No description provided for @ultraFastDescription.
  ///
  /// In en, this message translates to:
  /// **'Ultra fast may be unreliable on some hosts.'**
  String get ultraFastDescription;

  /// No description provided for @advancedExecution.
  ///
  /// In en, this message translates to:
  /// **'Advanced execution'**
  String get advancedExecution;

  /// No description provided for @loggingHIDReliabilityUnicodeFallback.
  ///
  /// In en, this message translates to:
  /// **'Logging, HID reliability, Unicode fallback'**
  String get loggingHIDReliabilityUnicodeFallback;

  /// No description provided for @enableLogging.
  ///
  /// In en, this message translates to:
  /// **'Enable logging'**
  String get enableLogging;

  /// No description provided for @recordExecutionEventsAndOutcomes.
  ///
  /// In en, this message translates to:
  /// **'Record execution events and outcomes'**
  String get recordExecutionEventsAndOutcomes;

  /// No description provided for @randomizeTiming.
  ///
  /// In en, this message translates to:
  /// **'Randomize timing'**
  String get randomizeTiming;

  /// No description provided for @addsSmallJitterToMimicRealTyping.
  ///
  /// In en, this message translates to:
  /// **'Adds small jitter to mimic real typing'**
  String get addsSmallJitterToMimicRealTyping;

  /// No description provided for @hidGraceWindow.
  ///
  /// In en, this message translates to:
  /// **'HID grace window'**
  String get hidGraceWindow;

  /// No description provided for @hidGraceWindowMS.
  ///
  /// In en, this message translates to:
  /// **'{ms} ms'**
  String hidGraceWindowMS(int ms);

  /// No description provided for @waitBrieflyForHIDToBecomeActiveBeforeFailingAWrite.
  ///
  /// In en, this message translates to:
  /// **'Wait briefly for HID to become active before failing a write.'**
  String get waitBrieflyForHIDToBecomeActiveBeforeFailingAWrite;

  /// No description provided for @unicodeFallback.
  ///
  /// In en, this message translates to:
  /// **'Unicode fallback'**
  String get unicodeFallback;

  /// No description provided for @warnAndSkip.
  ///
  /// In en, this message translates to:
  /// **'Warn & skip'**
  String get warnAndSkip;

  /// No description provided for @skip.
  ///
  /// In en, this message translates to:
  /// **'Skip'**
  String get skip;

  /// No description provided for @asciiTransliterate.
  ///
  /// In en, this message translates to:
  /// **'ASCII transliterate'**
  String get asciiTransliterate;

  /// No description provided for @controlsHowUnsupportedCharactersAreHandledDuringTyping.
  ///
  /// In en, this message translates to:
  /// **'Controls how unsupported characters are handled during typing.'**
  String get controlsHowUnsupportedCharactersAreHandledDuringTyping;

  /// No description provided for @riskyFastModeCanCauseMissedOrStuckKeysOnSomeHosts.
  ///
  /// In en, this message translates to:
  /// **'Risky fast mode can cause missed or stuck keys on some hosts.'**
  String get riskyFastModeCanCauseMissedOrStuckKeysOnSomeHosts;

  /// No description provided for @riskyFastMode.
  ///
  /// In en, this message translates to:
  /// **'Risky fast mode'**
  String get riskyFastMode;

  /// No description provided for @allowsShorterKeyHoldAndInterKeyDelaysMayBeUnreliable.
  ///
  /// In en, this message translates to:
  /// **'Allows shorter key hold and inter-key delays. May be unreliable.'**
  String get allowsShorterKeyHoldAndInterKeyDelaysMayBeUnreliable;

  /// No description provided for @keepScreenOn.
  ///
  /// In en, this message translates to:
  /// **'Keep screen on'**
  String get keepScreenOn;

  /// No description provided for @preventsScreenFromSleepingDuringExecution.
  ///
  /// In en, this message translates to:
  /// **'Prevents screen from sleeping during execution'**
  String get preventsScreenFromSleepingDuringExecution;

  /// No description provided for @mayIncreaseBatteryUsageScreenWillStayOnEvenWhenAppIsInBackground.
  ///
  /// In en, this message translates to:
  /// **'May increase battery usage. Screen will stay on even when app is in background.'**
  String get mayIncreaseBatteryUsageScreenWillStayOnEvenWhenAppIsInBackground;

  /// No description provided for @stealthMode.
  ///
  /// In en, this message translates to:
  /// **'Stealth Mode'**
  String get stealthMode;

  /// No description provided for @covertOperationCapabilities.
  ///
  /// In en, this message translates to:
  /// **'Covert operation capabilities'**
  String get covertOperationCapabilities;

  /// No description provided for @hiddenExecution.
  ///
  /// In en, this message translates to:
  /// **'Hidden Execution'**
  String get hiddenExecution;

  /// No description provided for @hiddenExecutionDescription.
  ///
  /// In en, this message translates to:
  /// **'When \"Keep screen on\" is disabled, payloads can execute while the screen is off. This allows for covert operation where the device appears idle.'**
  String get hiddenExecutionDescription;

  /// No description provided for @useCases.
  ///
  /// In en, this message translates to:
  /// **'Use Cases'**
  String get useCases;

  /// No description provided for @useCasesDescription.
  ///
  /// In en, this message translates to:
  /// **'• Screen ON: Interactive testing, debugging, demonstrations\n• Screen OFF: Scheduled tasks, automated operations, covert execution'**
  String get useCasesDescription;

  /// No description provided for @payloadsStore.
  ///
  /// In en, this message translates to:
  /// **'Payloads Store'**
  String get payloadsStore;

  /// No description provided for @browseGitHubRepositoriesAndImportPayloads.
  ///
  /// In en, this message translates to:
  /// **'Browse GitHub repositories and import payloads'**
  String get browseGitHubRepositoriesAndImportPayloads;

  /// No description provided for @openPayloadsStore.
  ///
  /// In en, this message translates to:
  /// **'Open Payloads Store'**
  String get openPayloadsStore;

  /// No description provided for @manageAndImportFromMultipleRepos.
  ///
  /// In en, this message translates to:
  /// **'Manage and import from multiple repos'**
  String get manageAndImportFromMultipleRepos;

  /// No description provided for @advanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get advanced;

  /// No description provided for @usbGadgetPresetsAndHotkeys.
  ///
  /// In en, this message translates to:
  /// **'USB gadget, presets, and hotkeys'**
  String get usbGadgetPresetsAndHotkeys;

  /// No description provided for @advancedSettings.
  ///
  /// In en, this message translates to:
  /// **'Advanced settings'**
  String get advancedSettings;

  /// No description provided for @commandPresetsHotkeysDefaultVidPid.
  ///
  /// In en, this message translates to:
  /// **'Command presets, hotkeys, default VID/PID'**
  String get commandPresetsHotkeysDefaultVidPid;

  /// No description provided for @hidControl.
  ///
  /// In en, this message translates to:
  /// **'HID Control'**
  String get hidControl;

  /// No description provided for @usbGadgetSessionStatus.
  ///
  /// In en, this message translates to:
  /// **'USB gadget session status'**
  String get usbGadgetSessionStatus;

  /// No description provided for @rootAvailable.
  ///
  /// In en, this message translates to:
  /// **'Root available'**
  String get rootAvailable;

  /// No description provided for @hidSupported.
  ///
  /// In en, this message translates to:
  /// **'HID supported'**
  String get hidSupported;

  /// No description provided for @hidSession.
  ///
  /// In en, this message translates to:
  /// **'HID session'**
  String get hidSession;

  /// No description provided for @hidSessionDescription.
  ///
  /// In en, this message translates to:
  /// **'HID session control activates/deactivates the USB gadget. Check Device screen for detailed diagnostics.'**
  String get hidSessionDescription;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @appInformationAndLegal.
  ///
  /// In en, this message translates to:
  /// **'App information and legal'**
  String get appInformationAndLegal;

  /// No description provided for @version.
  ///
  /// In en, this message translates to:
  /// **'Version {version}'**
  String version(String version);

  /// No description provided for @licences.
  ///
  /// In en, this message translates to:
  /// **'Licenses'**
  String get licences;

  /// No description provided for @openSourceLicenses.
  ///
  /// In en, this message translates to:
  /// **'Open source licenses'**
  String get openSourceLicenses;

  /// No description provided for @autoTheme.
  ///
  /// In en, this message translates to:
  /// **'Auto Theme'**
  String get autoTheme;

  /// No description provided for @lightTheme.
  ///
  /// In en, this message translates to:
  /// **'Light Theme'**
  String get lightTheme;

  /// No description provided for @darkTheme.
  ///
  /// In en, this message translates to:
  /// **'Dark Theme'**
  String get darkTheme;

  /// No description provided for @followsYourDeviceSettings.
  ///
  /// In en, this message translates to:
  /// **'Follows your device settings'**
  String get followsYourDeviceSettings;

  /// No description provided for @alwaysBrightAndClear.
  ///
  /// In en, this message translates to:
  /// **'Always bright and clear'**
  String get alwaysBrightAndClear;

  /// No description provided for @easyOnTheEyes.
  ///
  /// In en, this message translates to:
  /// **'Easy on the eyes'**
  String get easyOnTheEyes;

  /// No description provided for @themeModeSystem.
  ///
  /// In en, this message translates to:
  /// **'Theme automatically switches when you change your device settings between light and dark mode'**
  String get themeModeSystem;

  /// No description provided for @themeModeLight.
  ///
  /// In en, this message translates to:
  /// **'Perfect for daytime use and well-lit environments'**
  String get themeModeLight;

  /// No description provided for @themeModeDark.
  ///
  /// In en, this message translates to:
  /// **'Reduces eye strain in low-light conditions and saves battery on OLED screens'**
  String get themeModeDark;

  /// No description provided for @useDynamicColors.
  ///
  /// In en, this message translates to:
  /// **'Use dynamic colors'**
  String get useDynamicColors;

  /// No description provided for @matchYourSystemMaterialYouPaletteOnSupportedDevices.
  ///
  /// In en, this message translates to:
  /// **'Match your system Material You palette on supported devices.'**
  String get matchYourSystemMaterialYouPaletteOnSupportedDevices;

  /// No description provided for @dynamicColorsAreOnlyAvailableOnAndroid12.
  ///
  /// In en, this message translates to:
  /// **'Dynamic colors are only available on Android 12+.'**
  String get dynamicColorsAreOnlyAvailableOnAndroid12;

  /// No description provided for @countSelected.
  ///
  /// In en, this message translates to:
  /// **'{count} selected'**
  String countSelected(int count);

  /// No description provided for @runFirstSelected.
  ///
  /// In en, this message translates to:
  /// **'Run first selected'**
  String get runFirstSelected;

  /// No description provided for @armSessionToRun.
  ///
  /// In en, this message translates to:
  /// **'Arm session to run'**
  String get armSessionToRun;

  /// No description provided for @deleteSelected.
  ///
  /// In en, this message translates to:
  /// **'Delete selected'**
  String get deleteSelected;

  /// No description provided for @githubStore.
  ///
  /// In en, this message translates to:
  /// **'GitHub Store'**
  String get githubStore;

  /// No description provided for @exportAll.
  ///
  /// In en, this message translates to:
  /// **'Export all'**
  String get exportAll;

  /// No description provided for @importFromClipboard.
  ///
  /// In en, this message translates to:
  /// **'Import from clipboard'**
  String get importFromClipboard;

  /// No description provided for @manageSources.
  ///
  /// In en, this message translates to:
  /// **'Manage sources'**
  String get manageSources;

  /// No description provided for @selectMultiple.
  ///
  /// In en, this message translates to:
  /// **'Select multiple'**
  String get selectMultiple;

  /// No description provided for @tipImportPayloadsFromTheGitHubStore.
  ///
  /// In en, this message translates to:
  /// **'Tip: Import payloads from the GitHub Store'**
  String get tipImportPayloadsFromTheGitHubStore;

  /// No description provided for @open.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get open;

  /// No description provided for @searching.
  ///
  /// In en, this message translates to:
  /// **'Searching: \"{query}\"'**
  String searching(String query);

  /// No description provided for @newPayload.
  ///
  /// In en, this message translates to:
  /// **'New Payload'**
  String get newPayload;

  /// No description provided for @payloadDuplicated.
  ///
  /// In en, this message translates to:
  /// **'Payload duplicated'**
  String get payloadDuplicated;

  /// No description provided for @deletePayload.
  ///
  /// In en, this message translates to:
  /// **'Delete payload'**
  String get deletePayload;

  /// No description provided for @deletePayloadThisCanNotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'Delete \"{name}\"? This cannot be undone.'**
  String deletePayloadThisCanNotBeUndone(String name);

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @deletePayloads.
  ///
  /// In en, this message translates to:
  /// **'Delete payloads'**
  String get deletePayloads;

  /// No description provided for @deleteCountPayloadsThisCanNotBeUndone.
  ///
  /// In en, this message translates to:
  /// **'Delete {count} payload{count,plural, one{} other {s}}? This cannot be undone.'**
  String deleteCountPayloadsThisCanNotBeUndone(int count);

  /// No description provided for @importPayloads.
  ///
  /// In en, this message translates to:
  /// **'Import payload(s)'**
  String get importPayloads;

  /// No description provided for @pastePayloadJSONOrAPayloadPackJSONBelow.
  ///
  /// In en, this message translates to:
  /// **'Paste payload JSON or a payload pack JSON below:'**
  String get pastePayloadJSONOrAPayloadPackJSONBelow;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @noPayloadsFoundInInput.
  ///
  /// In en, this message translates to:
  /// **'No payloads found in input.'**
  String get noPayloadsFoundInInput;

  /// No description provided for @importedCountPayloads.
  ///
  /// In en, this message translates to:
  /// **'Imported {count} payload{count,plural, one{} other {s}}.'**
  String importedCountPayloads(int count);

  /// No description provided for @importFailedError.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailedError(String error);

  /// No description provided for @searchPayloads.
  ///
  /// In en, this message translates to:
  /// **'Search payloads'**
  String get searchPayloads;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @nameTagsScriptContent.
  ///
  /// In en, this message translates to:
  /// **'Name, tags, script content...'**
  String get nameTagsScriptContent;

  /// No description provided for @all.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get all;

  /// No description provided for @collapse.
  ///
  /// In en, this message translates to:
  /// **'Collapse'**
  String get collapse;

  /// No description provided for @expandPreview.
  ///
  /// In en, this message translates to:
  /// **'Expand preview'**
  String get expandPreview;

  /// No description provided for @scriptPreview.
  ///
  /// In en, this message translates to:
  /// **'Script preview'**
  String get scriptPreview;

  /// No description provided for @duplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get duplicate;

  /// No description provided for @export.
  ///
  /// In en, this message translates to:
  /// **'Export'**
  String get export;

  /// No description provided for @yourScriptLibrary.
  ///
  /// In en, this message translates to:
  /// **'Your Script Library'**
  String get yourScriptLibrary;

  /// No description provided for @createOrganizeAndExecuteYourCustomHIDPayloads.
  ///
  /// In en, this message translates to:
  /// **'Create, organize, and execute your custom HID payloads'**
  String get createOrganizeAndExecuteYourCustomHIDPayloads;

  /// No description provided for @createAPayload.
  ///
  /// In en, this message translates to:
  /// **'Create a Payload'**
  String get createAPayload;

  /// No description provided for @writeDuckyScriptCommandsOrUseTemplates.
  ///
  /// In en, this message translates to:
  /// **'Write DuckyScript commands or use templates'**
  String get writeDuckyScriptCommandsOrUseTemplates;

  /// No description provided for @organizeWithTags.
  ///
  /// In en, this message translates to:
  /// **'Organize with Tags'**
  String get organizeWithTags;

  /// No description provided for @groupPayloadsByCategoryOrPurpose.
  ///
  /// In en, this message translates to:
  /// **'Group payloads by category or purpose'**
  String get groupPayloadsByCategoryOrPurpose;

  /// No description provided for @executeAndShare.
  ///
  /// In en, this message translates to:
  /// **'Execute & Share'**
  String get executeAndShare;

  /// No description provided for @runOnTargetOrExportToShare.
  ///
  /// In en, this message translates to:
  /// **'Run on target or export to share'**
  String get runOnTargetOrExportToShare;

  /// No description provided for @createYourFirstPayload.
  ///
  /// In en, this message translates to:
  /// **'Create Your First Payload'**
  String get createYourFirstPayload;

  /// No description provided for @importExistingPayloads.
  ///
  /// In en, this message translates to:
  /// **'Import Existing Payloads'**
  String get importExistingPayloads;

  /// No description provided for @noPayloadsFound.
  ///
  /// In en, this message translates to:
  /// **'No payloads found'**
  String get noPayloadsFound;

  /// No description provided for @noResultsForQuery.
  ///
  /// In en, this message translates to:
  /// **'No result for \"{query}\"'**
  String noResultsForQuery(String query);

  /// No description provided for @noPayloadsWithTag.
  ///
  /// In en, this message translates to:
  /// **'No payloads with tag \"{tag}\"'**
  String noPayloadsWithTag(String tag);

  /// No description provided for @tryAdjustingYourFilters.
  ///
  /// In en, this message translates to:
  /// **'Try adjusting your filters'**
  String get tryAdjustingYourFilters;

  /// No description provided for @clearFilters.
  ///
  /// In en, this message translates to:
  /// **'Clear Filters'**
  String get clearFilters;

  /// No description provided for @discardChanges.
  ///
  /// In en, this message translates to:
  /// **'Discard changes?'**
  String get discardChanges;

  /// No description provided for @youHaveUnsavedChangesDiscardThem.
  ///
  /// In en, this message translates to:
  /// **'You have unsaved changes. Discard them?'**
  String get youHaveUnsavedChangesDiscardThem;

  /// No description provided for @showValidationIssues.
  ///
  /// In en, this message translates to:
  /// **'Show validation issues'**
  String get showValidationIssues;

  /// No description provided for @thisIsABuiltInPayload.
  ///
  /// In en, this message translates to:
  /// **'This is a built-in payload. You can duplicate it to create a custom version.'**
  String get thisIsABuiltInPayload;

  /// No description provided for @basicInfo.
  ///
  /// In en, this message translates to:
  /// **'Basic Info'**
  String get basicInfo;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @egWindowsRunDialog.
  ///
  /// In en, this message translates to:
  /// **'e.g., Windows Run Dialog'**
  String get egWindowsRunDialog;

  /// No description provided for @nameIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get nameIsRequired;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @whatDoesThisPayloadDo.
  ///
  /// In en, this message translates to:
  /// **'What does this payload do?'**
  String get whatDoesThisPayloadDo;

  /// No description provided for @tags.
  ///
  /// In en, this message translates to:
  /// **'Tags'**
  String get tags;

  /// No description provided for @windowsReconExfilCommaSeparated.
  ///
  /// In en, this message translates to:
  /// **'windows, recon, exfil (comma-separated)'**
  String get windowsReconExfilCommaSeparated;

  /// No description provided for @script.
  ///
  /// In en, this message translates to:
  /// **'Script'**
  String get script;

  /// No description provided for @syntax.
  ///
  /// In en, this message translates to:
  /// **'Syntax'**
  String get syntax;

  /// No description provided for @helloWorld.
  ///
  /// In en, this message translates to:
  /// **'Hello World'**
  String get helloWorld;

  /// No description provided for @scriptIsRequired.
  ///
  /// In en, this message translates to:
  /// **'Script is required'**
  String get scriptIsRequired;

  /// No description provided for @usePARAM_NAMEForDynamicValues.
  ///
  /// In en, this message translates to:
  /// **'Use {PARAM_NAME} for dynamic values'**
  String usePARAM_NAMEForDynamicValues(String PARAM_NAME);

  /// No description provided for @parametersCount.
  ///
  /// In en, this message translates to:
  /// **'Parameters ({count})'**
  String parametersCount(int count);

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @noParameters.
  ///
  /// In en, this message translates to:
  /// **'No parameters'**
  String get noParameters;

  /// No description provided for @addParametersToMakeThispayloadReusableWithDifferentValues.
  ///
  /// In en, this message translates to:
  /// **'Add parameters to make this payload reusable with different values.'**
  String get addParametersToMakeThispayloadReusableWithDifferentValues;

  /// No description provided for @quickActions.
  ///
  /// In en, this message translates to:
  /// **'Quick Actions'**
  String get quickActions;

  /// No description provided for @createACopyOfThisPayload.
  ///
  /// In en, this message translates to:
  /// **'Create a copy of this payload'**
  String get createACopyOfThisPayload;

  /// No description provided for @shareAsJSON.
  ///
  /// In en, this message translates to:
  /// **'Share as JSON'**
  String get shareAsJSON;

  /// No description provided for @removeThisPayloadPermanently.
  ///
  /// In en, this message translates to:
  /// **'Remove this payload permanently'**
  String get removeThisPayloadPermanently;

  /// No description provided for @cannotSaveScriptHasValidationErrors.
  ///
  /// In en, this message translates to:
  /// **'Cannot save: script has validation errors'**
  String get cannotSaveScriptHasValidationErrors;

  /// No description provided for @payloadCreated.
  ///
  /// In en, this message translates to:
  /// **'Payload created'**
  String get payloadCreated;

  /// No description provided for @payloadUpdated.
  ///
  /// In en, this message translates to:
  /// **'Payload updated'**
  String get payloadUpdated;

  /// No description provided for @duckyScriptSyntax.
  ///
  /// In en, this message translates to:
  /// **'DuckyScript Syntax'**
  String get duckyScriptSyntax;

  /// No description provided for @keystrokeInjection.
  ///
  /// In en, this message translates to:
  /// **'Keystroke Injection'**
  String get keystrokeInjection;

  /// No description provided for @text.
  ///
  /// In en, this message translates to:
  /// **'text'**
  String get text;

  /// No description provided for @typeText.
  ///
  /// In en, this message translates to:
  /// **'Type text'**
  String get typeText;

  /// No description provided for @typeTextPlusEnter.
  ///
  /// In en, this message translates to:
  /// **'Type text + Enter'**
  String get typeTextPlusEnter;

  /// No description provided for @ms.
  ///
  /// In en, this message translates to:
  /// **'ms'**
  String get ms;

  /// No description provided for @waitMilliseconds.
  ///
  /// In en, this message translates to:
  /// **'Wait milliseconds'**
  String get waitMilliseconds;

  /// No description provided for @pressEnter.
  ///
  /// In en, this message translates to:
  /// **'Press Enter'**
  String get pressEnter;

  /// No description provided for @pressTab.
  ///
  /// In en, this message translates to:
  /// **'Press Tab'**
  String get pressTab;

  /// No description provided for @pressEscape.
  ///
  /// In en, this message translates to:
  /// **'Press Escape'**
  String get pressEscape;

  /// No description provided for @pressBackspace.
  ///
  /// In en, this message translates to:
  /// **'Press Backspace'**
  String get pressBackspace;

  /// No description provided for @pressDelete.
  ///
  /// In en, this message translates to:
  /// **'Press Delete'**
  String get pressDelete;

  /// No description provided for @parameterPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Parameter placeholder'**
  String get parameterPlaceholder;

  /// No description provided for @defineVariable.
  ///
  /// In en, this message translates to:
  /// **'Define variable'**
  String get defineVariable;

  /// No description provided for @defineConstant.
  ///
  /// In en, this message translates to:
  /// **'Define constant'**
  String get defineConstant;

  /// No description provided for @close.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get close;

  /// No description provided for @scriptHasErrors.
  ///
  /// In en, this message translates to:
  /// **'Script has errors'**
  String get scriptHasErrors;

  /// No description provided for @scriptHasWarnings.
  ///
  /// In en, this message translates to:
  /// **'Script has Warnings'**
  String get scriptHasWarnings;

  /// No description provided for @scriptIsValid.
  ///
  /// In en, this message translates to:
  /// **'Script is Valid'**
  String get scriptIsValid;

  /// No description provided for @countCommands.
  ///
  /// In en, this message translates to:
  /// **'{count} command{count,plural, one{} other{s}}'**
  String countCommands(int count);

  /// No description provided for @countErrors.
  ///
  /// In en, this message translates to:
  /// **'{count} error{count,plural, one{} other{s}}'**
  String countErrors(int count);

  /// No description provided for @countWarnings.
  ///
  /// In en, this message translates to:
  /// **'{count} warning{count,plural, one{} other{s}}'**
  String countWarnings(int count);

  /// No description provided for @validationResults.
  ///
  /// In en, this message translates to:
  /// **'Validation Results'**
  String get validationResults;

  /// No description provided for @totalDelays.
  ///
  /// In en, this message translates to:
  /// **'Total delays: {sec}s'**
  String totalDelays(String sec);

  /// No description provided for @noIssuesFoundScriptIsValid.
  ///
  /// In en, this message translates to:
  /// **'No issues found. Script is valid!'**
  String get noIssuesFoundScriptIsValid;

  /// No description provided for @issuesCount.
  ///
  /// In en, this message translates to:
  /// **'Issues {count}'**
  String issuesCount(int count);

  /// No description provided for @lineNum.
  ///
  /// In en, this message translates to:
  /// **'Line {num}'**
  String lineNum(int num);

  /// No description provided for @paramRequired.
  ///
  /// In en, this message translates to:
  /// **'required'**
  String get paramRequired;

  /// No description provided for @addParameter.
  ///
  /// In en, this message translates to:
  /// **'Add Parameter'**
  String get addParameter;

  /// No description provided for @editParameter.
  ///
  /// In en, this message translates to:
  /// **'Edit Parameter'**
  String get editParameter;

  /// No description provided for @key.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get key;

  /// No description provided for @requiredCap.
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get requiredCap;

  /// No description provided for @label.
  ///
  /// In en, this message translates to:
  /// **'Label'**
  String get label;

  /// No description provided for @targetIPAddress.
  ///
  /// In en, this message translates to:
  /// **'Target IP Address'**
  String get targetIPAddress;

  /// No description provided for @optionalDescription.
  ///
  /// In en, this message translates to:
  /// **'Optional description'**
  String get optionalDescription;

  /// No description provided for @textCap.
  ///
  /// In en, this message translates to:
  /// **'Text'**
  String get textCap;

  /// No description provided for @number.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get number;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @type.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get type;

  /// No description provided for @defaultValue.
  ///
  /// In en, this message translates to:
  /// **'Default Value'**
  String get defaultValue;

  /// No description provided for @keyboardOnly.
  ///
  /// In en, this message translates to:
  /// **'Keyboard Only'**
  String get keyboardOnly;

  /// No description provided for @mouseOnly.
  ///
  /// In en, this message translates to:
  /// **'Mouse Only'**
  String get mouseOnly;

  /// No description provided for @compositeKeyboardMouse.
  ///
  /// In en, this message translates to:
  /// **'Composite (Keyboard + Mouse)'**
  String get compositeKeyboardMouse;

  /// No description provided for @keyboardProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Single HID keyboard device. Use for typing and key combinations.'**
  String get keyboardProfileDescription;

  /// No description provided for @mouseProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Single HID mouse device. Use for cursor movement and clicks.'**
  String get mouseProfileDescription;

  /// No description provided for @compositeProfileDescription.
  ///
  /// In en, this message translates to:
  /// **'Combined keyboard and mouse. Recommended for most payloads.'**
  String get compositeProfileDescription;

  /// No description provided for @selectUSBGadgetProfile.
  ///
  /// In en, this message translates to:
  /// **'Select USB Gadget Profile'**
  String get selectUSBGadgetProfile;

  /// No description provided for @chooseTheHIDDeviceTypeToActivate.
  ///
  /// In en, this message translates to:
  /// **'Choose the HID device type to activate:'**
  String get chooseTheHIDDeviceTypeToActivate;

  /// No description provided for @activate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get activate;

  /// No description provided for @recommended.
  ///
  /// In en, this message translates to:
  /// **'RECOMMENDED'**
  String get recommended;

  /// No description provided for @clearLogs.
  ///
  /// In en, this message translates to:
  /// **'Clear logs'**
  String get clearLogs;

  /// No description provided for @deleteAllStoredLogs.
  ///
  /// In en, this message translates to:
  /// **'Delete all stored logs?'**
  String get deleteAllStoredLogs;

  /// No description provided for @clear.
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get clear;

  /// No description provided for @clearAll.
  ///
  /// In en, this message translates to:
  /// **'Clear all'**
  String get clearAll;

  /// No description provided for @level.
  ///
  /// In en, this message translates to:
  /// **'Level:'**
  String get level;

  /// No description provided for @failedToLoadLogsError.
  ///
  /// In en, this message translates to:
  /// **'Failed to load logs: {error}'**
  String failedToLoadLogsError(String error);

  /// No description provided for @noLogsYet.
  ///
  /// In en, this message translates to:
  /// **'No logs yet'**
  String get noLogsYet;

  /// No description provided for @noMatchingLogs.
  ///
  /// In en, this message translates to:
  /// **'No matching logs'**
  String get noMatchingLogs;

  /// No description provided for @runAPayloadToGenerateLogs.
  ///
  /// In en, this message translates to:
  /// **'Run a payload to generate logs.'**
  String get runAPayloadToGenerateLogs;

  /// No description provided for @changeTheLevelFilterToSeeMoreEntries.
  ///
  /// In en, this message translates to:
  /// **'Change the level filter to see more entries.'**
  String get changeTheLevelFilterToSeeMoreEntries;

  /// No description provided for @logEntry.
  ///
  /// In en, this message translates to:
  /// **'Log entry'**
  String get logEntry;

  /// No description provided for @share.
  ///
  /// In en, this message translates to:
  /// **'Share'**
  String get share;

  /// No description provided for @failedToLoadLogs.
  ///
  /// In en, this message translates to:
  /// **'Failed to load logs: {error}'**
  String failedToLoadLogs(String error);

  /// No description provided for @logEntryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Log entry not found.'**
  String get logEntryNotFound;

  /// No description provided for @metadata.
  ///
  /// In en, this message translates to:
  /// **'Metadata'**
  String get metadata;

  /// No description provided for @noMetadata.
  ///
  /// In en, this message translates to:
  /// **'No metadata'**
  String get noMetadata;

  /// No description provided for @failedToLoadHistory.
  ///
  /// In en, this message translates to:
  /// **'Failed to load history'**
  String get failedToLoadHistory;

  /// No description provided for @noExecutionHistory.
  ///
  /// In en, this message translates to:
  /// **'No execution history'**
  String get noExecutionHistory;

  /// No description provided for @runAPayloadToSeeExecutionHistoryHere.
  ///
  /// In en, this message translates to:
  /// **'Run a payload to see execution history here.'**
  String get runAPayloadToSeeExecutionHistoryHere;

  /// No description provided for @clearExecutionHistory.
  ///
  /// In en, this message translates to:
  /// **'Clear execution history'**
  String get clearExecutionHistory;

  /// No description provided for @thisWillDeleteAllExecutionLogs.
  ///
  /// In en, this message translates to:
  /// **'This will delete all execution logs. This cannot be undone.'**
  String get thisWillDeleteAllExecutionLogs;

  /// No description provided for @total.
  ///
  /// In en, this message translates to:
  /// **'Total'**
  String get total;

  /// No description provided for @success.
  ///
  /// In en, this message translates to:
  /// **'Success'**
  String get success;

  /// No description provided for @failed.
  ///
  /// In en, this message translates to:
  /// **'Failed'**
  String get failed;

  /// No description provided for @hour.
  ///
  /// In en, this message translates to:
  /// **'h'**
  String get hour;

  /// No description provided for @countEvents.
  ///
  /// In en, this message translates to:
  /// **'{count} event{count,plural, one{} other{s}}'**
  String countEvents(int count);

  /// No description provided for @executionDetails.
  ///
  /// In en, this message translates to:
  /// **'Execution Details'**
  String get executionDetails;

  /// No description provided for @executionID.
  ///
  /// In en, this message translates to:
  /// **'Execution ID'**
  String get executionID;

  /// No description provided for @started.
  ///
  /// In en, this message translates to:
  /// **'Started'**
  String get started;

  /// No description provided for @finished.
  ///
  /// In en, this message translates to:
  /// **'Finished'**
  String get finished;

  /// No description provided for @duration.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get duration;

  /// No description provided for @eventsCount.
  ///
  /// In en, this message translates to:
  /// **'Events {count}'**
  String eventsCount(int count);

  /// No description provided for @sAgo.
  ///
  /// In en, this message translates to:
  /// **'s ago'**
  String get sAgo;

  /// No description provided for @mAgo.
  ///
  /// In en, this message translates to:
  /// **'m ago'**
  String get mAgo;

  /// No description provided for @hAgo.
  ///
  /// In en, this message translates to:
  /// **'h ago'**
  String get hAgo;

  /// No description provided for @dAgo.
  ///
  /// In en, this message translates to:
  /// **'d ago'**
  String get dAgo;

  /// No description provided for @unknownCommand.
  ///
  /// In en, this message translates to:
  /// **'Unknown command: {command}'**
  String unknownCommand(String command);

  /// No description provided for @didYouMean.
  ///
  /// In en, this message translates to:
  /// **'Did you mean {name}?'**
  String didYouMean(String name);

  /// No description provided for @stringDelayRequiresANumericDelayValue.
  ///
  /// In en, this message translates to:
  /// **'STRING_DELAY requires a numeric delay value'**
  String get stringDelayRequiresANumericDelayValue;

  /// No description provided for @exampleStringDelay100Hello.
  ///
  /// In en, this message translates to:
  /// **'Example: STRING_DELAY 100 Hello'**
  String get exampleStringDelay100Hello;

  /// No description provided for @exampleStringDelay50.
  ///
  /// In en, this message translates to:
  /// **'Example: STRING_DELAY 50'**
  String get exampleStringDelay50;

  /// No description provided for @defaultDelayRequiresANumericValue.
  ///
  /// In en, this message translates to:
  /// **'DEFAULTDELAY requires a numeric value'**
  String get defaultDelayRequiresANumericValue;

  /// No description provided for @delayRequiresATimeValueInMilliseconds.
  ///
  /// In en, this message translates to:
  /// **'DELAY requires a time value in milliseconds'**
  String get delayRequiresATimeValueInMilliseconds;

  /// No description provided for @exampleDelay500.
  ///
  /// In en, this message translates to:
  /// **'Example: DELAY 500'**
  String get exampleDelay500;

  /// No description provided for @delayValueMustBeANumberOrVariable.
  ///
  /// In en, this message translates to:
  /// **'DELAY value must be a number or variable'**
  String get delayValueMustBeANumberOrVariable;

  /// No description provided for @exampleDelay500OrDelayMyDelay.
  ///
  /// In en, this message translates to:
  /// **'Example: DELAY 500 or DELAY \$MY_DELAY'**
  String get exampleDelay500OrDelayMyDelay;

  /// No description provided for @delayMinimumValueIsMS.
  ///
  /// In en, this message translates to:
  /// **'DELAY minimum value is {min_ms}ms'**
  String delayMinimumValueIsMS(int min_ms);

  /// No description provided for @useDelayMinMSOrHigher.
  ///
  /// In en, this message translates to:
  /// **'Use DELAY {min_ms} or higher'**
  String useDelayMinMSOrHigher(int min_ms);

  /// No description provided for @waitForTargetNotRecognized.
  ///
  /// In en, this message translates to:
  /// **'WAIT_FOR target not recognized: {target}'**
  String waitForTargetNotRecognized(String target);

  /// No description provided for @useHostConnectedEtc.
  ///
  /// In en, this message translates to:
  /// **'Use HOST_CONNECTED, UDC_CONFIGURED, KEYBOARD_READY, MOUSE_READY, or SESSION_ARMED'**
  String get useHostConnectedEtc;

  /// No description provided for @defineRequiresANameAndValue.
  ///
  /// In en, this message translates to:
  /// **'DEFINE requires a name and value'**
  String get defineRequiresANameAndValue;

  /// No description provided for @exampleDefineAppNotepad.
  ///
  /// In en, this message translates to:
  /// **'Example: DEFINE APP notepad'**
  String get exampleDefineAppNotepad;

  /// No description provided for @varRequiresAVariableName.
  ///
  /// In en, this message translates to:
  /// **'VAR requires a variable name'**
  String get varRequiresAVariableName;

  /// No description provided for @exampleVarCounter0.
  ///
  /// In en, this message translates to:
  /// **'Example: VAR \$counter = 0'**
  String get exampleVarCounter0;

  /// No description provided for @variableNameMustStartWithDollar.
  ///
  /// In en, this message translates to:
  /// **'Variable name must start with \$'**
  String get variableNameMustStartWithDollar;

  /// No description provided for @functionRequiresAName.
  ///
  /// In en, this message translates to:
  /// **'FUNCTION requires a name'**
  String get functionRequiresAName;

  /// No description provided for @exampleFunctionMyFunction.
  ///
  /// In en, this message translates to:
  /// **'Example: FUNCTION my_function'**
  String get exampleFunctionMyFunction;

  /// No description provided for @endFunctionWithoutMatchingFunction.
  ///
  /// In en, this message translates to:
  /// **'END_FUNCTION without matching FUNCTION'**
  String get endFunctionWithoutMatchingFunction;

  /// No description provided for @returnOutsideOfFunction.
  ///
  /// In en, this message translates to:
  /// **'RETURN outside of FUNCTION'**
  String get returnOutsideOfFunction;

  /// No description provided for @elseWithoutMatchingIf.
  ///
  /// In en, this message translates to:
  /// **'ELSE without matching IF'**
  String get elseWithoutMatchingIf;

  /// No description provided for @endIfWithoutMatchingIf.
  ///
  /// In en, this message translates to:
  /// **'END_IF without matching IF'**
  String get endIfWithoutMatchingIf;

  /// No description provided for @endWhileWithoutMatchingWhile.
  ///
  /// In en, this message translates to:
  /// **'END_WHILE without matching WHILE'**
  String get endWhileWithoutMatchingWhile;

  /// No description provided for @catchWithoutMatchingTry.
  ///
  /// In en, this message translates to:
  /// **'CATCH without matching TRY'**
  String get catchWithoutMatchingTry;

  /// No description provided for @endTryWithoutMatchingTry.
  ///
  /// In en, this message translates to:
  /// **'END_TRY without matching TRY'**
  String get endTryWithoutMatchingTry;

  /// No description provided for @repeatRequiresANumericCount.
  ///
  /// In en, this message translates to:
  /// **'REPEAT requires a numeric count'**
  String get repeatRequiresANumericCount;

  /// No description provided for @exampleRepeat5.
  ///
  /// In en, this message translates to:
  /// **'Example: REPEAT 5'**
  String get exampleRepeat5;

  /// No description provided for @mouseRequiresAnAction.
  ///
  /// In en, this message translates to:
  /// **'MOUSE requires an action (CLICK, MOVE, SCROLL, etc.)'**
  String get mouseRequiresAnAction;

  /// No description provided for @functionNotDeclaredInThisScript.
  ///
  /// In en, this message translates to:
  /// **'Function {func_name} not declared in this script'**
  String functionNotDeclaredInThisScript(String func_name);

  /// No description provided for @declareItWithFunction.
  ///
  /// In en, this message translates to:
  /// **'Declare it with: FUNCTION {func_name}'**
  String declareItWithFunction(String func_name);

  /// No description provided for @countUnclosedIfStatements.
  ///
  /// In en, this message translates to:
  /// **'{count} unclosed IF statement{count,plural, one{} other{s}}'**
  String countUnclosedIfStatements(int count);

  /// No description provided for @addEndIfForEachIf.
  ///
  /// In en, this message translates to:
  /// **'Add END_IF for each IF'**
  String get addEndIfForEachIf;

  /// No description provided for @countUnclosedWhileLoops.
  ///
  /// In en, this message translates to:
  /// **'{count} unclosed WHILE loop{count,plural, one{} other{s}}'**
  String countUnclosedWhileLoops(int count);

  /// No description provided for @addEndWhileForEachWhile.
  ///
  /// In en, this message translates to:
  /// **'Add END_WHILE for each WHILE'**
  String get addEndWhileForEachWhile;

  /// No description provided for @countUnclosedFunctions.
  ///
  /// In en, this message translates to:
  /// **'{count} unclosed function{count,plural, one{} other{s}}'**
  String countUnclosedFunctions(int count);

  /// No description provided for @addEndFunctionForEachFunction.
  ///
  /// In en, this message translates to:
  /// **'Add END_FUNCTION for each FUNCTION'**
  String get addEndFunctionForEachFunction;

  /// No description provided for @countUnclosedTryBlocks.
  ///
  /// In en, this message translates to:
  /// **'{count} unclosed TRY block{count,plural, one{} other{s}}'**
  String countUnclosedTryBlocks(int count);

  /// No description provided for @addEndTryForEachTry.
  ///
  /// In en, this message translates to:
  /// **'Add END_TRY for each TRY'**
  String get addEndTryForEachTry;

  /// No description provided for @unclosedRemBlock.
  ///
  /// In en, this message translates to:
  /// **'Unclosed REM_BLOCK (missing END_REM)'**
  String get unclosedRemBlock;

  /// No description provided for @unclosedStringBlock.
  ///
  /// In en, this message translates to:
  /// **'Unclosed STRING block (missing END_STRING)'**
  String get unclosedStringBlock;

  /// No description provided for @unclosedStringlnBlock.
  ///
  /// In en, this message translates to:
  /// **'Unclosed STRINGLN block (missing END_STRINGLN)'**
  String get unclosedStringlnBlock;

  /// No description provided for @discard.
  ///
  /// In en, this message translates to:
  /// **'Discard'**
  String get discard;

  /// No description provided for @sources.
  ///
  /// In en, this message translates to:
  /// **'Sources'**
  String get sources;

  /// No description provided for @showAllIncludingHidden.
  ///
  /// In en, this message translates to:
  /// **'Show all (including hidden)'**
  String get showAllIncludingHidden;

  /// No description provided for @hideMedia.
  ///
  /// In en, this message translates to:
  /// **'Hide media'**
  String get hideMedia;

  /// No description provided for @showMedia.
  ///
  /// In en, this message translates to:
  /// **'Show media'**
  String get showMedia;

  /// No description provided for @refresh.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get refresh;

  /// No description provided for @repositoryControls.
  ///
  /// In en, this message translates to:
  /// **'Repository controls'**
  String get repositoryControls;

  /// No description provided for @folders.
  ///
  /// In en, this message translates to:
  /// **'Folders'**
  String get folders;

  /// No description provided for @files.
  ///
  /// In en, this message translates to:
  /// **'Files'**
  String get files;

  /// No description provided for @pasteAGitHubURLFirst.
  ///
  /// In en, this message translates to:
  /// **'Paste a GitHub URL first'**
  String get pasteAGitHubURLFirst;

  /// No description provided for @invalidGitHubURL.
  ///
  /// In en, this message translates to:
  /// **'Invalid GitHub URL. Expected repo or folder URL.'**
  String get invalidGitHubURL;

  /// No description provided for @sourceAdded.
  ///
  /// In en, this message translates to:
  /// **'Source added'**
  String get sourceAdded;

  /// No description provided for @noSourcesSavedYet.
  ///
  /// In en, this message translates to:
  /// **'No sources saved yet'**
  String get noSourcesSavedYet;

  /// No description provided for @chooseSource.
  ///
  /// In en, this message translates to:
  /// **'Choose source'**
  String get chooseSource;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @noRepoSelected.
  ///
  /// In en, this message translates to:
  /// **'No repo selected'**
  String get noRepoSelected;

  /// No description provided for @pasteAURLBrowseThenImportPayloads.
  ///
  /// In en, this message translates to:
  /// **'Paste a URL, browse, then import payloads.'**
  String get pasteAURLBrowseThenImportPayloads;

  /// No description provided for @pickFromSavedSources.
  ///
  /// In en, this message translates to:
  /// **'Pick from saved sources'**
  String get pickFromSavedSources;

  /// No description provided for @browse.
  ///
  /// In en, this message translates to:
  /// **'Browse'**
  String get browse;

  /// No description provided for @saveSource.
  ///
  /// In en, this message translates to:
  /// **'Save source'**
  String get saveSource;

  /// No description provided for @upOneFolder.
  ///
  /// In en, this message translates to:
  /// **'Up one folder'**
  String get upOneFolder;

  /// No description provided for @repositoryRoot.
  ///
  /// In en, this message translates to:
  /// **'Repository root'**
  String get repositoryRoot;

  /// No description provided for @searchFilesAndFolders.
  ///
  /// In en, this message translates to:
  /// **'Search files and folders'**
  String get searchFilesAndFolders;

  /// No description provided for @importable.
  ///
  /// In en, this message translates to:
  /// **'Importable'**
  String get importable;

  /// No description provided for @notSupported.
  ///
  /// In en, this message translates to:
  /// **'Not supported'**
  String get notSupported;

  /// No description provided for @converted.
  ///
  /// In en, this message translates to:
  /// **'Converted'**
  String get converted;

  /// No description provided for @browseAGitHubRepository.
  ///
  /// In en, this message translates to:
  /// **'Browse a GitHub repository'**
  String get browseAGitHubRepository;

  /// No description provided for @pasteARepoOrFolderURL.
  ///
  /// In en, this message translates to:
  /// **'Paste a repo or folder URL, browse files, and import supported payload formats.'**
  String get pasteARepoOrFolderURL;

  /// No description provided for @pasteExampleURL.
  ///
  /// In en, this message translates to:
  /// **'Paste example URL'**
  String get pasteExampleURL;

  /// No description provided for @noMatchingFilesOrFolders.
  ///
  /// In en, this message translates to:
  /// **'No matching files or folders'**
  String get noMatchingFilesOrFolders;

  /// No description provided for @failedToLoad.
  ///
  /// In en, this message translates to:
  /// **'Failed to load'**
  String get failedToLoad;

  /// No description provided for @line.
  ///
  /// In en, this message translates to:
  /// **'Line {line}: {message}'**
  String line(String line, String message);

  /// No description provided for @moreThreePoints.
  ///
  /// In en, this message translates to:
  /// **'more…'**
  String get moreThreePoints;

  /// No description provided for @noRepositorySelected.
  ///
  /// In en, this message translates to:
  /// **'No repository selected'**
  String get noRepositorySelected;

  /// No description provided for @noPreviewData.
  ///
  /// In en, this message translates to:
  /// **'No preview data'**
  String get noPreviewData;

  /// No description provided for @copyConverted.
  ///
  /// In en, this message translates to:
  /// **'Copy converted'**
  String get copyConverted;

  /// No description provided for @convertedCopied.
  ///
  /// In en, this message translates to:
  /// **'Converted copied'**
  String get convertedCopied;

  /// No description provided for @copyOriginal.
  ///
  /// In en, this message translates to:
  /// **'Copy original'**
  String get copyOriginal;

  /// No description provided for @originalCopied.
  ///
  /// In en, this message translates to:
  /// **'Original copied'**
  String get originalCopied;

  /// No description provided for @disableWrap.
  ///
  /// In en, this message translates to:
  /// **'Disable wrap'**
  String get disableWrap;

  /// No description provided for @enableWrap.
  ///
  /// In en, this message translates to:
  /// **'Enable wrap'**
  String get enableWrap;

  /// No description provided for @validationSummary.
  ///
  /// In en, this message translates to:
  /// **'Validation summary'**
  String get validationSummary;

  /// No description provided for @importedDuckyScript.
  ///
  /// In en, this message translates to:
  /// **'Imported Ducky Script'**
  String get importedDuckyScript;

  /// No description provided for @importedFrom.
  ///
  /// In en, this message translates to:
  /// **'Imported from: {owner}{repo}'**
  String importedFrom(String owner, String repo);

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'source: {name}'**
  String source(String name);

  /// No description provided for @unsupportedFormat.
  ///
  /// In en, this message translates to:
  /// **'Unsupported format'**
  String get unsupportedFormat;

  /// No description provided for @importedSuccessfully.
  ///
  /// In en, this message translates to:
  /// **'Imported successfully'**
  String get importedSuccessfully;

  /// No description provided for @importFailed.
  ///
  /// In en, this message translates to:
  /// **'Import failed: {error}'**
  String importFailed(String error);

  /// No description provided for @executingThreePoints.
  ///
  /// In en, this message translates to:
  /// **'Executing'**
  String get executingThreePoints;

  /// No description provided for @repositoryNotFound.
  ///
  /// In en, this message translates to:
  /// **'Repository not found'**
  String get repositoryNotFound;

  /// No description provided for @gitHubAPIRateLimitReached.
  ///
  /// In en, this message translates to:
  /// **'GitHub API rate limit reached'**
  String get gitHubAPIRateLimitReached;

  /// No description provided for @repositoryBranchOrFolderNotFound.
  ///
  /// In en, this message translates to:
  /// **'Repository, branch, or folder not found'**
  String get repositoryBranchOrFolderNotFound;

  /// No description provided for @expectedADirectoryListing.
  ///
  /// In en, this message translates to:
  /// **'Expected a directory listing'**
  String get expectedADirectoryListing;

  /// No description provided for @fileNotFound.
  ///
  /// In en, this message translates to:
  /// **'File not found'**
  String get fileNotFound;

  /// No description provided for @fileTooLargeToPreview.
  ///
  /// In en, this message translates to:
  /// **'File too large to preview/import (max 256KB)'**
  String get fileTooLargeToPreview;

  /// No description provided for @failedToFetchRaw.
  ///
  /// In en, this message translates to:
  /// **'Failed to fetch raw'**
  String get failedToFetchRaw;

  /// No description provided for @noContent.
  ///
  /// In en, this message translates to:
  /// **'No content'**
  String get noContent;

  /// No description provided for @onlyGitHubLinksAreSupported.
  ///
  /// In en, this message translates to:
  /// **'Only GitHub links are supported'**
  String get onlyGitHubLinksAreSupported;

  /// No description provided for @tapDuckyfailedToStart.
  ///
  /// In en, this message translates to:
  /// **'TapDucky failed to start'**
  String get tapDuckyfailedToStart;
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
