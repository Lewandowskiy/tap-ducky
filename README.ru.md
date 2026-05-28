[EN](README.md)
# TapDucky — USB HID-инжектор нажатий клавиш для Android

<a href="https://github.com/iodn/tap-ducky/releases">
<img src="assets/images/logo.png" width="160" alt="TapDucky icon" align="left" style="border: solid 1px #ddd;"/>
</a>
<div>
<h3 style="font-size: 2.2rem; letter-spacing: 1px;">TapDucky — USB HID-инжектор нажатий клавиш для Android</h3>
<p style="font-size: 1.15rem; font-weight: 500;"> <strong>Эта программа для запуска DuckyScript-а для рутированных Андроид устройств с поддержкой USB-гаджета (ConfigFS)</strong><br> <strong>TapDucky</strong> позволяет создавать, настраивать, планировать и запускать DuckyScript на Android путем эмуляции USB-клавиатуры, мыши или композитного HID-устройства для авторизованного тестирования и автоматизации. Он включает параметризацию пейлоада, множественные триггеры планировщика, журналы выполнения и библиотеку пейлоадов, поддерживаемую GitHub, с автоматической проверкой DuckyScript и опциональным преобразованием в формат <code>.ino</code> Digispark.</p>

<div align="center">

  [![GitHub License](https://img.shields.io/github/license/iodn/tap-ducky)](LICENSE)
  [![Issues](https://img.shields.io/github/issues/iodn/tap-ducky.svg)](https://github.com/iodn/tap-ducky/issues)
  [![Pull Requests](https://img.shields.io/github/issues-pr/iodn/tap-ducky.svg)](https://github.com/iodn/tap-ducky/pulls)
  [![Android Version](https://img.shields.io/badge/Android-11.0%2B-green.svg)](https://www.android.com)
  [![Root Required](https://img.shields.io/badge/Root-Required-red.svg)](#)

  <div style="display:flex; align-items:center; gap:12px; flex-wrap:wrap; justify-content:center;">
   <a href="https://f-droid.org/en/packages/org.kaijinlab.tap_ducky/" style="display:inline-flex; align-items:center;">
    <img src="https://fdroid.gitlab.io/artwork/badge/get-it-on.png"
         alt="Get it on F-Droid"
         style="display:block; height:102px; width:auto;">
    </a>
    <a href="https://github.com/iodn/tap-ducky/releases" style="display:inline-flex; align-items:center;">
      <img src="assets/images/get-it-on-github.png" alt="GitHub Releases" style="display:block; height:100px; width:auto;">
    </a>
  </div>
</div>


## Обзор

- Профили USB HID-гаджетов (для поддерживаемых/рутированных устройств внешний USB-адаптер не требуется):
  - Профили клавиатуры, мыши и композитного интерфейса с настраиваемыми значениями VID/PID, строками производителя/модели и потребляемой мощностью.
- DuckyScript пайплайн:
  - Проверка в режиме реального времени с понятными для человека сообщениями об ошибках и предупреждениях, параметрами-заполнителями, множителем задержки и опциональным рандомизатором времени ввода для имитации человеческого ввода.
- Управление пейлоадом:
  - Создание и редактирование пейлоадов с указанием имени, описания, тегов и параметров; быстрый обмен, экспорт, а также встроенные шаблоны и мастер настройки.
- Хранилице пейлоадов в GitHub-е:
  - Добавление источников, просмотр репозиторий, просмотр файлов с проверкой, импорт поддерживаемых скриптов; автоматически определяет DuckyScript и, по возможности, конвертирует скетчи Digispark в формате `.ino`.
- Планировщик:
  - Один раз в указанную дату и время, при запуске приложения из режима ожидания, при переходе приложения в фоновый режим или при активации сеанса HID (device_connected), с возможностью установки ежедневного временного интервала.
- Выполнение и логи:
  - Вкладки для просмотра выполнения, запросы параметров, запуск/отмена, история выполнения и структурированные логи с возможностью экспорта/очистки и фильтрацией по уровню.
- Диагностика устройства:
  - Обзор устройства, состояние ядра/гаджета, информация об UDC, раскладки клавиатуры; копирование в буфер обмена; примечание по обнаружению эмулятора.

Примечание: Требуется устройство с правами root и поддержкой Linux USB-гаджет (ConfigFS). Используйте физическое устройство, так как эмуляторы не могут проверить работу HID-устройств.

## Функции
- Редактор пейлоада и параметров
  - Создание пейлоада с именем, описанием и тегами.
  - Добавление типизированных параметров со значениями по умолчанию, флагами обязательности и переопределениями на уровне отдельного выполнения.
  - Встроенный валидатор DuckyScript с сопоставлением строк и проблем, а также подсчетом количества команд.
  - Поделиться одним пейлоадом или отправить целый пак.

- Хранилице пейлоадов в GitHub-е
  - Управление несколькими источниками GitHub (пользователь/репозиторий/ветка/путь).
  - Просмотр каталогов и предварительный просмотр файлов с определением формата (DuckyScript, TapDucky JSON, конвертированные скрипты Digispark (.ino)).
  - Импортируйте проверенные скрипты прямо в свою библиотеку; в случае неудачной проверки отображается подробная информация с объяснением причины.

- Выполнение и тестирование
  - Проверка перед запуском; запрос значения параметров; запуск или отмена с указанием идентификаторов выполнения.
  - Быстрые тесты HID: нажатие клавиши на клавиатуре, движение мыши и комбинация клавиш Ctrl+Alt+Del.
  - Оценка времени выполнения на основе движка (соответствует фактической модели времени выполнения).
  - Функция Wakelock позволяет поддерживать активность сессий во время выполнения.

- Планировщик и триггеры
  - Триггеры: one_time, app_cold_start, app_foreground, device_connected (session armed).
  - Возможность выбора временного интервала на каждый день (ЧЧ:ММ → ЧЧ:ММ), включая период, заканчивающийся в полночь.
  - Включение/отключение, редактирование и удаление расписаний; отслеживается последний запуск.
  - Запуск скриптов с помощью секретных кодов (автозапуск + фоновое выполнение)
    - Поддерживаемые коды: *#*#38250#*#*, *#*#38251#*#*, *#*#38252#*#*, *#*#38253#*#*
    - Бинды для каждого кода: enabled, mode (last executed | selected payload), payload (when mode = selected payload)

- Устройства и профили HID
  - Активация клавиатуры, мыши или композитного профиля с настраиваемыми идентификаторами, строками или параметрами питания.
  - Выбор раскладки клавиатуры и определение кода/ID.
  - В активном режиме отображаются состояния ACTIVE/IDLE, готовность к записи и запросы на настройку хоста.

- Логи и истории
  - Вкладка «Логи» с фильтром по уровню (всё/информация/отладка/предупреждение/ошибка), экспорт для отправка, очистка всех данных.
  - Подробная история выполнения с метаданными и отправка.

### User‑facing
- Dashboard with quick status cards, payload/library stats, and scheduler summary.
- Clear empty states and step‑by‑step wizards for first‑time setup/imports.
- Material 3 theming, dynamic light/dark color schemes.

### Technical/architectural
- Platform channels (Android):
  - Method Channel: `org.kaijinlab.tap_ducky/gadget`
    - `checkRoot`, `checkSupport`, `listUdcs`, `getStatus`, `getDiagnostics`
    - `getKeyboardLayouts`, `setKeyboardLayout`, `resolveKeyboardLayoutId`, `setKeyboardLayoutByCode`
    - `activateProfile`, `deactivate`, `panicStop`, `retryOpenHidWriters`
    - `executeDuckyScript(script, delayMultiplier, executionId?)`, `cancelExecution(executionId)`
    - Test helpers: `testKeyboardKey(label)`, `testMouseMove(dx,dy,wheel,buttons)`, `testCtrlAltDel()`
  - Event Channels:
    - `org.kaijinlab.tap_ducky/gadget_logs`
    - `org.kaijinlab.tap_ducky/gadget_status`
    - `org.kaijinlab.tap_ducky/gadget_exec`
- HID Profiles model: keyboard/mouse/composite with VID/PID, strings, serial, power.
- DuckyScript:
  - Parsing to steps; supports DELAY/STRING/keys/raw commands; placeholder resolution; base key delay; jitter.
  - Validator returns issues with severity and line mapping; used across editor/store/execute flows.
  - TRY/CATCH/END_TRY, WAIT_FOR, SLEEP_UNTIL, FUNCTION args, and scoped variables.
  - Unicode fallback modes (warn+skip / skip / ASCII transliteration).
  - Structured exec error codes in the execution stream.
- Scheduling engine:
  - Triggers (cold start, foreground, armed, one‑time), daily time window rules, persistence in SharedPreferences.
- State management: Riverpod 3, go_router navigation, clean repository/services/controllers separation.

## DuckyScript / Keystroke Engine

TapDucky includes a full DuckyScript-style engine implemented natively on Android (Kotlin) with expression evaluation and structured control flow. It supports keyboard, mouse/pointer, timing, variables/defines, functions, and simple randomness utilities.

Supported command families (high level):
- Text and timing: STRING, STRINGLN, STRING_DELAY, DELAY, DEFAULTDELAY/DEFAULT_DELAY, REM (and REM_BLOCK)
- Keys and combos: ENTER, TAB, ESC, SPACE, BACKSPACE, arrows, navigation keys (HOME/END/PGUP/PGDN/INS/DEL), F1–F24, media keys, numpad keys
- Modifier combos: GUI/WIN/COMMAND, CTRL/CONTROL, ALT/OPTION, SHIFT with additional key tokens (e.g., GUI r, CTRL ALT DEL)
- Hold/release and injected modifiers: HOLD, RELEASE, INJECT_MOD (set/clear modifier mask persisting across subsequent key taps)
- Pointer/mouse: MOUSE/POINTER CLICK, HOLD, DRAG, MOVE, SCROLL with buttons LEFT/RIGHT/MIDDLE and relative dx/dy and repeat count
- Control flow: IF / ELSE IF / ELSE / END_IF, WHILE / END_WHILE
- Functions and calls: FUNCTION / END_FUNCTION, CALL_FUNCTION, RETURN
- Variables and constants: VAR $name = expr, DEFINE NAME value; $?(exit code) maintained as unsigned 16-bit
- Random generators: RANDOM_LOWERCASE_LETTER, RANDOM_UPPERCASE_LETTER, RANDOM_LETTER, RANDOM_NUMBER, RANDOM_SPECIAL, RANDOM_CHAR
- Attack mode passthrough: ATTACKMODE (proxied to the gadget manager layer when applicable)

Notes on behavior:
- Default delay: DEFAULTDELAY/DEFAULT_DELAY sets a base delay applied after each executable command (scaled by the run-time delay multiplier).
- Expression evaluator: arithmetic, comparisons, and logical expressions are supported in IF/WHILE and VAR assignments; non-zero is true.
- Repetition: REPEAT N duplicates the previous command N times during preprocessing.
- Keyboard mapping: full HID usage mapping with layout selection; common aliases supported (ESC/ESCAPE, BKSP/BACKSPACE, etc.).
- Execution streams: step/start/done/error events are emitted with progress, for real-time UI updates and logs.

Mouse/Pointer syntax quick reference:
- MOUSE CLICK [LEFT|RIGHT|MIDDLE] [num]
- MOUSE HOLD [LEFT|RIGHT|MIDDLE] [dx] [dy] [num]
- MOUSE DRAG [LEFT|RIGHT|MIDDLE] [dx] [dy] [num]
- MOUSE MOVE [dx] [dy] [num]
- MOUSE SCROLL [UP|DOWN] [num]

Capability matrix (selected):

| Feature group | Sub-feature | Supported | Notes |
|---|---|:---:|---|
| Text/timing | STRING / STRINGLN / STRING_DELAY | ✅ | Per-char timing for STRING_DELAY; global delay via DEFAULTDELAY |
| Text blocks | STRING/STRINGLN blocks | ✅ | Multiline blocks terminated by END_STRING / END_STRINGLN |
| Timing | DELAY, DEFAULTDELAY/DEFAULT_DELAY | ✅ | DEFAULT applies after each executable step |
| Repeat | REPEAT N | ✅ | Duplicates the previous command N times |
| Comments | REM, REM_BLOCK/END_REM | ✅ | Non-executable |
| Modifiers | GUI/WIN, CTRL, ALT, SHIFT combos | ✅ | Parsed as a single combo step |
| Key commands | Explicit key names | ✅ | All keys/aliases listed in “Explicit key and alias support” |
| Hold/release | HOLD, RELEASE | ✅ | Tracks held set; pairs with INJECT_MOD |
| Explicit key state | KEYDOWN, KEYUP | ✅ | Direct key down/up control for combos and held keys |
| Injected modifiers | INJECT_MOD | ✅ | Persisting modifier mask until cleared |
| Mouse/pointer | MOUSE/POINTER CLICK/HOLD/DRAG/MOVE/SCROLL | ✅ | Relative motion with repeat counts |
| Control flow | IF/ELSE IF/ELSE/END_IF | ✅ | Nested chains supported |
| Loops | WHILE/END_WHILE | ✅ | Condition evaluated with expression engine |
| Functions | FUNCTION/END_FUNCTION, CALL/CALL_FUNCTION, RETURN | ✅ | Supports arguments; RETURN sets $? |
| Variables | VAR $name = expr | ✅ | Integers, 0..65535 stored; $? is exit code; scoped locals |
| Defines | DEFINE NAME value | ✅ | Simple text substitution before parse |
| Error handling | TRY/CATCH/END_TRY | ✅ | Recoverable failures without aborting script |
| Waits | WAIT_FOR, SLEEP_UNTIL | ✅ | Host/UDC/keyboard readiness + timed waits |
| Random | RANDOM_* generators | ✅ | Lower/upper/letter/number/special/char |
| Attack modes | ATTACKMODE | ⚠️ | Parsed, but no backend handler is implemented yet |

Note: The validator surfaces syntax issues, unknown commands, and structure errors before execution. See the Payload Editor for in-UI validation results with line numbers.

Execution timing highlights:
- Separate execution delay multiplier and typing speed factor (with optional risky fast mode).
- Periodic flush during long STRING runs to reduce host keybuffer overruns.
- Host-aware backoff and grace window for transient HID disconnects.
- Hardware-aware estimate calibration when micro-sleep is unavailable.


### Explicit key and alias support

Note: In addition to the listed aliases, TapDucky accepts snake_case forms like down_arrow, up_arrow, left_arrow, right_arrow, page_up, page_down, print_screen, scroll_lock, num_lock, caps_lock, string_delay, default_delay, etc. These are normalized internally.
- Modifiers (left/right variants supported where noted):
  - Left: CTRL/CONTROL, SHIFT, ALT/OPTION, GUI/WINDOWS/COMMAND/WIN
  - Right: RCTRL/RCONTROL, RSHIFT, RALT, RGUI/RWINDOWS/RCOMMAND

- System/navigation keys (aliases included):
  - ENTER
  - ESC/ESCAPE
  - BACKSPACE/BKSP
  - TAB
  - SPACE
  - DELETE/DEL
  - INSERT/INS
  - HOME, END
  - PAGEUP, PAGEDOWN
  - Arrows: UP/UPARROW, DOWN/DOWNARROW, LEFT/LEFTARROW, RIGHT/RIGHTARROW
  - LOCKS: CAPSLOCK, NUMLOCK, SCROLLLOCK
  - PRINTSCREEN/PRINTSCRN/PRTSCN
  - PAUSE/BREAK
  - MENU/APP

- Function keys:
  - F1–F24

- Numpad keys (aliases included):
  - NUMPAD_0/KP0, NUMPAD_1/KP1, NUMPAD_2/KP2, NUMPAD_3/KP3, NUMPAD_4/KP4,
    NUMPAD_5/KP5, NUMPAD_6/KP6, NUMPAD_7/KP7, NUMPAD_8/KP8, NUMPAD_9/KP9
  - NUMPAD_PLUS/KPPLUS, NUMPAD_MINUS/KPMINUS, NUMPAD_MULTIPLY/KPASTERISK,
    NUMPAD_DIVIDE/KPSLASH, NUMPAD_ENTER/KPENTER, NUMPAD_PERIOD/KPDOT

- Media keys (aliases included):
  - MEDIA_PLAYPAUSE/PLAYPAUSE
  - MEDIA_STOP/STOPCD
  - MEDIA_PREV/PREVIOUSSONG
  - MEDIA_NEXT/NEXTSONG
  - MEDIA_VOLUMEUP/VOLUMEUP
  - MEDIA_VOLUMEDOWN/VOLUMEDOWN
  - MEDIA_MUTE/MUTE

- Alphanumeric shortcuts:
  - Single characters A–Z and digits 0–9 map to corresponding HID usage codes.

### Examples

- CTRL ALT DEL
- GUI r
- SHIFT TAB
- STRING_DELAY 15 Hello world
- MOUSE CLICK LEFT 2
- MOUSE MOVE 40 0 3

## Scheduler Triggers (Details)

- One‑time
  - Runs once at a specified date/time, if within the optional time window.
- App Start (Cold Start)
  - Runs once when the app starts from a true cold start (not when resuming from background).
- App Open (Foreground)
  - Runs each time the app comes to the foreground; can run many times.
- Session Armed
  - Runs when the HID session is armed (USB gadget binds to UDC) — typically when you tap "Arm Session".

## Payloads Management

- Create/edit payloads with parameters and defaults.
- Validate scripts live; open the DuckyScript Syntax reference.
- Share individual payloads or export a pack; import from the GitHub Store.

## Device Diagnostics

- View kernel/UDC list, HID writers readiness, active profile state, host configuration request count, and more.
- Copy values to clipboard and refresh snapshot/diagnostics independently.

## Developer Notes

- All privileged HID actions require root and a kernel with ConfigFS gadget support.
- On Android 8+, notifications use a dedicated channel; foreground service keeps the HID session active.
- App avoids coupling runtime UI strings to Android resources in the service layer to reduce resource merge risk.

## Requirements

- Rooted Android device with Linux USB Gadget (ConfigFS) support
- Android 11+
- Physical device (emulators cannot validate USB gadget behavior)

## Installation

1. Download the latest APK from Releases:

  <a href="https://github.com/iodn/tap-ducky/releases" style="display:inline-flex;">
    <img src="assets/images/get-it-on-github.png" alt="GitHub Releases" style="display:block; height:28px; width:auto;">
  </a>

2. Install the application:
   - Enable installation from unknown sources if needed.
   - Grant root when prompted by your root manager.

3. Launch and Configure:
   - Open TapDucky.
   - In Advanced Settings, choose/adjust HID profile (Keyboard/Mouse/Composite), VID/PID, and keyboard layout.
   - Arm a session and run a test command from Execute.

## Usage

### Running a Payload
1. Create or import a payload (Payloads tab).
2. Validate it and add parameters if needed.
3. Go to Execute, select the payload, fill parameters, and Run.
4. Check Logs and Execution History for results.

### Scheduling a Payload
1. Open Scheduler.
2. Create a schedule, choose trigger (one‑time, cold start, foreground, armed).
3. Optionally set a daily time window and parameter overrides.
4. Save and ensure the schedule is enabled.

### Import from GitHub Store
1. Open Payloads Store.
2. Manage sources (add `owner/repo` or full URL with branch/path).
3. Preview files; TapDucky validates DuckyScript and can convert Digispark sketches.
4. Import supported files directly to your payloads.

## Screenshots

  <img width="180" height="400" alt="TapDucky app screenshot 1" src="fastlane/metadata/android/en-US/images/phoneScreenshots/1.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 2" src="fastlane/metadata/android/en-US/images/phoneScreenshots/2.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 3" src="fastlane/metadata/android/en-US/images/phoneScreenshots/3.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 4" src="fastlane/metadata/android/en-US/images/phoneScreenshots/4.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 5" src="fastlane/metadata/android/en-US/images/phoneScreenshots/5.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 6" src="fastlane/metadata/android/en-US/images/phoneScreenshots/6.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 7" src="fastlane/metadata/android/en-US/images/phoneScreenshots/7.png" />
  <img width="180" height="400" alt="TapDucky app screenshot 8" src="fastlane/metadata/android/en-US/images/phoneScreenshots/8.png" />
  <br><br><br>
  <img src="fastlane/metadata/android/en-US/images/featureGraphic.png" alt="TapDucky Banner App" style="display:block; height:260px; width:auto;">


## Contributing

Contributions are welcome! If you'd like to help improve TapDucky:
1. Fork the repository.
2. Create a new branch for your feature or bug fix.
3. Submit a pull request with your proposed changes.

## License

This project is licensed under the GNU GPLv3 License. See [LICENSE](LICENSE).

## Support

If you encounter any issues or have questions, please open an issue on the GitHub repository or contact the maintainer.

## More Apps by KaijinLab!

| App                                                               | What it does                                                                 |
| ----------------------------------------------------------------- | ---------------------------------------------------------------------------- |
| **[IR Blaster](https://github.com/iodn/android-ir-blaster)**      | Control and test infrared functionality for compatible devices.              |
| **[USBDevInfo](https://github.com/iodn/android-usb-device-info)** | Inspect USB device details and behavior to understand what's connected.      |
| **[GadgetFS](https://github.com/iodn/gadgetfs)**                   | Experiment with USB gadget functionality (hardware‑adjacent, low‑level).     |
| **[TapDucky](https://github.com/iodn/tap-ducky)**                  | A security/testing tool for controlled keystroke injection workflows.        |
| **[HIDWiggle](https://github.com/iodn/hid-wiggle)**                | A mouse jiggler built with USB gadget functionalities.                       |
| **[AKTune](https://github.com/iodn/android-kernel-tweaker)**       | Adaptive Android kernel auto‑tuner for CPU/GPU/scheduler/memory/I/O.         |
