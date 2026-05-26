// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get dashboard => 'Dashboard';

  @override
  String get payloads => 'Payloads';

  @override
  String get execute => 'Execute';

  @override
  String get schedule => 'Schedule';

  @override
  String get settings => 'Settings';

  @override
  String get selectedPayloadRequiresParametersOpenExecuteToConfigureAndRun =>
      'Selected payload requires parameters. Open Execute to configure and run.';

  @override
  String get mostRecentPayloadRequiresParametersOpenExecuteToConfigureAndRun =>
      'Most recent payload requires parameters. Open Execute to configure and run.';

  @override
  String get checkingSystemStatus => 'Checking system status...';

  @override
  String get verifyingRootAccessAndUSBGadgetSupport =>
      'Verifying root access and USB gadget support';

  @override
  String get deviceInfo => 'Device Info';

  @override
  String get panicStop => 'Panic Stop';

  @override
  String get logs => 'Logs';

  @override
  String get device => 'Device';

  @override
  String get recentPayloads => 'Recent Payloads';

  @override
  String get createNew => 'New';

  @override
  String failedToLoadPayloads(String error) {
    return 'Failed to load payloads: $error';
  }

  @override
  String get viewAllPayloads => 'View all payloads';

  @override
  String get moreActions => 'More actions';

  @override
  String get quickAccess => 'Quick Access';

  @override
  String get systemStatus => 'System Status';

  @override
  String get payloadManager => 'Payload Manager';

  @override
  String get createEditImportExport => 'Create, edit, import, export';

  @override
  String get scheduler => 'Scheduler';

  @override
  String get timeWindowsAndTriggers => 'Time windows & triggers';

  @override
  String get themeLoggingHIDConfig => 'Theme, logging, HID config';

  @override
  String get executionHistory => 'Execution history';

  @override
  String get diagnosticsAndCompatibility => 'Diagnostics & compatibility';

  @override
  String get emergencyStopAndGadgetTeardown =>
      'Emergency stop and gadget teardown';

  @override
  String get systemNotReady => 'System Not Ready';

  @override
  String get sessionDisarmed => 'Session Disarmed';

  @override
  String get waitingForHost => 'Waiting for Host';

  @override
  String get executing => 'Executing';

  @override
  String get ready => 'Ready';

  @override
  String get running => 'Running';

  @override
  String get disarm => 'Disarm';

  @override
  String get armSession => 'Arm Session';

  @override
  String get stop => 'Stop';

  @override
  String get rootAccessRequired => 'Root access required';

  @override
  String get hidNotSupported => 'USB gadget not supported';

  @override
  String get tapToActivateUSBGadget => 'Tap to activate USB gadget';

  @override
  String get connectUSBCableToTarget => 'Connect USB cable to target';

  @override
  String get payloadInProgress => 'Payload in progress';

  @override
  String get systemOperational => 'System operational';

  @override
  String get none => 'None';

  @override
  String get keyboard => 'Keyboard';

  @override
  String get mouse => 'Mouse';

  @override
  String get composite => 'Composite';

  @override
  String get profile => 'Profile';

  @override
  String get schedules => 'Schedules';

  @override
  String get logging => 'Logging';

  @override
  String get on => 'ON';

  @override
  String get off => 'OFF';

  @override
  String get run => 'Run';

  @override
  String get noPayloadsYet => 'No payloads yet';

  @override
  String get createYourFirstPayloadToGetStarted =>
      'Create your first payload to get started.';

  @override
  String get createPayload => 'Create Payload';

  @override
  String get importFromGitHubStore => 'Import from GitHub Store';

  @override
  String get operationalFlow => 'Operational Flow';

  @override
  String get armHIDSessionActivatesUSBGadget =>
      'Arm HID session (activates USB gadget)';

  @override
  String get connectUSBCableToTargetDevice =>
      'Connect USB cable to target device';

  @override
  String get selectPayloadAndConfigureParameters =>
      'Select payload and configure parameters';

  @override
  String get executeAndReviewLogs => 'Execute and review logs';

  @override
  String get rootAvailableUSBGadgetIsActive =>
      'Root available. USB gadget backend is active.';

  @override
  String get rootNotAvailableCheckDeviceScreenForDiagnostics =>
      'Root not available. Check Device screen for diagnostics.';

  @override
  String labelCopiedToClipboard(String label) {
    return '$label copied to clipboard';
  }

  @override
  String get deviceInformation => 'Device Information';

  @override
  String get refreshDiagnostics => 'Refresh diagnostics';

  @override
  String get hidReadiness => 'HID Readiness';

  @override
  String get usbGadgetSystemStatus => 'USB gadget system status';

  @override
  String get usbDeviceController => 'USB Device Controller';

  @override
  String get realTimeConnectionState => 'Real-time connection state';

  @override
  String get hardwareAndSoftwareDetails => 'Hardware & software details';

  @override
  String get backendDiagnostics => 'Backend Diagnostics';

  @override
  String get kernelAndSysytemConfiguration => 'Kernel & system configuration';

  @override
  String get compatibilityNotes => 'Compatibility Notes';

  @override
  String get requirementsAndRecommendations => 'Requirements & recommendations';

  @override
  String get systemReady => 'System Ready';

  @override
  String get allRequirementsMetForHIDOperations =>
      'All requirements met for HID operations';

  @override
  String get missingRequiredComponents => 'Missing required components';

  @override
  String get rootAccess => 'Root Access';

  @override
  String get avaible => 'Available';

  @override
  String get unavailable => 'Unavailable';

  @override
  String get superUserPermissionsGranted => 'Superuser permissions granted';

  @override
  String get rootAccessRequiredForUSBGadgetControl =>
      'Root access required for USB gadget control';

  @override
  String get usbGadgetSupport => 'USB Gadget Support';

  @override
  String get supported => 'Supported';

  @override
  String get unsupported => 'Unsupported';

  @override
  String get kernelSupportsConfigFSUSBGadgets =>
      'Kernel supports ConfigFS USB gadgets';

  @override
  String get kernelMissingUSBGadgetConfigFSSupport =>
      'Kernel missing USB gadget/ConfigFS support';

  @override
  String get sessionState => 'Session State';

  @override
  String get armed => 'Armed';

  @override
  String get disarmed => 'Disarmed';

  @override
  String get usbGadgetIsActiveAndReady => 'USB gadget is active and ready';

  @override
  String get activateSessionToEnableHIDOperations =>
      'Activate session to enable HID operations';

  @override
  String get targetConnection => 'Target Connection';

  @override
  String get connected => 'Connected';

  @override
  String get disconnected => 'Disconnected';

  @override
  String get usbCableConnectedToTargetHost =>
      'USB cable connected to target host';

  @override
  String get availableUDCControllers => 'Available UDC Controllers';

  @override
  String get hostHasEnumeratedTheDeviceReadyForHIDCommunication =>
      'Host has enumerated the device. Ready for HID communication.';

  @override
  String get noUSBCableConnectedOrHostIsPoweredOff =>
      'No USB cable connected or host is powered off.';

  @override
  String get usbCableConnectedWaitingForPowerNegotiation =>
      'USB cable connected, waiting for power negotiation.';

  @override
  String get deviceIsPoweredWaitingForEnumeration =>
      'Device is powered, waiting for enumeration.';

  @override
  String get enumerationStartedDeviceIsBeingConfigured =>
      'Enumeration started, device is being configured.';

  @override
  String get deviceHasBeenAddressedByHostConfigurationInProgress =>
      'Device has been addressed by host, configuration in progress.';

  @override
  String unknownUDCState(String state) {
    return 'Unknown UDC state: $state';
  }

  @override
  String get udcStateIsPolledEvery2SecondsWhenSessionIsActive =>
      'UDC state is polled every 2 seconds when session is active';

  @override
  String get rootShellID => 'Root Shell ID';

  @override
  String get udcControllers => 'UDC Controllers';

  @override
  String get configfsMountPoints => 'ConfigFS Mount Points';

  @override
  String get activeGadgetDirectories => 'Active Gadget Directories';

  @override
  String kernelConfigFlags(int length) {
    return 'Kernel Config Flags ($length)';
  }

  @override
  String get systemPaths => 'System Paths';

  @override
  String rawKernelConfig(int length) {
    return 'Raw Kernel Config ($length lines)';
  }

  @override
  String get physicalDeviceDetected => 'Physical device detected';

  @override
  String get emulatorDetected => 'Emulator detected';

  @override
  String get thisIsAPhysicalDevice =>
      'This is a physical device - the recommended environment for USB gadget operations. All HID features should work as expected.';

  @override
  String get thisIsAnEmulator =>
      'This appears to be an emulator. Emulators typically cannot validate USB gadget/ConfigFS behavior. Use a physical rooted device for real HID operations.';

  @override
  String get requirementsForRealHID => 'Requirements for Real HID';

  @override
  String get rootAccessMagiskKernelSUOrSuperSU =>
      'Root access (Magisk, Kernel SU, or SuperSU)';

  @override
  String get usbGadgetConfigFSKernelSupport =>
      'USB gadget / ConfigFS kernel support';

  @override
  String get usbOTGCableOrUSBCDataCable => 'USB OTG cable or USB-C data cable';

  @override
  String get targetHostWithUSBHIDSupport => 'Target host with USB HID support';

  @override
  String get failedToLoadDeviceInfo => 'Failed to Load Device Info';

  @override
  String get failedToLoadDiagnostics => 'Failed to Load Diagnostics';
}
