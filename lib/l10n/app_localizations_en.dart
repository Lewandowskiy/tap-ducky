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
}
