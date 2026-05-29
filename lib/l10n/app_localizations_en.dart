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
  String get original => 'Original';

  @override
  String get adjusted => 'Adjusted';

  @override
  String basedOnCountCommandsAndSecOfDelays(int count, String sec) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'Based on $count command$_temp0 and $sec sec of delays';
  }

  @override
  String get slowerSpeedsFasterSpeeds =>
      'Use slower speeds (2×-4×) for unreliable targets or debugging. Faster speeds (0.25×-0.5×) for quick testing.';

  @override
  String millisec(int ms) {
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
  String get rootAccessNotAvailable => 'Root access not available';

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

  @override
  String get noBrowserAvailable => 'No browser available';

  @override
  String failedToOpenError(String error) {
    return 'Failed to open: $error';
  }

  @override
  String get resetAllSettingsQuestionMark => 'Reset all settings?';

  @override
  String get thisWillRestoreAllSettingsToTheirDefaults =>
      'This will restore all settings to their defaults.';

  @override
  String get reset => 'Reset';

  @override
  String get settingsResetToDefaults => 'Settings reset to defaults';

  @override
  String failedToLoadSettingsError(String error) {
    return 'Failed to load settings: $error';
  }

  @override
  String get resetAllSettings => 'Reset all settings';

  @override
  String get supportDevelopment => 'Support Development';

  @override
  String get keepThisAppFastFreeAndMaintained =>
      'Keep this app fast, free, and maintained';

  @override
  String get supportDescription =>
      'No ads, no tracking, no locked features. Your support keeps this Rubber Ducky alternative independent and freely available to penetration testers worldwide.';

  @override
  String get donate => 'Donate';

  @override
  String get repositoryLinkCopied => 'Repository link copied';

  @override
  String get starRepo => 'Star Repo';

  @override
  String get localOnly => 'Local-only';

  @override
  String get noTracking => 'No Tracking';

  @override
  String get lightweight => 'Lightweight';

  @override
  String get openSource => 'Open Source';

  @override
  String get appearance => 'Appearance';

  @override
  String get customizeYourVisualExperience =>
      'Customize your visual experience';

  @override
  String get auto => 'Auto';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get controlPayloadBehaviorAndTiming =>
      'Control payload behavior and timing';

  @override
  String get speedAndTiming => 'Speed & timing';

  @override
  String get resetDefaults => 'Reset defaults';

  @override
  String get adjustScriptDelaysAndRawKeyPressTiming =>
      'Adjust script delays and raw key press timing.';

  @override
  String executionSpeedMultiplier(String label, String multiplier) {
    return '$label • $multiplier×';
  }

  @override
  String get typingSpeed => 'Typing speed';

  @override
  String typingSpeedMultiplier(String label, String multiplier) {
    return '$label • $multiplier×';
  }

  @override
  String get lowerIsFaster =>
      'Lower is faster. Controls raw key press timing (STRING typing).';

  @override
  String get ultraFast => 'Ultra Fast';

  @override
  String get ultraFastDescription =>
      'Ultra fast may be unreliable on some hosts.';

  @override
  String get advancedExecution => 'Advanced execution';

  @override
  String get loggingHIDReliabilityUnicodeFallback =>
      'Logging, HID reliability, Unicode fallback';

  @override
  String get enableLogging => 'Enable logging';

  @override
  String get recordExecutionEventsAndOutcomes =>
      'Record execution events and outcomes';

  @override
  String get randomizeTiming => 'Randomize timing';

  @override
  String get addsSmallJitterToMimicRealTyping =>
      'Adds small jitter to mimic real typing';

  @override
  String get hidGraceWindow => 'HID grace window';

  @override
  String hidGraceWindowMS(int ms) {
    return '$ms ms';
  }

  @override
  String get waitBrieflyForHIDToBecomeActiveBeforeFailingAWrite =>
      'Wait briefly for HID to become active before failing a write.';

  @override
  String get unicodeFallback => 'Unicode fallback';

  @override
  String get warnAndSkip => 'Warn & skip';

  @override
  String get skip => 'Skip';

  @override
  String get asciiTransliterate => 'ASCII transliterate';

  @override
  String get controlsHowUnsupportedCharactersAreHandledDuringTyping =>
      'Controls how unsupported characters are handled during typing.';

  @override
  String get riskyFastModeCanCauseMissedOrStuckKeysOnSomeHosts =>
      'Risky fast mode can cause missed or stuck keys on some hosts.';

  @override
  String get riskyFastMode => 'Risky fast mode';

  @override
  String get allowsShorterKeyHoldAndInterKeyDelaysMayBeUnreliable =>
      'Allows shorter key hold and inter-key delays. May be unreliable.';

  @override
  String get keepScreenOn => 'Keep screen on';

  @override
  String get preventsScreenFromSleepingDuringExecution =>
      'Prevents screen from sleeping during execution';

  @override
  String get mayIncreaseBatteryUsageScreenWillStayOnEvenWhenAppIsInBackground =>
      'May increase battery usage. Screen will stay on even when app is in background.';

  @override
  String get stealthMode => 'Stealth Mode';

  @override
  String get covertOperationCapabilities => 'Covert operation capabilities';

  @override
  String get hiddenExecution => 'Hidden Execution';

  @override
  String get hiddenExecutionDescription =>
      'When \"Keep screen on\" is disabled, payloads can execute while the screen is off. This allows for covert operation where the device appears idle.';

  @override
  String get useCases => 'Use Cases';

  @override
  String get useCasesDescription =>
      '• Screen ON: Interactive testing, debugging, demonstrations\n• Screen OFF: Scheduled tasks, automated operations, covert execution';

  @override
  String get payloadsStore => 'Payloads Store';

  @override
  String get browseGitHubRepositoriesAndImportPayloads =>
      'Browse GitHub repositories and import payloads';

  @override
  String get openPayloadsStore => 'Open Payloads Store';

  @override
  String get manageAndImportFromMultipleRepos =>
      'Manage and import from multiple repos';

  @override
  String get advanced => 'Advanced';

  @override
  String get usbGadgetPresetsAndHotkeys => 'USB gadget, presets, and hotkeys';

  @override
  String get advancedSettings => 'Advanced settings';

  @override
  String get commandPresetsHotkeysDefaultVidPid =>
      'Command presets, hotkeys, default VID/PID';

  @override
  String get hidControl => 'HID Control';

  @override
  String get usbGadgetSessionStatus => 'USB gadget session status';

  @override
  String get rootAvailable => 'Root available';

  @override
  String get hidSupported => 'HID supported';

  @override
  String get hidSession => 'HID session';

  @override
  String get hidSessionDescription =>
      'HID session control activates/deactivates the USB gadget. Check Device screen for detailed diagnostics.';

  @override
  String get about => 'About';

  @override
  String get appInformationAndLegal => 'App information and legal';

  @override
  String version(String version) {
    return 'Version $version';
  }

  @override
  String get licences => 'Licenses';

  @override
  String get openSourceLicenses => 'Open source licenses';

  @override
  String get autoTheme => 'Auto Theme';

  @override
  String get lightTheme => 'Light Theme';

  @override
  String get darkTheme => 'Dark Theme';

  @override
  String get followsYourDeviceSettings => 'Follows your device settings';

  @override
  String get alwaysBrightAndClear => 'Always bright and clear';

  @override
  String get easyOnTheEyes => 'Easy on the eyes';

  @override
  String get themeModeSystem =>
      'Theme automatically switches when you change your device settings between light and dark mode';

  @override
  String get themeModeLight =>
      'Perfect for daytime use and well-lit environments';

  @override
  String get themeModeDark =>
      'Reduces eye strain in low-light conditions and saves battery on OLED screens';

  @override
  String get useDynamicColors => 'Use dynamic colors';

  @override
  String get matchYourSystemMaterialYouPaletteOnSupportedDevices =>
      'Match your system Material You palette on supported devices.';

  @override
  String get dynamicColorsAreOnlyAvailableOnAndroid12 =>
      'Dynamic colors are only available on Android 12+.';

  @override
  String countSelected(int count) {
    return '$count selected';
  }

  @override
  String get runFirstSelected => 'Run first selected';

  @override
  String get armSessionToRun => 'Arm session to run';

  @override
  String get deleteSelected => 'Delete selected';

  @override
  String get githubStore => 'GitHub Store';

  @override
  String get exportAll => 'Export all';

  @override
  String get importFromClipboard => 'Import from clipboard';

  @override
  String get manageSources => 'Manage sources';

  @override
  String get selectMultiple => 'Select multiple';

  @override
  String get tipImportPayloadsFromTheGitHubStore =>
      'Tip: Import payloads from the GitHub Store';

  @override
  String get open => 'Open';

  @override
  String searching(String query) {
    return 'Searching: \"$query\"';
  }

  @override
  String get newPayload => 'New Payload';

  @override
  String get payloadDuplicated => 'Payload duplicated';

  @override
  String get deletePayload => 'Delete payload';

  @override
  String deletePayloadThisCanNotBeUndone(String name) {
    return 'Delete \"$name\"? This cannot be undone.';
  }

  @override
  String get delete => 'Delete';

  @override
  String get deletePayloads => 'Delete payloads';

  @override
  String deleteCountPayloadsThisCanNotBeUndone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'Delete $count payload$_temp0? This cannot be undone.';
  }

  @override
  String get importPayloads => 'Import payload(s)';

  @override
  String get pastePayloadJSONOrAPayloadPackJSONBelow =>
      'Paste payload JSON or a payload pack JSON below:';

  @override
  String get import => 'Import';

  @override
  String get noPayloadsFoundInInput => 'No payloads found in input.';

  @override
  String importedCountPayloads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return 'Imported $count payload$_temp0.';
  }

  @override
  String importFailedError(String error) {
    return 'Import failed: $error';
  }

  @override
  String get searchPayloads => 'Search payloads';

  @override
  String get search => 'Search';

  @override
  String get nameTagsScriptContent => 'Name, tags, script content...';

  @override
  String get all => 'All';

  @override
  String get collapse => 'Collapse';

  @override
  String get expandPreview => 'Expand preview';

  @override
  String get scriptPreview => 'Script preview';

  @override
  String get duplicate => 'Duplicate';

  @override
  String get export => 'Export';

  @override
  String get yourScriptLibrary => 'Your Script Library';

  @override
  String get createOrganizeAndExecuteYourCustomHIDPayloads =>
      'Create, organize, and execute your custom HID payloads';

  @override
  String get createAPayload => 'Create a Payload';

  @override
  String get writeDuckyScriptCommandsOrUseTemplates =>
      'Write DuckyScript commands or use templates';

  @override
  String get organizeWithTags => 'Organize with Tags';

  @override
  String get groupPayloadsByCategoryOrPurpose =>
      'Group payloads by category or purpose';

  @override
  String get executeAndShare => 'Execute & Share';

  @override
  String get runOnTargetOrExportToShare => 'Run on target or export to share';

  @override
  String get createYourFirstPayload => 'Create Your First Payload';

  @override
  String get importExistingPayloads => 'Import Existing Payloads';

  @override
  String get noPayloadsFound => 'No payloads found';

  @override
  String noResultsForQuery(String query) {
    return 'No result for \"$query\"';
  }

  @override
  String noPayloadsWithTag(String tag) {
    return 'No payloads with tag \"$tag\"';
  }

  @override
  String get tryAdjustingYourFilters => 'Try adjusting your filters';

  @override
  String get clearFilters => 'Clear Filters';

  @override
  String get discardChanges => 'Discard changes?';

  @override
  String get youHaveUnsavedChangesDiscardThem =>
      'You have unsaved changes. Discard them?';

  @override
  String get showValidationIssues => 'Show validation issues';

  @override
  String get thisIsABuiltInPayload =>
      'This is a built-in payload. You can duplicate it to create a custom version.';

  @override
  String get basicInfo => 'Basic Info';

  @override
  String get name => 'Name';

  @override
  String get egWindowsRunDialog => 'e.g., Windows Run Dialog';

  @override
  String get nameIsRequired => 'Name is required';

  @override
  String get description => 'Description';

  @override
  String get whatDoesThisPayloadDo => 'What does this payload do?';

  @override
  String get tags => 'Tags';

  @override
  String get windowsReconExfilCommaSeparated =>
      'windows, recon, exfil (comma-separated)';

  @override
  String get script => 'Script';

  @override
  String get syntax => 'Syntax';

  @override
  String get helloWorld => 'Hello World';

  @override
  String get scriptIsRequired => 'Script is required';

  @override
  String usePARAM_NAMEForDynamicValues(String PARAM_NAME) {
    return 'Use $PARAM_NAME for dynamic values';
  }

  @override
  String parametersCount(int count) {
    return 'Parameters ($count)';
  }

  @override
  String get add => 'Add';

  @override
  String get noParameters => 'No parameters';

  @override
  String get addParametersToMakeThispayloadReusableWithDifferentValues =>
      'Add parameters to make this payload reusable with different values.';

  @override
  String get quickActions => 'Quick Actions';

  @override
  String get createACopyOfThisPayload => 'Create a copy of this payload';

  @override
  String get shareAsJSON => 'Share as JSON';

  @override
  String get removeThisPayloadPermanently => 'Remove this payload permanently';

  @override
  String get cannotSaveScriptHasValidationErrors =>
      'Cannot save: script has validation errors';

  @override
  String get payloadCreated => 'Payload created';

  @override
  String get payloadUpdated => 'Payload updated';

  @override
  String get duckyScriptSyntax => 'DuckyScript Syntax';

  @override
  String get keystrokeInjection => 'Keystroke Injection';

  @override
  String get text => 'text';

  @override
  String get typeText => 'Type text';

  @override
  String get typeTextPlusEnter => 'Type text + Enter';

  @override
  String get ms => 'ms';

  @override
  String get waitMilliseconds => 'Wait milliseconds';

  @override
  String get pressEnter => 'Press Enter';

  @override
  String get pressTab => 'Press Tab';

  @override
  String get pressEscape => 'Press Escape';

  @override
  String get pressBackspace => 'Press Backspace';

  @override
  String get pressDelete => 'Press Delete';

  @override
  String get parameterPlaceholder => 'Parameter placeholder';

  @override
  String get defineVariable => 'Define variable';

  @override
  String get defineConstant => 'Define constant';

  @override
  String get close => 'Close';

  @override
  String get scriptHasErrors => 'Script has errors';

  @override
  String get scriptHasWarnings => 'Script has Warnings';

  @override
  String get scriptIsValid => 'Script is Valid';

  @override
  String countCommands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count command$_temp0';
  }

  @override
  String countErrors(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count error$_temp0';
  }

  @override
  String countWarnings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count warning$_temp0';
  }

  @override
  String get validationResults => 'Validation Results';

  @override
  String totalDelays(String sec) {
    return 'Total delays: ${sec}s';
  }

  @override
  String get noIssuesFoundScriptIsValid => 'No issues found. Script is valid!';

  @override
  String issuesCount(int count) {
    return 'Issues $count';
  }

  @override
  String lineNum(int num) {
    return 'Line $num';
  }

  @override
  String get paramRequired => 'required';

  @override
  String get addParameter => 'Add Parameter';

  @override
  String get editParameter => 'Edit Parameter';

  @override
  String get key => 'Key';

  @override
  String get requiredCap => 'Required';

  @override
  String get label => 'Label';

  @override
  String get targetIPAddress => 'Target IP Address';

  @override
  String get optionalDescription => 'Optional description';

  @override
  String get textCap => 'Text';

  @override
  String get number => 'Number';

  @override
  String get url => 'URL';

  @override
  String get type => 'Type';

  @override
  String get defaultValue => 'Default Value';

  @override
  String get keyboardOnly => 'Keyboard Only';

  @override
  String get mouseOnly => 'Mouse Only';

  @override
  String get compositeKeyboardMouse => 'Composite (Keyboard + Mouse)';

  @override
  String get keyboardProfileDescription =>
      'Single HID keyboard device. Use for typing and key combinations.';

  @override
  String get mouseProfileDescription =>
      'Single HID mouse device. Use for cursor movement and clicks.';

  @override
  String get compositeProfileDescription =>
      'Combined keyboard and mouse. Recommended for most payloads.';

  @override
  String get selectUSBGadgetProfile => 'Select USB Gadget Profile';

  @override
  String get chooseTheHIDDeviceTypeToActivate =>
      'Choose the HID device type to activate:';

  @override
  String get activate => 'Activate';

  @override
  String get recommended => 'RECOMMENDED';

  @override
  String get clearLogs => 'Clear logs';

  @override
  String get deleteAllStoredLogs => 'Delete all stored logs?';

  @override
  String get clear => 'Clear';

  @override
  String get clearAll => 'Clear all';

  @override
  String get level => 'Level:';

  @override
  String failedToLoadLogsError(String error) {
    return 'Failed to load logs: $error';
  }

  @override
  String get noLogsYet => 'No logs yet';

  @override
  String get noMatchingLogs => 'No matching logs';

  @override
  String get runAPayloadToGenerateLogs => 'Run a payload to generate logs.';

  @override
  String get changeTheLevelFilterToSeeMoreEntries =>
      'Change the level filter to see more entries.';

  @override
  String get logEntry => 'Log entry';

  @override
  String get share => 'Share';

  @override
  String failedToLoadLogs(String error) {
    return 'Failed to load logs: $error';
  }

  @override
  String get logEntryNotFound => 'Log entry not found.';

  @override
  String get metadata => 'Metadata';

  @override
  String get noMetadata => 'No metadata';

  @override
  String get failedToLoadHistory => 'Failed to load history';

  @override
  String get noExecutionHistory => 'No execution history';

  @override
  String get runAPayloadToSeeExecutionHistoryHere =>
      'Run a payload to see execution history here.';

  @override
  String get clearExecutionHistory => 'Clear execution history';

  @override
  String get thisWillDeleteAllExecutionLogs =>
      'This will delete all execution logs. This cannot be undone.';

  @override
  String get total => 'Total';

  @override
  String get success => 'Success';

  @override
  String get failed => 'Failed';

  @override
  String get hour => 'h';

  @override
  String countEvents(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count event$_temp0';
  }

  @override
  String get executionDetails => 'Execution Details';

  @override
  String get executionID => 'Execution ID';

  @override
  String get started => 'Started';

  @override
  String get finished => 'Finished';

  @override
  String get duration => 'Duration';

  @override
  String eventsCount(int count) {
    return 'Events $count';
  }

  @override
  String get sAgo => 's ago';

  @override
  String get mAgo => 'm ago';

  @override
  String get hAgo => 'h ago';

  @override
  String get dAgo => 'd ago';

  @override
  String unknownCommand(String command) {
    return 'Unknown command: $command';
  }

  @override
  String didYouMean(String name) {
    return 'Did you mean $name?';
  }

  @override
  String get stringDelayRequiresANumericDelayValue =>
      'STRING_DELAY requires a numeric delay value';

  @override
  String get exampleStringDelay100Hello => 'Example: STRING_DELAY 100 Hello';

  @override
  String get exampleStringDelay50 => 'Example: STRING_DELAY 50';

  @override
  String get defaultDelayRequiresANumericValue =>
      'DEFAULTDELAY requires a numeric value';

  @override
  String get delayRequiresATimeValueInMilliseconds =>
      'DELAY requires a time value in milliseconds';

  @override
  String get exampleDelay500 => 'Example: DELAY 500';

  @override
  String get delayValueMustBeANumberOrVariable =>
      'DELAY value must be a number or variable';

  @override
  String get exampleDelay500OrDelayMyDelay =>
      'Example: DELAY 500 or DELAY \$MY_DELAY';

  @override
  String delayMinimumValueIsMS(int min_ms) {
    return 'DELAY minimum value is ${min_ms}ms';
  }

  @override
  String useDelayMinMSOrHigher(int min_ms) {
    return 'Use DELAY $min_ms or higher';
  }

  @override
  String waitForTargetNotRecognized(String target) {
    return 'WAIT_FOR target not recognized: $target';
  }

  @override
  String get useHostConnectedEtc =>
      'Use HOST_CONNECTED, UDC_CONFIGURED, KEYBOARD_READY, MOUSE_READY, or SESSION_ARMED';

  @override
  String get defineRequiresANameAndValue => 'DEFINE requires a name and value';

  @override
  String get exampleDefineAppNotepad => 'Example: DEFINE APP notepad';

  @override
  String get varRequiresAVariableName => 'VAR requires a variable name';

  @override
  String get exampleVarCounter0 => 'Example: VAR \$counter = 0';

  @override
  String get variableNameMustStartWithDollar =>
      'Variable name must start with \$';

  @override
  String get functionRequiresAName => 'FUNCTION requires a name';

  @override
  String get exampleFunctionMyFunction => 'Example: FUNCTION my_function';

  @override
  String get endFunctionWithoutMatchingFunction =>
      'END_FUNCTION without matching FUNCTION';

  @override
  String get returnOutsideOfFunction => 'RETURN outside of FUNCTION';

  @override
  String get elseWithoutMatchingIf => 'ELSE without matching IF';

  @override
  String get endIfWithoutMatchingIf => 'END_IF without matching IF';

  @override
  String get endWhileWithoutMatchingWhile => 'END_WHILE without matching WHILE';

  @override
  String get catchWithoutMatchingTry => 'CATCH without matching TRY';

  @override
  String get endTryWithoutMatchingTry => 'END_TRY without matching TRY';

  @override
  String get repeatRequiresANumericCount => 'REPEAT requires a numeric count';

  @override
  String get exampleRepeat5 => 'Example: REPEAT 5';

  @override
  String get mouseRequiresAnAction =>
      'MOUSE requires an action (CLICK, MOVE, SCROLL, etc.)';

  @override
  String functionNotDeclaredInThisScript(String func_name) {
    return 'Function $func_name not declared in this script';
  }

  @override
  String declareItWithFunction(String func_name) {
    return 'Declare it with: FUNCTION $func_name';
  }

  @override
  String countUnclosedIfStatements(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count unclosed IF statement$_temp0';
  }

  @override
  String get addEndIfForEachIf => 'Add END_IF for each IF';

  @override
  String countUnclosedWhileLoops(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count unclosed WHILE loop$_temp0';
  }

  @override
  String get addEndWhileForEachWhile => 'Add END_WHILE for each WHILE';

  @override
  String countUnclosedFunctions(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count unclosed function$_temp0';
  }

  @override
  String get addEndFunctionForEachFunction =>
      'Add END_FUNCTION for each FUNCTION';

  @override
  String countUnclosedTryBlocks(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 's',
      one: '',
    );
    return '$count unclosed TRY block$_temp0';
  }

  @override
  String get addEndTryForEachTry => 'Add END_TRY for each TRY';

  @override
  String get unclosedRemBlock => 'Unclosed REM_BLOCK (missing END_REM)';

  @override
  String get unclosedStringBlock =>
      'Unclosed STRING block (missing END_STRING)';

  @override
  String get unclosedStringlnBlock =>
      'Unclosed STRINGLN block (missing END_STRINGLN)';

  @override
  String get discard => 'Discard';

  @override
  String get sources => 'Sources';

  @override
  String get showAllIncludingHidden => 'Show all (including hidden)';

  @override
  String get hideMedia => 'Hide media';

  @override
  String get showMedia => 'Show media';

  @override
  String get refresh => 'Refresh';

  @override
  String get repositoryControls => 'Repository controls';

  @override
  String get folders => 'Folders';

  @override
  String get files => 'Files';

  @override
  String get pasteAGitHubURLFirst => 'Paste a GitHub URL first';

  @override
  String get invalidGitHubURL =>
      'Invalid GitHub URL. Expected repo or folder URL.';

  @override
  String get sourceAdded => 'Source added';

  @override
  String get noSourcesSavedYet => 'No sources saved yet';

  @override
  String get chooseSource => 'Choose source';

  @override
  String get manage => 'Manage';

  @override
  String get noRepoSelected => 'No repo selected';

  @override
  String get pasteAURLBrowseThenImportPayloads =>
      'Paste a URL, browse, then import payloads.';

  @override
  String get pickFromSavedSources => 'Pick from saved sources';

  @override
  String get browse => 'Browse';

  @override
  String get saveSource => 'Save source';

  @override
  String get upOneFolder => 'Up one folder';

  @override
  String get repositoryRoot => 'Repository root';

  @override
  String get searchFilesAndFolders => 'Search files and folders';

  @override
  String get importable => 'Importable';

  @override
  String get notSupported => 'Not supported';

  @override
  String get converted => 'Converted';

  @override
  String get browseAGitHubRepository => 'Browse a GitHub repository';

  @override
  String get pasteARepoOrFolderURL =>
      'Paste a repo or folder URL, browse files, and import supported payload formats.';

  @override
  String get pasteExampleURL => 'Paste example URL';

  @override
  String get noMatchingFilesOrFolders => 'No matching files or folders';

  @override
  String get failedToLoad => 'Failed to load';

  @override
  String line(String line, String message) {
    return 'Line $line: $message';
  }

  @override
  String get moreThreePoints => 'more…';

  @override
  String get noRepositorySelected => 'No repository selected';

  @override
  String get noPreviewData => 'No preview data';

  @override
  String get copyConverted => 'Copy converted';

  @override
  String get convertedCopied => 'Converted copied';

  @override
  String get copyOriginal => 'Copy original';

  @override
  String get originalCopied => 'Original copied';

  @override
  String get disableWrap => 'Disable wrap';

  @override
  String get enableWrap => 'Enable wrap';

  @override
  String get validationSummary => 'Validation summary';

  @override
  String get importedDuckyScript => 'Imported Ducky Script';

  @override
  String importedFrom(String owner, String repo) {
    return 'Imported from: $owner$repo';
  }

  @override
  String source(String name) {
    return 'source: $name';
  }

  @override
  String get unsupportedFormat => 'Unsupported format';

  @override
  String get importedSuccessfully => 'Imported successfully';

  @override
  String importFailed(String error) {
    return 'Import failed: $error';
  }

  @override
  String get executingThreePoints => 'Executing';

  @override
  String get repositoryNotFound => 'Repository not found';

  @override
  String get gitHubAPIRateLimitReached => 'GitHub API rate limit reached';

  @override
  String get repositoryBranchOrFolderNotFound =>
      'Repository, branch, or folder not found';

  @override
  String get expectedADirectoryListing => 'Expected a directory listing';

  @override
  String get fileNotFound => 'File not found';

  @override
  String get fileTooLargeToPreview =>
      'File too large to preview/import (max 256KB)';

  @override
  String get failedToFetchRaw => 'Failed to fetch raw';

  @override
  String get noContent => 'No content';

  @override
  String get onlyGitHubLinksAreSupported => 'Only GitHub links are supported';

  @override
  String get tapDuckyfailedToStart => 'TapDucky failed to start';
}
