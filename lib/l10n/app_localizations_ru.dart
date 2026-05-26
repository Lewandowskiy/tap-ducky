// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get dashboard => 'Дашборд';

  @override
  String get payloads => 'Пейлоады';

  @override
  String get execute => 'Выполнение';

  @override
  String get schedule => 'Расписание';

  @override
  String get settings => 'Настройки';

  @override
  String get selectedPayloadRequiresParametersOpenExecuteToConfigureAndRun =>
      'Выбранный пейлоад требует параметров. Откройте окно «Выполнение» для настройки и запуска.';

  @override
  String get mostRecentPayloadRequiresParametersOpenExecuteToConfigureAndRun =>
      'Последний пейлоад требует параметров. Откройте окно «Выполнение» для настройки и запуска.';

  @override
  String get checkingSystemStatus => 'Проверка состояния системы...';

  @override
  String get verifyingRootAccessAndUSBGadgetSupport =>
      'Проверка root-доступа и поддержки USB-гаджетов';

  @override
  String get deviceInfo => 'Информация об устройстве';

  @override
  String get panicStop => 'Аварийная остановка';

  @override
  String get logs => 'Логи';

  @override
  String get device => 'Устройство';

  @override
  String get recentPayloads => 'Недавние пейлоады';

  @override
  String get createNew => 'Создать';

  @override
  String failedToLoadPayloads(String error) {
    return 'Не удалось загрузить пейлоады: $error';
  }

  @override
  String get viewAllPayloads => 'Просмотреть все пейлоады';

  @override
  String get moreActions => 'Дополнительные действия';

  @override
  String get quickAccess => 'Быстрый доступ';

  @override
  String get systemStatus => 'Состояние системы';

  @override
  String get payloadManager => 'Менеджер пейлоадов';

  @override
  String get createEditImportExport =>
      'Создание, редактирование, импорт, экспорт';

  @override
  String get scheduler => 'Планировщик';

  @override
  String get timeWindowsAndTriggers => 'Временные окна и триггеры';

  @override
  String get themeLoggingHIDConfig => 'Тема, логгирование, конфигурация HID';

  @override
  String get executionHistory => 'История выполнения';

  @override
  String get diagnosticsAndCompatibility => 'Диагностика и совместимость';

  @override
  String get emergencyStopAndGadgetTeardown =>
      'Аварийная остановка и отключение гаджета';

  @override
  String get systemNotReady => 'Система не готова';

  @override
  String get sessionDisarmed => 'Сессия отключена';

  @override
  String get waitingForHost => 'Ожидание хоста';

  @override
  String get executing => 'Выполнение';

  @override
  String get ready => 'Готово';

  @override
  String get running => 'Запущено';

  @override
  String get disarm => 'Отключить';

  @override
  String get armSession => 'Активировать сессию';

  @override
  String get stop => 'Остановить';

  @override
  String get rootAccessRequired => 'Требуется root-доступ';

  @override
  String get hidNotSupported => 'USB-гаджет не поддерживается';

  @override
  String get tapToActivateUSBGadget => 'Нажмите, чтобы активировать USB-гаджет';

  @override
  String get connectUSBCableToTarget => 'Подключите USB-кабель к цели';

  @override
  String get payloadInProgress => 'Пейлоад выполняется';

  @override
  String get systemOperational => 'Система работает';

  @override
  String get none => 'None';

  @override
  String get keyboard => 'Клав.';

  @override
  String get mouse => 'Мышь';

  @override
  String get composite => 'Композ.';

  @override
  String get profile => 'Профиль';

  @override
  String get schedules => 'Расписания';

  @override
  String get logging => 'Логгирование';

  @override
  String get on => 'ВКЛ';

  @override
  String get off => 'ВЫКЛ';

  @override
  String get run => 'Запустить';

  @override
  String get noPayloadsYet => 'Пока нет пейлоадов';

  @override
  String get createYourFirstPayloadToGetStarted =>
      'Создайте первый пейлоад, чтобы начать работу.';

  @override
  String get createPayload => 'Создать пейлоад';

  @override
  String get importFromGitHubStore => 'Импортировать из GitHub Store';

  @override
  String get operationalFlow => 'Порядок работы';

  @override
  String get armHIDSessionActivatesUSBGadget =>
      'Активировать HID-сессию (включает USB-гаджет)';

  @override
  String get connectUSBCableToTargetDevice => 'Подключите USB-кабель к цели';

  @override
  String get selectPayloadAndConfigureParameters =>
      'Выберите пейлоад и настройте параметры';

  @override
  String get executeAndReviewLogs => 'Выполните и просмотрите логи';

  @override
  String get rootAvailableUSBGadgetIsActive =>
      'Root доступен. Бэкенд USB-гаджета активен.';

  @override
  String get rootNotAvailableCheckDeviceScreenForDiagnostics =>
      'Root недоступен. Проверьте окно «Устройство» для диагностики.';

  @override
  String labelCopiedToClipboard(String label) {
    return 'Текст «$label» скопирован в буфер обмена';
  }

  @override
  String get deviceInformation => 'Информация об устройстве';

  @override
  String get refreshDiagnostics => 'Обновить диагностику';

  @override
  String get hidReadiness => 'Готовность HID';

  @override
  String get usbGadgetSystemStatus => 'Системный статус USB-гаджета';

  @override
  String get usbDeviceController => 'Контроллер USB-устройства';

  @override
  String get realTimeConnectionState =>
      'Состояние подключения в реальном времени';

  @override
  String get hardwareAndSoftwareDetails =>
      'Сведения об аппаратном и программном обеспечении';

  @override
  String get backendDiagnostics => 'Диагностика бэкенд части';

  @override
  String get kernelAndSysytemConfiguration => 'Конфигурация ядра и системы';

  @override
  String get compatibilityNotes => 'Примечания по совместимости';

  @override
  String get requirementsAndRecommendations => 'Требования и рекомендации';

  @override
  String get systemReady => 'Система готова';

  @override
  String get allRequirementsMetForHIDOperations =>
      'Все требования для выполнения операций HID соблюдены';

  @override
  String get missingRequiredComponents => 'Отсутствуют необходимые компоненты';

  @override
  String get rootAccess => 'Root-доступ';

  @override
  String get avaible => 'Доступно';

  @override
  String get unavailable => 'Недоступно';

  @override
  String get superUserPermissionsGranted => 'Предоставлены Root-права';

  @override
  String get rootAccessRequiredForUSBGadgetControl =>
      'Для управления USB-гаджетом необходим Root-доступ';

  @override
  String get usbGadgetSupport => 'Поддержка USB-гаджета';

  @override
  String get supported => 'Есть';

  @override
  String get unsupported => 'Нет';

  @override
  String get kernelSupportsConfigFSUSBGadgets =>
      'Ядро поддерживает USB-гаджеты ConfigFS';

  @override
  String get kernelMissingUSBGadgetConfigFSSupport =>
      'В ядре отсутствует поддержка USB-гаджета или ConfigFS';

  @override
  String get sessionState => 'Состояние сессии';

  @override
  String get armed => 'Готов';

  @override
  String get disarmed => 'Не готов';

  @override
  String get usbGadgetIsActiveAndReady => 'USB-гаджет активен и готов к работе';

  @override
  String get activateSessionToEnableHIDOperations =>
      'Активируйте сессию для включения операций HID';

  @override
  String get targetConnection => 'Подключение к цели';

  @override
  String get connected => 'Подключено';

  @override
  String get disconnected => 'Отключено';

  @override
  String get usbCableConnectedToTargetHost => 'USB-кабель подключен к цели';

  @override
  String get availableUDCControllers => 'Доступные UDC-контроллеры';

  @override
  String get hostHasEnumeratedTheDeviceReadyForHIDCommunication =>
      'Хост выполнил перечисление устройства. Готово к обмену данными по HID.';

  @override
  String get noUSBCableConnectedOrHostIsPoweredOff =>
      'USB-кабель не подключен или цель выключена.';

  @override
  String get usbCableConnectedWaitingForPowerNegotiation =>
      'USB-кабель подключен, ожидается согласование питания.';

  @override
  String get deviceIsPoweredWaitingForEnumeration =>
      'Питание на устройство подано, ожидается перечисление.';

  @override
  String get enumerationStartedDeviceIsBeingConfigured =>
      'Перечисление начато, выполняется конфигурация устройства.';

  @override
  String get deviceHasBeenAddressedByHostConfigurationInProgress =>
      'Целевой хост назначил адрес устройству, выполняется настройка конфигурации.';

  @override
  String unknownUDCState(String state) {
    return 'Неизвестное состояние UDC: $state';
  }

  @override
  String get udcStateIsPolledEvery2SecondsWhenSessionIsActive =>
      'Состояние UDC опрашивается каждые 2 секунды при активной сессии';

  @override
  String get rootShellID => 'ID Root-оболочки';

  @override
  String get udcControllers => 'UDC-контроллеры';

  @override
  String get configfsMountPoints => 'Точки монтирования ConfigFS';

  @override
  String get activeGadgetDirectories => 'Активные директории гаджетов';

  @override
  String kernelConfigFlags(int length) {
    return 'Флаги конфигурации ядра ($length)';
  }

  @override
  String get systemPaths => 'Системные пути';

  @override
  String rawKernelConfig(int length) {
    return 'Исходная конфигурация ядра ($length строк)';
  }

  @override
  String get physicalDeviceDetected => 'Обнаружено физическое устройство';

  @override
  String get emulatorDetected => 'Обнаружен эмулятор';

  @override
  String get thisIsAPhysicalDevice =>
      'Это физическое устройство — рекомендуемая среда для работы с USB-гаджетами. Вероятно, все функции HID будут работать корректно.';

  @override
  String get thisIsAnEmulator =>
      'По всей видимости, это эмулятор. Эмуляторы обычно не позволяют проверить корректность работы USB-гаджета или ConfigFS. Рекомендуется использовать физическое устройство с Root-доступом для полноценных операций HID.';

  @override
  String get requirementsForRealHID => 'Требования для работы с аппаратным HID';

  @override
  String get rootAccessMagiskKernelSUOrSuperSU =>
      'Root-доступ (Magisk, Kernel SU или SuperSU)';

  @override
  String get usbGadgetConfigFSKernelSupport =>
      'Поддержка USB-гаджета и ConfigFS на уровне ядра';

  @override
  String get usbOTGCableOrUSBCDataCable =>
      'Кабель USB OTG или дата-кабель USB-C';

  @override
  String get targetHostWithUSBHIDSupport => 'Целевой хост с поддержкой USB HID';

  @override
  String get failedToLoadDeviceInfo =>
      'Не удалось загрузить информацию об устройстве';

  @override
  String get failedToLoadDiagnostics =>
      'Не удалось загрузить результаты диагностики';
}
