# Terminal config

Локальный снимок настроек Rex, его терминала, оболочки и интерфейса OpenCode.
Рабочие конфиги остаются на своих местах. Автоматической синхронизации нет.

## Файлы

| Файл | Источник |
| --- | --- |
| `rex/init.lua` | `~/.config/rex/init.lua` |
| `rex/preferences.plist` | Настройки приложения `com.superlogical.rex` |
| `opencode/cli.json` | `~/.config/opencode/cli.json` |
| `opencode/themes/opencode-transparent.json` | Пользовательская тема OpenCode |
| `shell/.zprofile` | `~/.zprofile` |

В preferences сохранены настройки интерфейса, терминала, пользовательские темы,
интеграция с агентами, Remote Control, параметры локального сервера и автообновлений.
Ключи перечислены в `rex/preferences-keys.txt`.
Настройки, оставленные по умолчанию, приложение берёт из своей версии.

Адреса подключённых серверов, идентификаторы устройства, состояние сессий,
история, токены, кэши и данные Tailscale исключены.
Серверный конфиг OpenCode, MCP и авторизация сюда не входят.

## Текущий вид

- Rex в тёмном режиме.
- Пользовательская тема `Kanagawabones-Ghostty`.
- `Workspace.interfaceStyle = blendTheme`, `Workspace.usesPaneGlass = false`.
- Шрифт JetBrains Mono, 19 pt, лигатуры выключены.
- Отступы терминала: X = 13, Y = 7.
- OpenCode v2.3.0 с темой `opencode-transparent`.
- Основные фоны OpenCode прозрачные. Диалоги и diff сохраняют цветную подложку.

## Перенос на другой Mac

Сначала установи Rex, OpenCode V2 и JetBrains Mono.
Для интеграции из `init.lua` отдельно нужен resh в
`~/Library/Application Support/resh`. Его бинарник и `resh.lua` в репу не включены.
Если resh не нужен, убери его блок из копии `init.lua` перед установкой.

Ниже команды выполняются из корня этой репы.
Если задан `XDG_CONFIG_HOME` или `REX_CONFIG`, используй соответствующие пути.

### Rex

Сохрани существующий конфиг перед заменой:

```sh
mkdir -p ~/.config/rex
test ! -f ~/.config/rex/init.lua || cp -p ~/.config/rex/init.lua ~/.config/rex/init.lua.bak
sed "s|/Users/geprokhorov|$HOME|g" rex/init.lua > ~/.config/rex/init.lua
rex config check
rex config reload
```

Настройки окна, терминала и темы импортируются отдельно.
Заверши приложение Rex вручную перед импортом и снова открой после.
Экспорт ниже создаёт резервную копию прежних preferences.
На новом Mac без сохранённых preferences команда экспорта может сообщить об их отсутствии.

```sh
defaults export com.superlogical.rex ~/rex-preferences-before-import.plist
defaults import com.superlogical.rex "$PWD/rex/preferences.plist"
```

Импорт заменяет сохранённый домен preferences целиком.
Он также включает Remote Control, как на исходном Mac.
При необходимости отключи его в Settings > Server > Client Info.
Настройки оформления могут зависеть от версии Rex и macOS.

### OpenCode

Скопируй тему:

```sh
mkdir -p ~/.config/opencode/themes
cp opencode/themes/opencode-transparent.json ~/.config/opencode/themes/
```

Для полного совпадения настроек интерфейса сохрани прежний `cli.json` и скопируй наш:

```sh
test ! -f ~/.config/opencode/cli.json || cp -p ~/.config/opencode/cli.json ~/.config/opencode/cli.json.bak
cp opencode/cli.json ~/.config/opencode/cli.json
```

Либо сохрани свои настройки и поменяй только `theme.name` на `opencode-transparent`.
Перезапусти OpenCode после добавления файла темы.

### Оболочка

`shell/.zprofile` сохранён как исходный снимок. Объедини его со своим файлом вручную.
В нём есть Homebrew для Apple Silicon по пути `/opt/homebrew` и путь к автодополнениям
Avito CLI. Замени `/Users/geprokhorov` на свой домашний каталог.
Homebrew и Avito CLI устанавливаются отдельно.

## Обновление снимка

Изменения в настройках приложений сами в Git не попадут.
Копируй изменённые файлы в репу и проверяй `git diff` перед коммитом.
Не экспортируй весь домен Rex в репу без фильтрации.
Он содержит подключения и состояние устройства.
