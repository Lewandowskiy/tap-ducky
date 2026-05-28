// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Russian (`ru`).
class AppLocalizationsRu extends AppLocalizations {
  AppLocalizationsRu([String locale = 'ru']) : super(locale);

  @override
  String get language => 'Язык';

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
  String failedToLoadPayloadsError(String error) {
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
  String get themeLoggingHIDConfig => 'Тема, логирование, конфигурация HID';

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
  String get logging => 'Логирование';

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
  String get available => 'Доступно';

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

  @override
  String get failedToLoadPayloads => 'Не удалось загрузить пейлоады';

  @override
  String get noPayloadsAvailable => 'Нет доступных пейлоадов';

  @override
  String get createOrImportAPayloadFirst =>
      'Сначала создайте или импортируйте пейлоад.';

  @override
  String get executionSpeed => 'Скорость выполнения';

  @override
  String get ultra => 'Ультра';

  @override
  String get fast => 'Быстро';

  @override
  String get normal => 'Обычно';

  @override
  String get slow => 'Медленно';

  @override
  String get speedMultiplier => 'Множитель скорости';

  @override
  String get executionSpeedScalesScriptDelaysTypingSpeedIsSetInSettings =>
      'Скорость выполнения увеличивает задержки в скрипте. Скорость ввода текста задается в настройках.';

  @override
  String get estimatedDuration => 'Примерная длит.';

  @override
  String get original => 'Исходная: ';

  @override
  String get adjusted => 'Измененная: ';

  @override
  String basedOnCountCommandsAndSecOfDelays(int count, String sec) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count команд',
      many: '$count команд',
      few: '$count команд',
      one: '$count команды',
    );
    return 'На основе $_temp0 и $sec сек задержек';
  }

  @override
  String get slowerSpeedsFasterSpeeds =>
      'Используйте меньшую скорость (2×–4×) для нестабильно работающих целей или при отладке. Более высокую скорость (0.25×–0.5×) — для быстрого тестирования.';

  @override
  String millisec(int ms) {
    return '$msмс';
  }

  @override
  String sec(String sec) {
    return '$secс';
  }

  @override
  String minAndSec(int min, int sec) {
    return '$minм $secс';
  }

  @override
  String get verySlow => 'Очень медленно';

  @override
  String get veryFast => 'Очень быстро';

  @override
  String get rootShellAvailable => 'Доступна Root-оболочка';

  @override
  String get usbHIDSupport => 'Поддержка USB HID';

  @override
  String get usbGadgetConfigfsDetected => 'Обнаружен USB-гаджет/configfs';

  @override
  String get deviceDoesNotSupportUSBGadgetMode =>
      'Устройство не поддерживает режим USB-гаджета';

  @override
  String get hidSessionArmed => 'Сессия HID переведена в режим готовности';

  @override
  String get usbGadgetIsActive => 'USB-гаджет активен';

  @override
  String get armSessionFromDashboardToActivateUSBGadget =>
      'Переведите сессию в режим готовности в «Дашборде» для активации USB-гаджета';

  @override
  String get targetDeviceConnected => 'Цель подключена';

  @override
  String get usbCableConnectedToTarget => 'USB-кабель подключен к цели';

  @override
  String get connectUSBCableToTargetDeviceOptionalForTesting =>
      'Подключите USB-кабель к цели (необязательно для тестирования)';

  @override
  String get payloadSelected => 'Пейлоад выбран';

  @override
  String payloadName(String name) {
    return 'Пейлоад: $name';
  }

  @override
  String get requiredParameters => 'Обязательные параметры';

  @override
  String get fillInAllRequiredParametersAbove =>
      'Заполните все обязательные параметры выше';

  @override
  String get allRequiredParametersProvided =>
      'Все обязательные параметры указаны';

  @override
  String get preExecutionChecklist => 'Предварительный список проверки';

  @override
  String checksPassed(int passedCount, int totalCount) {
    return 'Пройдено проверок: $passedCount из $totalCount';
  }

  @override
  String get fixCriticalIssuesAboveBeforeExecuting =>
      'Устраните критические проблемы выше перед выполнением';

  @override
  String get required => 'ОБЯЗАТЕЛЬНО';

  @override
  String get rootHIDUnavailable => 'Root/HID недоступны';

  @override
  String get noDeviceConnected => 'Устройство не подключено';

  @override
  String get executingThreePoints => 'Выполнение...';

  @override
  String get readyToExecute => 'Готово к запуску';

  @override
  String get selectedPayload => 'Выбранный пейлоад';

  @override
  String get payload => 'Пейлоад';

  @override
  String get editPayload => 'Редактировать пейлоад';

  @override
  String get parameters => 'Параметры';

  @override
  String get execution => 'Выполнение';

  @override
  String get runPayload => 'Запустить пейлоад';

  @override
  String get rootAccessNotAvailable => 'Нет Root-доступа';

  @override
  String get usbHIDNotSupported => 'USB HID не поддерживается';

  @override
  String get sessionIsDisarmedArmItFromDashboardFirst =>
      'Сессия отключена. Сначала переведите ее в режим готовности в «Дашборде».';

  @override
  String get cannotExecute => 'Невозможно выполнить';

  @override
  String get console => 'Консоль';

  @override
  String get events => 'События';

  @override
  String get sendRawHIDCommands => 'Отправка необработанных команд HID';

  @override
  String get saveAsPreset => 'Сохранить как пресет';

  @override
  String get quickCommands => 'Быстрые команды';

  @override
  String get selectAPreset => 'Выберите пресет...';

  @override
  String get examples => 'Примеры';

  @override
  String get enterACommandFirstBeforeSavingAsPreset =>
      'Сначала введите команду перед сохранением в качестве пресета';

  @override
  String get presetNameOptional => 'Название пресета (необязательно)';

  @override
  String get egOpenNotepad => 'Пр., Открывает блокнот';

  @override
  String get command => 'Команда';

  @override
  String get cancel => 'Отмена';

  @override
  String get save => 'Сохранить';

  @override
  String get presetSavedSuccessfully => 'Пресет успешно сохранен';

  @override
  String get runAPayloadToSeeExecutionEvents =>
      'Запустите пейлоад, чтобы увидеть события выполнения';

  @override
  String get noEventsYet => 'Событий пока нет';

  @override
  String secAgo(int sec) {
    return '$secс назад';
  }

  @override
  String minAgo(int min) {
    return '$minм назад';
  }

  @override
  String get noBrowserAvailable => 'Нет доступного браузера';

  @override
  String failedToOpenError(String error) {
    return 'Не удалось открыть: $error';
  }

  @override
  String get resetAllSettingsQuestionMark => 'Сбросить все настройки?';

  @override
  String get thisWillRestoreAllSettingsToTheirDefaults =>
      'Это приведет к восстановлению всех настроек по умолчанию.';

  @override
  String get reset => 'Сбросить';

  @override
  String get settingsResetToDefaults =>
      'Настройки сброшены до значений по умолчанию';

  @override
  String failedToLoadSettingsError(String error) {
    return 'Не удалось загрузить настройки: $error';
  }

  @override
  String get resetAllSettings => 'Сбросить все настройки';

  @override
  String get supportDevelopment => 'Поддержать разработку';

  @override
  String get keepThisAppFastFreeAndMaintained =>
      'Помогите приложению оставаться быстрым, бесплатным и обновляемым';

  @override
  String get supportDescription =>
      'Без рекламы, без отслеживания, без платных функций. Ваша поддержка помогает этой альтернативе Rubber Ducky оставаться независимой и свободно доступной для специалистов по тестированию на проникновение по всему миру.';

  @override
  String get donate => 'Donate';

  @override
  String get repositoryLinkCopied => 'Ссылка на репозиторий скопирована';

  @override
  String get starRepo => 'Star Repo';

  @override
  String get localOnly => 'Локально';

  @override
  String get noTracking => 'Без отслеживания';

  @override
  String get lightweight => 'Легковесное';

  @override
  String get openSource => 'Open-source код';

  @override
  String get appearance => 'Внешний вид';

  @override
  String get customizeYourVisualExperience =>
      'Настройка визуального оформления';

  @override
  String get auto => 'Авто';

  @override
  String get light => 'Светлая';

  @override
  String get dark => 'Темная';

  @override
  String get controlPayloadBehaviorAndTiming =>
      'Управление поведением и таймингами пейлоадов';

  @override
  String get speedAndTiming => 'Скорость и тайминги';

  @override
  String get resetDefaults => 'Сбросить настройки';

  @override
  String get adjustScriptDelaysAndRawKeyPressTiming =>
      'Регулировка задержек в скрипте и таймингов необработанных нажатий клавиш.';

  @override
  String executionSpeedMultiplier(String label, String multiplier) {
    return '$label • $multiplier×';
  }

  @override
  String get typingSpeed => 'Скорость ввода';

  @override
  String typingSpeedMultiplier(String label, String multiplier) {
    return '$label • $multiplier×';
  }

  @override
  String get lowerIsFaster =>
      'Чем меньше значение, тем быстрее. Управляет таймингом необработанных нажатий клавиш (ввод текста STRING).';

  @override
  String get ultraFast => 'Ультра быстро';

  @override
  String get ultraFastDescription =>
      'Ультра быстрый режим может работать нестабильно на некоторых хостах.';

  @override
  String get advancedExecution => 'Расширенное выполнение';

  @override
  String get loggingHIDReliabilityUnicodeFallback =>
      'Логирование, надежность HID, резервный вариант для Unicode';

  @override
  String get enableLogging => 'Включить логирование';

  @override
  String get recordExecutionEventsAndOutcomes =>
      'Записывать события и результаты выполнения';

  @override
  String get randomizeTiming => 'Рандомизировать тайминг';

  @override
  String get addsSmallJitterToMimicRealTyping =>
      'Добавляет небольшое случайное отклонение времени для имитации реального ввода текста';

  @override
  String get hidGraceWindow => 'Окно ожидания HID';

  @override
  String hidGraceWindowMS(int ms) {
    return '$ms мс';
  }

  @override
  String get waitBrieflyForHIDToBecomeActiveBeforeFailingAWrite =>
      'Кратковременное ожидание активации HID перед отменой записи из-за ошибки.';

  @override
  String get unicodeFallback => 'Резервный вариант для Unicode';

  @override
  String get warnAndSkip => 'Warn & Skip';

  @override
  String get skip => 'Skip';

  @override
  String get asciiTransliterate => 'ASCII Transliterate';

  @override
  String get controlsHowUnsupportedCharactersAreHandledDuringTyping =>
      'Определяет, как обрабатываются неподдерживаемые символы во время ввода текста.';

  @override
  String get riskyFastModeCanCauseMissedOrStuckKeysOnSomeHosts =>
      'Нестабильный быстрый режим может приводить к пропуску или залипанию клавиш на некоторых хостах.';

  @override
  String get riskyFastMode => 'Нестабильный быстрый режим';

  @override
  String get allowsShorterKeyHoldAndInterKeyDelaysMayBeUnreliable =>
      'Позволяет сократить время удержания клавиш и задержки между ними. Может работать ненадежно.';

  @override
  String get keepScreenOn => 'Не выключать экран';

  @override
  String get preventsScreenFromSleepingDuringExecution =>
      'Предотвращает переход экрана в спящий режим во время выполнения';

  @override
  String get mayIncreaseBatteryUsageScreenWillStayOnEvenWhenAppIsInBackground =>
      'Может увеличить расход батареи. Экран будет оставаться включенным, даже когда приложение находится в фоновом режиме.';

  @override
  String get stealthMode => 'Скрытный режим';

  @override
  String get covertOperationCapabilities => 'Возможности для скрытых операций';

  @override
  String get hiddenExecution => 'Скрытое выполнение';

  @override
  String get hiddenExecutionDescription =>
      'Если функция «Не выключать экран» отключена, полезные нагрузки могут выполняться при выключенном экране. Это позволяет проводить скрытые операции, при которых устройство кажется неактивным.';

  @override
  String get useCases => 'Варианты использования';

  @override
  String get useCasesDescription =>
      '• Экран ВКЛ: интерактивное тестирование, отладка, демонстрация\n• Экран ВЫКЛ: запланированные задачи, автоматизированные операции, скрытое выполнение';

  @override
  String get payloadsStore => 'Магазин пейлоадов';

  @override
  String get browseGitHubRepositoriesAndImportPayloads =>
      'Просмотр репозиториев GitHub и импорт пейлоадов';

  @override
  String get openPayloadsStore => 'Открыть магазин пейлоадов';

  @override
  String get manageAndImportFromMultipleRepos =>
      'Управление и импорт из нескольких репозиториев';

  @override
  String get advanced => 'Расширенные';

  @override
  String get usbGadgetPresetsAndHotkeys =>
      'USB-гаджет, пресеты и горячие клавиши';

  @override
  String get advancedSettings => 'Расширенные настройки';

  @override
  String get commandPresetsHotkeysDefaultVidPid =>
      'Пресеты команд, горячие клавиши, VID/PID по умолчанию';

  @override
  String get hidControl => 'Управление HID';

  @override
  String get usbGadgetSessionStatus => 'Статус сессии USB-гаджета';

  @override
  String get rootAvailable => 'Root доступен';

  @override
  String get hidSupported => 'HID поддерживается';

  @override
  String get hidSession => 'Сессия HID';

  @override
  String get hidSessionDescription =>
      'Управление сессией HID активирует или деактивирует USB-гаджет. Подробную диагностику можно посмотреть на экране «Устройство».';

  @override
  String get about => 'О приложении';

  @override
  String get appInformationAndLegal =>
      'Информация о приложении и правовая информация';

  @override
  String version(String version) {
    return 'Версия $version';
  }

  @override
  String get licences => 'Лицензии';

  @override
  String get openSourceLicenses => 'Лицензии открытого ПО';

  @override
  String get autoTheme => 'Автоматическая тема';

  @override
  String get lightTheme => 'Светлая тема';

  @override
  String get darkTheme => 'Темная тема';

  @override
  String get followsYourDeviceSettings =>
      'Соответствует настройкам вашего устройства';

  @override
  String get alwaysBrightAndClear => 'Всегда яркая и четкая';

  @override
  String get easyOnTheEyes => 'Комфортно для глаз';

  @override
  String get themeModeSystem =>
      'Тема автоматически переключается при изменении настроек вашего устройства между светлым и темным режимами';

  @override
  String get themeModeLight =>
      'Отлично подходит для использования в дневное время и при хорошем освещении';

  @override
  String get themeModeDark =>
      'Снижает нагрузку на глаза в условиях низкой освещенности и экономит заряд батареи на OLED-экранах';

  @override
  String get useDynamicColors => 'Использовать динамические цвета';

  @override
  String get matchYourSystemMaterialYouPaletteOnSupportedDevices =>
      'Настройте палитру Material You в соответствии с вашей системой на поддерживаемых устройствах.';

  @override
  String get dynamicColorsAreOnlyAvailableOnAndroid12 =>
      'Динамические цвета доступны только на Android 12+.';

  @override
  String countSelected(int count) {
    return 'Выбрано: $count';
  }

  @override
  String get runFirstSelected => 'Запустить первую выбранную';

  @override
  String get armSessionToRun =>
      'Переведите сессию в режим готовности для запуска';

  @override
  String get deleteSelected => 'Удалить выбранные';

  @override
  String get githubStore => 'Магазин GitHub';

  @override
  String get exportAll => 'Экспорт всего';

  @override
  String get importFromClipboard => 'Импорт из буфера обмена';

  @override
  String get manageSources => 'Управление источниками';

  @override
  String get selectMultiple => 'Выбрать несколько';

  @override
  String get tipImportPayloadsFromTheGitHubStore =>
      'Совет: импортируйте пейлоады из магазина GitHub';

  @override
  String get open => 'Открыть';

  @override
  String searching(String query) {
    return 'Поиск: \"$query\"';
  }

  @override
  String get newPayload => 'Новый пейлоад';

  @override
  String get payloadDuplicated => 'Пейлоад продублирован';

  @override
  String get deletePayload => 'Удалить пейлоад';

  @override
  String deletePayloadThisCanNotBeUndone(String name) {
    return 'Удалить «$name»? Это действие нельзя отменить.';
  }

  @override
  String get delete => 'Удалить';

  @override
  String get deletePayloads => 'Удалить пейлоады';

  @override
  String deleteCountPayloadsThisCanNotBeUndone(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пейлоадов',
      few: '$count пейлоада',
      one: '1 пейлоад',
    );
    return 'Удалить $_temp0? Это действие нельзя отменить.';
  }

  @override
  String get importPayloads => 'Импорт пейлоадов';

  @override
  String get pastePayloadJSONOrAPayloadPackJSONBelow =>
      'Вставьте ниже JSON пейлоада или пакет JSON пейлоадов:';

  @override
  String get import => 'Импорт';

  @override
  String get noPayloadsFoundInInput =>
      'В введенных данных пейлоадов не обнаружено.';

  @override
  String importedCountPayloads(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: 'Импортированы',
      few: 'Ипортировано',
      one: 'Импортирован',
    );
    String _temp1 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count пейлоадов',
      few: '$count пейлоада',
      one: ' 1 пейлоад',
    );
    return '$_temp0 $_temp1.';
  }

  @override
  String importFailedError(String error) {
    return 'Не удалось выполнить импорт: $error';
  }

  @override
  String get searchPayloads => 'Поиск пейлоадов';

  @override
  String get search => 'Поиск';

  @override
  String get nameTagsScriptContent => 'Название, теги, содержимое скрипта...';

  @override
  String get all => 'Все';

  @override
  String get collapse => 'Свернуть';

  @override
  String get expandPreview => 'Развернуть';

  @override
  String get scriptPreview => 'Предпросмотр скрипта';

  @override
  String get duplicate => 'Дублировать';

  @override
  String get export => 'Экспорт';

  @override
  String get yourScriptLibrary => 'Ваша библиотека скриптов';

  @override
  String get createOrganizeAndExecuteYourCustomHIDPayloads =>
      'Создавайте, упорядочивайте и выполняйте свои кастомные пейлоады HID';

  @override
  String get createAPayload => 'Создать пейлоад';

  @override
  String get writeDuckyScriptCommandsOrUseTemplates =>
      'Пишите команды DuckyScript или используйте шаблоны';

  @override
  String get organizeWithTags => 'Упорядочивание с помощью тегов';

  @override
  String get groupPayloadsByCategoryOrPurpose =>
      'Группируйте пейлоады по категориям или назначению';

  @override
  String get executeAndShare => 'Выполненить и отправить';

  @override
  String get runOnTargetOrExportToShare =>
      'Запускайте на целевой системе или экспортируйте для совместного использования';

  @override
  String get createYourFirstPayload => 'Создайте свой первый пейлоад';

  @override
  String get importExistingPayloads => 'Импортировать существующие пейлоады';

  @override
  String get noPayloadsFound => 'Пейлоады не найдены';

  @override
  String noResultsForQuery(String query) {
    return 'Нет результатов по запросу «$query»';
  }

  @override
  String noPayloadsWithTag(String tag) {
    return 'Нет пейлоадов с тегом «$tag»';
  }

  @override
  String get tryAdjustingYourFilters =>
      'Попробуйте изменить настройки фильтров';

  @override
  String get clearFilters => 'Сбросить фильтры';

  @override
  String get discardChanges => 'Отклонить изменения?';

  @override
  String get youHaveUnsavedChangesDiscardThem =>
      'У вас есть несохраненные изменения. Отклонить их?';

  @override
  String get showValidationIssues => 'Показать проблемы валидации';

  @override
  String get thisIsABuildInPayload =>
      'Это встроенный пейлоад. Вы можете продублировать ее, чтобы создать собственную версию.';

  @override
  String get basicInfo => 'Основная информация';

  @override
  String get name => 'Название';

  @override
  String get egWindowsRunDialog => 'пр., Откр. «Выполнить» в Windows';

  @override
  String get nameIsRequired => 'Обязателен';

  @override
  String get description => 'Описание';

  @override
  String get whatDoesThisPayloadDo => 'Что делает этот пейлоад?';

  @override
  String get tags => 'Теги';

  @override
  String get windowsReconExfilCommaSeparated => 'windows, lang (через запятую)';

  @override
  String get script => 'Скрипт';

  @override
  String get syntax => 'Синтаксис';

  @override
  String get helloWorld => 'Привет, мир';

  @override
  String get scriptIsRequired => 'Обязателен';

  @override
  String usePARAM_NAMEForDynamicValues(String PARAM_NAME) {
    return 'Используйте $PARAM_NAME для динамических значений';
  }

  @override
  String parametersCount(int count) {
    return 'Параметры ($count)';
  }

  @override
  String get add => 'Добавить';

  @override
  String get noParameters => 'Нет параметров';

  @override
  String get addParametersToMakeThispayloadReusableWithDifferentValues =>
      'Добавьте параметры, чтобы использовать этот пейлоад повторно с другими значениями.';

  @override
  String get quickActions => 'Быстрые действия';

  @override
  String get createACopyOfThisPayload => 'Создать копию этого пейлоада';

  @override
  String get shareAsJSON => 'Поделиться как JSON';

  @override
  String get removeThisPayloadPermanently =>
      'Удалить этот пейлоад безвозвратно';

  @override
  String get cannotSaveScriptHasValidationErrors =>
      'Не удалось сохранить: в скрипте присутствуют ошибки валидации';

  @override
  String get payloadCreated => 'Пейлоад создан';

  @override
  String get payloadUpdated => 'Пейлоад обновлен';

  @override
  String get duckyScriptSyntax => 'Синтаксис DuckyScript';

  @override
  String get keystrokeInjection => 'Имитация нажатия клавиш';

  @override
  String get text => 'текст';

  @override
  String get typeText => 'Ввод текста';

  @override
  String get typeTextPlusEnter => 'Ввод текста + Enter';

  @override
  String get ms => 'мс';

  @override
  String get waitMilliseconds => 'Ожидание в миллисекундах';

  @override
  String get pressEnter => 'Нажатие Enter';

  @override
  String get pressTab => 'Нажатие Tab';

  @override
  String get pressEscape => 'Нажатие Escape';

  @override
  String get pressBackspace => 'Нажатие Backspace';

  @override
  String get pressDelete => 'Нажатие Delete';

  @override
  String get parameterPlaceholder => 'Плейсхолдер параметра';

  @override
  String get defineVariable => 'Определить переменную';

  @override
  String get defineConstant => 'Определить константу';

  @override
  String get close => 'Закрыть';

  @override
  String get scriptHasErrors => 'В скрипте есть ошибки';

  @override
  String get scriptHasWarnings => 'В скрипте есть предупреждения';

  @override
  String get scriptIsValid => 'Скрипт корректен';

  @override
  String countCommands(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count команд',
      few: '$count команды',
      one: '1 команда',
    );
    return '$_temp0';
  }

  @override
  String countErrors(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count ошибок',
      few: '$count ошибки',
      one: '1 ошибка',
    );
    return '$_temp0';
  }

  @override
  String countWarnings(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count предупреждений',
      few: '$count предупреждения',
      one: '1 предупреждение',
    );
    return '$_temp0';
  }

  @override
  String get validationResults => 'Результаты валидации';

  @override
  String totalDelays(String sec) {
    return 'Общая задержка: $secс';
  }

  @override
  String get noIssuesFoundScriptIsValid =>
      'Проблем не обнаружено. Скрипт корректен!';

  @override
  String issuesCount(int count) {
    return 'Проблемы: $count';
  }

  @override
  String lineNum(int num) {
    return 'Строка $num';
  }

  @override
  String get paramRequired => 'обязательно';

  @override
  String get addParameter => 'Добавить параметр';

  @override
  String get editParameter => 'Редактировать параметр';

  @override
  String get key => 'Ключ';

  @override
  String get requiredCap => 'Обязателен';

  @override
  String get label => 'Метка';

  @override
  String get targetIPAddress => 'Целевой IP-адрес';

  @override
  String get optionalDescription => 'Опциональное описание';

  @override
  String get textCap => 'Текст';

  @override
  String get number => 'Число';

  @override
  String get url => 'URL';

  @override
  String get type => 'Тип';

  @override
  String get defaultValue => 'Значение по умолчанию';

  @override
  String get keyboardOnly => 'Только клавиатура';

  @override
  String get mouseOnly => 'Только мышь';

  @override
  String get compositeKeyboardMouse => 'Композитное';

  @override
  String get keyboardProfileDescription =>
      'Одиночное HID-устройство клавиатуры. Используется для ввода текста и комбинаций клавиш.';

  @override
  String get mouseProfileDescription =>
      'Одиночное HID-устройство мыши. Используется для перемещения курсора и кликов.';

  @override
  String get compositeProfileDescription =>
      'Совмещение клавиатуры и мыши. Рекомендуется для большинства полезных нагрузок.';

  @override
  String get selectUSBGadgetProfile => 'Выберите профиль USB-гаджета';

  @override
  String get chooseTheHIDDeviceTypeToActivate =>
      'Выберите тип HID-устройства для активации:';

  @override
  String get activate => 'Активировать';

  @override
  String get recommended => 'РЕКОМЕНД.';

  @override
  String get clearLogs => 'Очистить логи';

  @override
  String get deleteAllStoredLogs => 'Удалить все сохраненные логи?';

  @override
  String get clear => 'Очистить';

  @override
  String get clearAll => 'Очистить все';

  @override
  String get level => 'Уровень:';

  @override
  String failedToLoadLogsError(String error) {
    return 'Не удалось загрузить логи: $error';
  }

  @override
  String get noLogsYet => 'Логов пока нет';

  @override
  String get noMatchingLogs => 'Нет соответствующих логов';

  @override
  String get runAPayloadToGenerateLogs =>
      'Запустите пейлоад для генерации логов.';

  @override
  String get changeTheLevelFilterToSeeMoreEntries =>
      'Измените фильтр уровня, чтобы увидеть больше записей.';

  @override
  String get logEntry => 'Запись лога';

  @override
  String get share => 'Поделиться';

  @override
  String failedToLoadLogs(String error) {
    return 'Не удалось загрузить логи: $error';
  }

  @override
  String get logEntryNotFound => 'Запись лога не найдена.';

  @override
  String get metadata => 'Метаданные';

  @override
  String get noMetadata => 'Нет метаданных';

  @override
  String get failedToLoadHistory => 'Не удалось загрузить историю';

  @override
  String get noExecutionHistory => 'Нет истории выполнения';

  @override
  String get runAPayloadToSeeExecutionHistoryHere =>
      'Запустите пейлоад, чтобы увидеть здесь историю выполнения.';

  @override
  String get clearExecutionHistory => 'Очистить историю выполнения';

  @override
  String get thisWillDeleteAllExecutionLogs =>
      'Это приведет к удалению всех логов выполнения. Данное действие нельзя отменить.';

  @override
  String get total => 'Всего';

  @override
  String get success => 'Успешно';

  @override
  String get failed => 'Не удачные';

  @override
  String get hour => 'ч';

  @override
  String countEvents(int count) {
    String _temp0 = intl.Intl.pluralLogic(
      count,
      locale: localeName,
      other: '$count событий',
      few: '$count события',
      one: '1 событие',
    );
    return '$_temp0';
  }

  @override
  String get executionDetails => 'Сведения о выполнении';

  @override
  String get executionID => 'ID выпол.';

  @override
  String get started => 'Запущено';

  @override
  String get finished => 'Завершено';

  @override
  String get duration => 'Длительность';

  @override
  String eventsCount(int count) {
    return 'Событий ($count)';
  }

  @override
  String get sAgo => 'с назад';

  @override
  String get mAgo => 'мин назад';

  @override
  String get hAgo => 'ч назад';

  @override
  String get dAgo => 'дн назад';
}
