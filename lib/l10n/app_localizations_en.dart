// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get language => 'Language';

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
  String failedToLoadPayloadsError(String error) {
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
  String get available => 'Available';

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

  @override
  String get failedToLoadPayloads => 'Failed to Load Payloads';

  @override
  String get noPayloadsAvailable => 'No payloads available';

  @override
  String get createOrImportAPayloadFirst => 'Create or import a payload first.';

  @override
  String get executionSpeed => 'Execution Speed';

  @override
  String get ultra => 'Ultra';

  @override
  String get fast => 'Fast';

  @override
  String get normal => 'Normal';

  @override
  String get slow => 'Slow';

  @override
  String get speedMultiplier => 'Speed Multiplier';

  @override
  String get executionSpeedScalesScriptDelaysTypingSpeedIsSetInSettings =>
      'Execution speed scales script delays. Typing speed is set in Settings.';

  @override
  String get estimatedDuration => 'Estimated Duration';

  @override
  String get original => 'Original: ';

  @override
  String get adjusted => 'Adjusted: ';

  @override
  String basedOnCountCommandsAndSecOfDelays(int count, String sec) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count commands',
      one: '1 command',
    );
    return 'Based on$_temp0 and $sec sec of delays';
  }

  @override
  String get slowerSpeedsFasterSpeeds =>
      'Use slower speeds (2×-4×) for unreliable targets or debugging. Faster speeds (0.25×-0.5×) for quick testing.';

  @override
  String milisec(int ms) {
    return '${ms}ms';
  }

  @override
  String sec(String sec) {
    return '${sec}s';
  }

  @override
  String minAndSec(int min, int sec) {
    return '${min}m ${sec}s';
  }

  @override
  String get verySlow => 'Very Slow';

  @override
  String get veryFast => 'Very Fast';

  @override
  String get rootShellAvailable => 'Root shell available';

  @override
  String get usbHIDSupport => 'USB HID support';

  @override
  String get usbGadgetConfigfsDetected => 'USB gadget/configfs detected';

  @override
  String get deviceDoesNotSupportUSBGadgetMode =>
      'Device does not support USB gadget mode';

  @override
  String get hidSessionArmed => 'HID session armed';

  @override
  String get usbGadgetIsActive => 'USB gadget is active';

  @override
  String get armSessionFromDashboardToActivateUSBGadget =>
      'Arm session from Dashboard to activate USB gadget';

  @override
  String get targetDeviceConnected => 'Target device connected';

  @override
  String get usbCableConnectedToTarget => 'USB cable connected to target';

  @override
  String get connectUSBCableToTargetDeviceOptionalForTesting =>
      'Connect USB cable to target device (optional for testing)';

  @override
  String get payloadSelected => 'Payload selected';

  @override
  String payloadName(String name) {
    return 'Payload: $name';
  }

  @override
  String get requiredParameters => 'Required parameters';

  @override
  String get fillInAllRequiredParametersAbove =>
      'Fill in all required parameters above';

  @override
  String get allRequiredParametersProvided =>
      'All required parameters provided';

  @override
  String get preExecutionChecklist => 'Pre-Execution Checklist';

  @override
  String checksPassed(int passedCount, int totalCount) {
    return '$passedCount of $totalCount checks passed';
  }

  @override
  String get fixCriticalIssuesAboveBeforeExecuting =>
      'Fix critical issues above before executing';

  @override
  String get required => 'REQUIRED';

  @override
  String get rootHIDUnavailable => 'Root/HID unavailable';

  @override
  String get noDeviceConnected => 'No device connected';

  @override
  String get executingThreePoints => 'Executing...';

  @override
  String get readyToExecute => 'Ready to execute';

  @override
  String get selectedPayload => 'Selected Payload';

  @override
  String get payload => 'Payload';

  @override
  String get editPayload => 'Edit Payload';

  @override
  String get parameters => 'Parameters';

  @override
  String get execution => 'Execution';

  @override
  String get runPayload => 'Run Payload';

  @override
  String get rootAccesNotAvailable => 'Root access not available';

  @override
  String get usbHIDNotSupported => 'USB HID not supported';

  @override
  String get sessionIsDisarmedArmItFromDashboardFirst =>
      'Session is disarmed. Arm it from Dashboard first.';

  @override
  String get cannotExecute => 'Cannot execute';

  @override
  String get console => 'Console';

  @override
  String get events => 'Events';

  @override
  String get sendRawHIDCommands => 'Send raw HID commands';

  @override
  String get saveAsPreset => 'Save as Preset';

  @override
  String get quickCommands => 'Quick Commands';

  @override
  String get selectAPreset => 'Select a preset...';

  @override
  String get examples => 'Examples';

  @override
  String get enterACommandFirstBeforeSavingAsPreset =>
      'Enter a command first before saving as preset';

  @override
  String get presetNameOptional => 'Preset Name (optional)';

  @override
  String get egOpenNotepad => 'e.g., Open Notepad';

  @override
  String get command => 'Command';

  @override
  String get cancel => 'Cancel';

  @override
  String get save => 'Save';

  @override
  String get presetSavedSuccessfully => 'Preset saved successfully';

  @override
  String get runAPayloadToSeeExecutionEvents =>
      'Run a payload to see execution events';

  @override
  String get noEventsYet => 'No events yet';

  @override
  String secAgo(int sec) {
    return '${sec}s ago';
  }

  @override
  String minAgo(int min) {
    return '${min}m ago';
  }
}
