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
  String get keyboard => 'Клавиатура';

  @override
  String get mouse => 'Мышь';

  @override
  String get composite => 'Композитный';

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
}
