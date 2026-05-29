import 'dart:math';

import '../../l10n/app_localizations.dart';

class ValidationIssue {
  const ValidationIssue({
    required this.line,
    required this.severity,
    required this.message,
    this.suggestion,
  });

  final int line;
  final IssueSeverity severity;
  final String message;
  final String? suggestion;

  @override
  String toString() => 'Line $line: $message${suggestion != null ? " → $suggestion" : ""}';
}

enum IssueSeverity {
  error,
  warning,
  info;

  String get label {
    switch (this) {
      case IssueSeverity.error:
        return 'ERROR';
      case IssueSeverity.warning:
        return 'WARNING';
      case IssueSeverity.info:
        return 'INFO';
    }
  }
}

class ValidationResult {
  const ValidationResult({
    required this.issues,
    required this.commandCount,
    required this.estimatedDurationMs,
    required this.totalDelayMs,
    required this.hasErrors,
    required this.hasWarnings,
  });

  final List<ValidationIssue> issues;
  final int commandCount;

  final int estimatedDurationMs;
  final int totalDelayMs;

  final bool hasErrors;
  final bool hasWarnings;

  int get errorCount => issues.where((i) => i.severity == IssueSeverity.error).length;
  int get warningCount => issues.where((i) => i.severity == IssueSeverity.warning).length;
  int get infoCount => issues.where((i) => i.severity == IssueSeverity.info).length;

  String get estimatedDurationFormatted {
    final seconds = estimatedDurationMs / 1000;
    if (seconds < 1) return '${estimatedDurationMs}ms';
    if (seconds < 60) return '${seconds.toStringAsFixed(1)}s';
    final minutes = seconds ~/ 60;
    final remainingSeconds = (seconds % 60).round();
    return '${minutes}m ${remainingSeconds}s';
  }

  factory ValidationResult.empty() => const ValidationResult(
        issues: [],
        commandCount: 0,
        estimatedDurationMs: 0,
        totalDelayMs: 0,
        hasErrors: false,
        hasWarnings: false,
      );
}

class DuckyScriptValidator {
  static const _supportedCommands = {
    'REM',
    'REM_BLOCK',
    'END_REM',
    'STRING',
    'STRINGLN',
    'STRING_DELAY',
    'STRINGDELAY',
    'END_STRING',
    'END_STRINGLN',
    'UP',
    'DOWN',
    'LEFT',
    'RIGHT',
    'UPARROW',
    'DOWNARROW',
    'LEFTARROW',
    'RIGHTARROW',
    'PAGEUP',
    'PAGEDOWN',
    'HOME',
    'END',
    'INSERT',
    'DELETE',
    'DEL',
    'BACKSPACE',
    'BKSP',
    'TAB',
    'SPACE',
    'ENTER',
    'ESCAPE',
    'ESC',
    'PAUSE',
    'BREAK',
    'PRINTSCREEN',
    'PRINTSCRN',
    'PRTSCN',
    'MENU',
    'APP',
    'F1',
    'F2',
    'F3',
    'F4',
    'F5',
    'F6',
    'F7',
    'F8',
    'F9',
    'F10',
    'F11',
    'F12',
    'F13',
    'F14',
    'F15',
    'F16',
    'F17',
    'F18',
    'F19',
    'F20',
    'F21',
    'F22',
    'F23',
    'F24',
    'SHIFT',
    'ALT',
    'CONTROL',
    'CTRL',
    'COMMAND',
    'WINDOWS',
    'GUI',
    'OPTION',
    'INJECT_MOD',
    'CAPSLOCK',
    'NUMLOCK',
    'SCROLLLOCK',
    'DELAY',
    'DEFAULTDELAY',
    'DEFAULT_DELAY',
    'DEFINE',
    'VAR',
    'IF',
    'THEN',
    'ELSE',
    'ELSE_IF',
    'END_IF',
    'ENDIF',
    'WHILE',
    'END_WHILE',
    'ENDWHILE',
    'FUNCTION',
    'END_FUNCTION',
    'ENDFUNCTION',
    'RETURN',
    'REPEAT',
    'HOLD',
    'RELEASE',
    'KEYDOWN',
    'KEYUP',
    'ATTACKMODE',
    'TRY',
    'CATCH',
    'END_TRY',
    'ENDTRY',
    'WAIT_FOR',
    'WAITFOR',
    'SLEEP_UNTIL',
    'SLEEPUNTIL',
    'RANDOM_LOWERCASE_LETTER',
    'RANDOMLOWERCASELETTER',
    'RANDOM_UPPERCASE_LETTER',
    'RANDOMUPPERCASELETTER',
    'RANDOM_LETTER',
    'RANDOMLETTER',
    'RANDOM_NUMBER',
    'RANDOMNUMBER',
    'RANDOM_SPECIAL',
    'RANDOMSPECIAL',
    'RANDOM_CHAR',
    'RANDOMCHAR',
    'NUMPAD_0',
    'NUMPAD_1',
    'NUMPAD_2',
    'NUMPAD_3',
    'NUMPAD_4',
    'NUMPAD_5',
    'NUMPAD_6',
    'NUMPAD_7',
    'NUMPAD_8',
    'NUMPAD_9',
    'NUMPAD_PLUS',
    'NUMPAD_MINUS',
    'NUMPAD_MULTIPLY',
    'NUMPAD_DIVIDE',
    'NUMPAD_ENTER',
    'NUMPAD_PERIOD',
    'KP0',
    'KP1',
    'KP2',
    'KP3',
    'KP4',
    'KP5',
    'KP6',
    'KP7',
    'KP8',
    'KP9',
    'KPPLUS',
    'KPMINUS',
    'KPASTERISK',
    'KPSLASH',
    'KPENTER',
    'KPDOT',
    'MEDIA_PLAYPAUSE',
    'PLAYPAUSE',
    'MEDIA_STOP',
    'STOPCD',
    'MEDIA_PREV',
    'PREVIOUSSONG',
    'MEDIA_NEXT',
    'NEXTSONG',
    'MEDIA_VOLUMEUP',
    'VOLUMEUP',
    'MEDIA_VOLUMEDOWN',
    'VOLUMEDOWN',
    'MEDIA_MUTE',
    'MUTE',
    'MOUSE',
    'POINTER',
  };

  static const _commonTypos = {
    'STRNIG': 'STRING',
    'STIRNG': 'STRING',
    'STRIGN': 'STRING',
    'SRING': 'STRING',
    'STRNG': 'STRING',
    'STRIG': 'STRING',
    'STTRING': 'STRING',
    'STIRNIG': 'STRING',
    'STING': 'STRING',
    'STRIN': 'STRING',
    'STRINGG': 'STRING',
    'DLEAY': 'DELAY',
    'DEALY': 'DELAY',
    'DELYA': 'DELAY',
    'DALAY': 'DELAY',
    'DLAEY': 'DELAY',
    'DELAYY': 'DELAY',
    'DELAT': 'DELAY',
    'DELAYA': 'DELAY',
    'ENER': 'ENTER',
    'ENTEER': 'ENTER',
    'ENTR': 'ENTER',
    'ENETR': 'ENTER',
    'ETNER': 'ENTER',
    'ENRTE': 'ENTER',
    'ENTRE': 'ENTER',
    'ENTTER': 'ENTER',
    'ENTERD': 'ENTER',
    'CRTL': 'CTRL',
    'CONTRL': 'CTRL',
    'CTLR': 'CTRL',
    'CRL': 'CTRL',
    'CNTRL': 'CTRL',
    'COTRL': 'CTRL',
    'ATL': 'ALT',
    'ALTT': 'ALT',
    'SHFIT': 'SHIFT',
    'SHTIF': 'SHIFT',
    'SHFT': 'SHIFT',
    'SHIF': 'SHIFT',
    'WIDNOWS': 'WINDOWS',
    'WINODWS': 'WINDOWS',
    'WINDWOS': 'WINDOWS',
    'WINDOS': 'WINDOWS',
    'WNDOWS': 'WINDOWS',
    'WINOWS': 'WINDOWS',
    'SUPER': 'GUI',
    'META': 'GUI',
    'WIN': 'WINDOWS',
    'ESACPE': 'ESCAPE',
    'ESCPE': 'ESCAPE',
    'ESCAP': 'ESCAPE',
    'ECSAPE': 'ESCAPE',
    'BACKPSACE': 'BACKSPACE',
    'BAKCSPACE': 'BACKSPACE',
    'BACKSAPCE': 'BACKSPACE',
    'BACKSPCAE': 'BACKSPACE',
    'BACKSPAC': 'BACKSPACE',
    'BAKCSAPCE': 'BACKSPACE',
    'BCKSPACE': 'BACKSPACE',
    'RME': 'REM',
    'DELTE': 'DELETE',
    'DLEETE': 'DELETE',
    'DELET': 'DELETE',
    'DEETE': 'DELETE',
    'DEELTE': 'DELETE',
    'DELETTE': 'DELETE',
  };

  static const int _minDelayMs = 20;

  static const int _baseKeyMs = 25;
  static const int _baseMouseMs = 20;
  static const int _commandOverheadMs = 3;

  ValidationResult validate(
    String script, {
    double delayMultiplier = 1.0,
    required AppLocalizations l10n,
  }) {
    final issues = <ValidationIssue>[];

    final normalizedScript = script.replaceAll('\r\n', '\n').replaceAll('\r', '\n');
    final rawLines = normalizedScript.split('\n');

    int commandCount = 0;

    int totalDelayMs = 0;
    int keyTimeMs = 0;
    int overheadMs = 0;

    int defaultDelayMs = 0;
    int stringDelayMs = 0;

    bool inRemBlock = false;
    bool inStringBlock = false;
    bool inStringLnBlock = false;

    final Set<String> declaredFunctions = {};
    int ifDepth = 0;
    int whileDepth = 0;
    int tryDepth = 0;
    final tryHasCatch = <bool>[];
    int functionDepth = 0;

    int lastCommandTotalMs = 0;

    int scaledMs(int ms) {
      if (ms <= 0) return 0;
      final v = (ms * (delayMultiplier <= 0 ? 1.0 : delayMultiplier)).round();
      return max(0, v);
    }

    int approxTextLen(String text) {
      if (text.isEmpty) return 0;
      final replaced = text.replaceAll(RegExp(r'\{\{[^}]+\}\}'), 'XXXXXXXX');
      return replaced.length;
    }

    void addDefaultDelayIfAny() {
      if (defaultDelayMs <= 0) return;
      final d = scaledMs(defaultDelayMs);
      totalDelayMs += d;
      lastCommandTotalMs += d;
    }

    void commitCommand({
      required int keyCount,
      required int perCharDelayMs,
      required int charCount,
      bool addEnter = false,
      bool applyDefaultDelay = true,
      int extraDelayMs = 0,
      int extraKeyCount = 0,
      int extraOverheadMs = 0,
    }) {
      final keys = keyCount + (addEnter ? 1 : 0) + extraKeyCount;
      final kMs = scaledMs(keys * _baseKeyMs);
      keyTimeMs += kMs;

      final perCharDelayScaled = scaledMs(perCharDelayMs);
      final dMs = (charCount > 0) ? (perCharDelayScaled * charCount) : 0;
      totalDelayMs += dMs;

      final extraDelayScaled = scaledMs(extraDelayMs);
      totalDelayMs += extraDelayScaled;

      final oMs = scaledMs(_commandOverheadMs + extraOverheadMs);
      overheadMs += oMs;

      lastCommandTotalMs = kMs + dMs + extraDelayScaled + oMs;

      if (applyDefaultDelay) {
        addDefaultDelayIfAny();
      }
    }

    void typeText(String text, {required int perCharDelay, bool addEnter = false}) {
      final len = approxTextLen(text);
      commitCommand(
        keyCount: len,
        perCharDelayMs: perCharDelay,
        charCount: len,
        addEnter: addEnter,
      );
    }

    for (int i = 0; i < rawLines.length; i++) {
      final lineNum = i + 1;

      final rawLine = rawLines[i];
      final trimmed = rawLine.trim();

      if (trimmed.isEmpty) continue;

      if (inRemBlock) {
        if (trimmed.toUpperCase() == 'END_REM') {
          inRemBlock = false;
        }
        continue;
      }

      if (inStringBlock) {
        if (trimmed.toUpperCase() == 'END_STRING') {
          inStringBlock = false;
          continue;
        }
        typeText(rawLine, perCharDelay: stringDelayMs, addEnter: true);
        continue;
      }

      if (inStringLnBlock) {
        if (trimmed.toUpperCase() == 'END_STRINGLN') {
          inStringLnBlock = false;
          continue;
        }
        typeText(rawLine, perCharDelay: stringDelayMs, addEnter: true);
        continue;
      }

      final upperTrimmed = trimmed.toUpperCase();
      if (upperTrimmed.startsWith('REM ') || upperTrimmed == 'REM') {
        continue;
      }

      final parts = trimmed.split(RegExp(r'\s+'));
      if (parts.isEmpty) continue;

      final command = parts[0].toUpperCase();

      if (_commonTypos.containsKey(command)) {
        issues.add(ValidationIssue(
          line: lineNum,
          severity: IssueSeverity.error,
          message: l10n.unknownCommand(command),
          suggestion: l10n.didYouMean(_commonTypos[command].toString()),
        ));
        continue;
      }

      switch (command) {
        case 'REM_BLOCK':
          inRemBlock = true;
          break;

        case 'STRING':
          commandCount++;
          if (trimmed.length <= 6 || trimmed.substring(6).trim().isEmpty) {
            inStringBlock = true;
          } else {
            final text = trimmed.substring(6);
            typeText(text, perCharDelay: stringDelayMs, addEnter: false);
          }
          break;

        case 'STRINGLN':
          commandCount++;
          if (trimmed.length <= 8 || trimmed.substring(8).trim().isEmpty) {
            inStringLnBlock = true;
          } else {
            final text = trimmed.substring(8);
            typeText(text, perCharDelay: stringDelayMs, addEnter: true);
          }
          break;

        case 'STRING_DELAY':
        case 'STRINGDELAY':
          commandCount++;
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.stringDelayRequiresANumericDelayValue,
              suggestion: l10n.exampleStringDelay100Hello,
            ));
            break;
          }
          final delayArg = int.tryParse(parts[1]);
          if (delayArg == null) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.stringDelayRequiresANumericDelayValue,
              suggestion: l10n.exampleStringDelay50,
            ));
            break;
          }
          if (parts.length == 2) {
            stringDelayMs = max(0, delayArg);
            commitCommand(
              keyCount: 0,
              perCharDelayMs: 0,
              charCount: 0,
              applyDefaultDelay: true,
            );
          } else {
            final text = parts.skip(2).join(' ');
            typeText(text, perCharDelay: max(0, delayArg), addEnter: false);
          }
          break;

        case 'DEFAULTDELAY':
        case 'DEFAULT_DELAY':
          final ms = parts.length > 1 ? int.tryParse(parts[1]) : null;
          if (ms == null) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.defaultDelayRequiresANumericValue,
            ));
          } else {
            defaultDelayMs = max(0, ms);
          }
          break;

        case 'DELAY':
          commandCount++;
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.delayRequiresATimeValueInMilliseconds,
              suggestion: l10n.exampleDelay500,
            ));
            break;
          }
          final delayValue = int.tryParse(parts[1]);
          if (delayValue == null) {
            if (!parts[1].startsWith('\$')) {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.error,
                message: l10n.delayValueMustBeANumberOrVariable,
                suggestion: l10n.exampleDelay500OrDelayMyDelay,
              ));
            }
            commitCommand(
              keyCount: 0,
              perCharDelayMs: 0,
              charCount: 0,
              extraDelayMs: _minDelayMs,
            );
          } else {
            if (delayValue < _minDelayMs) {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.warning,
                message: l10n.delayMinimumValueIsMS(_minDelayMs),
                suggestion: l10n.useDelayMinMSOrHigher(_minDelayMs),
              ));
            }
            commitCommand(
              keyCount: 0,
              perCharDelayMs: 0,
              charCount: 0,
              extraDelayMs: max(_minDelayMs, delayValue),
            );
          }
          break;

        case 'SLEEP_UNTIL':
        case 'SLEEPUNTIL':
          commandCount++;
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'WAIT_FOR':
        case 'WAITFOR':
          commandCount++;
          if (parts.length >= 2) {
            final target = parts[1].toUpperCase();
            const allowed = {
              'HOST_CONNECTED',
              'HOST',
              'UDC_CONFIGURED',
              'UDC',
              'KEYBOARD_READY',
              'KBD_READY',
              'MOUSE_READY',
              'SESSION_ARMED',
              'ACTIVE',
            };
            if (!allowed.contains(target)) {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.warning,
                message: l10n.waitForTargetNotRecognized(target),
                suggestion: l10n.useHostConnectedEtc,
              ));
            }
          }
          if (parts.length >= 3) {
            final ms = int.tryParse(parts[2]);
            if (ms != null) {
              commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0, extraDelayMs: max(0, ms));
              break;
            }
          }
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'TRY':
        case 'CATCH':
        case 'END_TRY':
        case 'ENDTRY':
          break;

        case 'DEFINE':
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.defineRequiresANameAndValue,
              suggestion: l10n.exampleDefineAppNotepad,
            ));
          }
          break;

        case 'VAR':
          commandCount++;
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.varRequiresAVariableName,
              suggestion: l10n.exampleVarCounter0,
            ));
          } else {
            final varName = parts[1];
            if (!varName.startsWith('\$')) {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.error,
                message: l10n.variableNameMustStartWithDollar,
                suggestion: l10n.exampleVarCounter0,
              ));
            }
          }
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'FUNCTION':
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.functionRequiresAName,
              suggestion: l10n.exampleFunctionMyFunction,
            ));
          } else {
            final m = RegExp(r'^FUNCTION\s+([A-Za-z_][A-Za-z0-9_]*)', caseSensitive: false)
                .firstMatch(trimmed);
            final funcName = m?.group(1) ?? parts[1].replaceAll(RegExp(r'[()]'), '');
            declaredFunctions.add(funcName.toLowerCase());
            functionDepth++;
          }
          break;

        case 'END_FUNCTION':
        case 'ENDFUNCTION':
          if (functionDepth <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.endFunctionWithoutMatchingFunction,
            ));
          } else {
            functionDepth--;
          }
          break;

        case 'RETURN':
          commandCount++;
          if (functionDepth <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.warning,
              message: l10n.returnOutsideOfFunction,
            ));
          }
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'IF':
          ifDepth++;
          commandCount++;
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'ELSE':
          if (ifDepth <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.elseWithoutMatchingIf,
            ));
          }
          break;

        case 'END_IF':
        case 'ENDIF':
          if (ifDepth <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.endIfWithoutMatchingIf,
            ));
          } else {
            ifDepth--;
          }
          break;

        case 'WHILE':
          whileDepth++;
          commandCount++;
          commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
          break;

        case 'END_WHILE':
        case 'ENDWHILE':
          if (whileDepth <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.endWhileWithoutMatchingWhile,
            ));
          } else {
            whileDepth--;
          }
          break;

        case 'TRY':
          tryDepth++;
          tryHasCatch.add(false);
          break;

        case 'CATCH':
          if (tryDepth <= 0 || tryHasCatch.isEmpty) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.catchWithoutMatchingTry,
            ));
          } else {
            tryHasCatch[tryHasCatch.length - 1] = true;
          }
          break;

        case 'END_TRY':
        case 'ENDTRY':
          if (tryDepth <= 0 || tryHasCatch.isEmpty) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.endTryWithoutMatchingTry,
            ));
          } else {
            tryDepth--;
            tryHasCatch.removeLast();
          }
          break;

        case 'REPEAT':
          commandCount++;
          final count = parts.length > 1 ? int.tryParse(parts[1]) : null;
          if (count == null || count <= 0) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.repeatRequiresANumericCount,
              suggestion: l10n.exampleRepeat5,
            ));
          } else if (lastCommandTotalMs > 0) {
            final repeated = lastCommandTotalMs * count;
            final repeatedScaled = scaledMs(repeated);
            final ratio = delayMultiplier <= 0 ? 1.0 : delayMultiplier;
            final estimatedUnscaled = (repeatedScaled / ratio).round();

            final alreadyAccountedDefaultDelay = 0;

            totalDelayMs += 0;
            keyTimeMs += 0;
            overheadMs += 0;

            final add = repeatedScaled - alreadyAccountedDefaultDelay;
            overheadMs += add;
          }
          break;

        case 'MOUSE':
        case 'POINTER':
          commandCount++;
          if (parts.length < 2) {
            issues.add(ValidationIssue(
              line: lineNum,
              severity: IssueSeverity.error,
              message: l10n.mouseRequiresAnAction,
            ));
          }
          final kMs = scaledMs(_baseMouseMs);
          keyTimeMs += kMs;
          final oMs = scaledMs(_commandOverheadMs);
          overheadMs += oMs;
          lastCommandTotalMs = kMs + oMs;
          addDefaultDelayIfAny();
          break;

        default:
          final funcCallMatch =
              RegExp(r'^([A-Za-z_][A-Za-z0-9_]*)\s*\(.*\)\s*$').firstMatch(trimmed);
          if (funcCallMatch != null) {
            commandCount++;
            final funcName = funcCallMatch.group(1)!.toLowerCase();
            if (!declaredFunctions.contains(funcName)) {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.warning,
                message: l10n.functionNotDeclaredInThisScript(funcName),
                suggestion: l10n.declareItWithFunction(funcName),
              ));
            }
            commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
            break;
          }

          final assignMatch =
              RegExp(r'^(\$[A-Za-z_][A-Za-z0-9_]*|\$\?)\s*=\s*(.+)$').firstMatch(trimmed);
          if (assignMatch != null) {
            commandCount++;
            commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
            break;
          }

          if (_supportedCommands.contains(command)) {
            commandCount++;
            if (_isSingleKeyCommand(command)) {
              commitCommand(keyCount: 1, perCharDelayMs: 0, charCount: 0);
            } else if (_isRandomCharCommand(command)) {
              commitCommand(keyCount: 1, perCharDelayMs: 0, charCount: 0);
            } else if (command == 'HOLD' || command == 'RELEASE') {
              commitCommand(keyCount: 1, perCharDelayMs: 0, charCount: 0);
            } else {
              commitCommand(keyCount: 0, perCharDelayMs: 0, charCount: 0);
            }
          } else {
            // Accept hyphen-separated combos, e.g., CTRL-ALT-T or CTRL-ALT t
            final normalized = trimmed.replaceAll('-', ' ');
            final comboParts = normalized.split(RegExp(r'\s+')).where((e) => e.isNotEmpty).toList();
            final isModifierCombo = comboParts.every((p) {
              final upper = p.toUpperCase();
              return _supportedCommands.contains(upper) ||
                  upper == 'CTRL' ||
                  upper == 'ALT' ||
                  upper == 'SHIFT' ||
                  upper == 'GUI' ||
                  upper == 'WINDOWS' ||
                  upper == 'COMMAND' ||
                  RegExp(r'^[A-Z0-9]$').hasMatch(upper);
            });

            if (isModifierCombo) {
              commandCount++;
              final keyCount = max(1, parts.length);
              commitCommand(keyCount: keyCount, perCharDelayMs: 0, charCount: 0);
            } else {
              issues.add(ValidationIssue(
                line: lineNum,
                severity: IssueSeverity.warning,
                message: '${l10n.unknownCommand} $command',
                suggestion: _findClosestCommand(command, l10n),
              ));
            }
          }
          break;
      }
    }

    if (ifDepth > 0) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.countUnclosedIfStatements(ifDepth),
        suggestion: l10n.addEndIfForEachIf,
      ));
    }
    if (whileDepth > 0) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.countUnclosedWhileLoops(whileDepth),
        suggestion: l10n.addEndWhileForEachWhile,
      ));
    }
    if (functionDepth > 0) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.countUnclosedFunctions(functionDepth),
        suggestion: l10n.addEndFunctionForEachFunction,
      ));
    }
    if (tryDepth > 0) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.countUnclosedTryBlocks(tryDepth),
        suggestion: l10n.addEndTryForEachTry,
      ));
    }
    if (inRemBlock) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.unclosedRemBlock,
      ));
    }
    if (inStringBlock) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.unclosedStringBlock,
      ));
    }
    if (inStringLnBlock) {
      issues.add(ValidationIssue(
        line: 0,
        severity: IssueSeverity.error,
        message: l10n.unclosedStringlnBlock,
      ));
    }

    final estimatedDurationMs = max(0, totalDelayMs + keyTimeMs + overheadMs);
    final hasErrors = issues.any((i) => i.severity == IssueSeverity.error);
    final hasWarnings = issues.any((i) => i.severity == IssueSeverity.warning);

    return ValidationResult(
      issues: issues,
      commandCount: commandCount,
      estimatedDurationMs: estimatedDurationMs,
      totalDelayMs: totalDelayMs,
      hasErrors: hasErrors,
      hasWarnings: hasWarnings,
    );
  }

  bool _isSingleKeyCommand(String cmd) {
    switch (cmd) {
      case 'ENTER':
      case 'TAB':
      case 'ESC':
      case 'ESCAPE':
      case 'BACKSPACE':
      case 'BKSP':
      case 'DELETE':
      case 'DEL':
      case 'SPACE':
      case 'UP':
      case 'DOWN':
      case 'LEFT':
      case 'RIGHT':
      case 'UPARROW':
      case 'DOWNARROW':
      case 'LEFTARROW':
      case 'RIGHTARROW':
      case 'PAGEUP':
      case 'PAGEDOWN':
      case 'HOME':
      case 'END':
      case 'INSERT':
      case 'CAPSLOCK':
      case 'NUMLOCK':
      case 'SCROLLLOCK':
      case 'PRINTSCREEN':
      case 'PRINTSCRN':
      case 'PRTSCN':
      case 'MENU':
      case 'APP':
      case 'PAUSE':
      case 'BREAK':
      case 'F1':
      case 'F2':
      case 'F3':
      case 'F4':
      case 'F5':
      case 'F6':
      case 'F7':
      case 'F8':
      case 'F9':
      case 'F10':
      case 'F11':
      case 'F12':
      case 'F13':
      case 'F14':
      case 'F15':
      case 'F16':
      case 'F17':
      case 'F18':
      case 'F19':
      case 'F20':
      case 'F21':
      case 'F22':
      case 'F23':
      case 'F24':
      case 'MEDIA_PLAYPAUSE':
      case 'PLAYPAUSE':
      case 'MEDIA_STOP':
      case 'STOPCD':
      case 'MEDIA_PREV':
      case 'PREVIOUSSONG':
      case 'MEDIA_NEXT':
      case 'NEXTSONG':
      case 'MEDIA_VOLUMEUP':
      case 'VOLUMEUP':
      case 'MEDIA_VOLUMEDOWN':
      case 'VOLUMEDOWN':
      case 'MEDIA_MUTE':
      case 'MUTE':
        return true;
      default:
        return false;
    }
  }

  bool _isRandomCharCommand(String cmd) {
    switch (cmd) {
      case 'RANDOM_LOWERCASE_LETTER':
      case 'RANDOMLOWERCASELETTER':
      case 'RANDOM_UPPERCASE_LETTER':
      case 'RANDOMUPPERCASELETTER':
      case 'RANDOM_LETTER':
      case 'RANDOMLETTER':
      case 'RANDOM_NUMBER':
      case 'RANDOMNUMBER':
      case 'RANDOM_SPECIAL':
      case 'RANDOMSPECIAL':
      case 'RANDOM_CHAR':
      case 'RANDOMCHAR':
        return true;
      default:
        return false;
    }
  }

  String? _findClosestCommand(String input, AppLocalizations l10n) {
    final upper = input.toUpperCase();
    if (_commonTypos.containsKey(upper)) {
      return l10n.didYouMean(_commonTypos[upper].toString());
    }
    String? closest;
    int minDistance = 999;
    for (final cmd in _supportedCommands) {
      final distance = _levenshteinDistance(upper, cmd);
      if (distance < minDistance && distance <= 3) {
        minDistance = distance;
        closest = cmd;
      }
    }
    return closest != null ? l10n.didYouMean(closest) : null;
  }

  int _levenshteinDistance(String s1, String s2) {
    if (s1 == s2) return 0;
    if (s1.isEmpty) return s2.length;
    if (s2.isEmpty) return s1.length;

    final len1 = s1.length;
    final len2 = s2.length;
    final matrix = List.generate(len1 + 1, (_) => List.filled(len2 + 1, 0));

    for (int i = 0; i <= len1; i++) {
      matrix[i][0] = i;
    }
    for (int j = 0; j <= len2; j++) {
      matrix[0][j] = j;
    }

    for (int i = 1; i <= len1; i++) {
      for (int j = 1; j <= len2; j++) {
        final cost = s1[i - 1] == s2[j - 1] ? 0 : 1;
        matrix[i][j] = min(
          min(matrix[i - 1][j] + 1, matrix[i][j - 1] + 1),
          matrix[i - 1][j - 1] + cost,
        );
      }
    }
    return matrix[len1][len2];
  }
}
