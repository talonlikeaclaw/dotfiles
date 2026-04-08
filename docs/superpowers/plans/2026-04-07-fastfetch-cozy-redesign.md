# Fastfetch Cozy Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Update fastfetch to display a Catppuccin-colored eagle ASCII art logo stacked above a concise, platform-agnostic info box with a time-aware greeting.

**Architecture:** Two file changes in the `fastfetch` stow package — `eagle.txt` gets `${c1}`–`${c4}` color prefix variables added per section, and `config.jsonc` is updated with a new `logo` block pointing to the file, a greeting `command` module, and all nerd font glyphs removed. No new dependencies.

**Tech Stack:** fastfetch config (JSONC), ASCII art color variables, POSIX shell (greeting command), GNU Stow

---

## File Map

| File | Action |
|---|---|
| `fastfetch/.config/fastfetch/eagle.txt` | Modify — prefix each line with `${c1}`–`${c4}` color variables |
| `fastfetch/.config/fastfetch/config.jsonc` | Modify — new logo block, add greeting module, remove kernel, drop nerd font glyphs, add `showErrors: false` on GPU |

---

### Task 1: Add Catppuccin color variables to eagle.txt

**Files:**
- Modify: `fastfetch/.config/fastfetch/eagle.txt`

The eagle is 32 lines. Each line gets a `${cN}` prefix. Fastfetch logo files use `${c1}`, `${c2}`, etc. as color variables that map to the values defined in `logo.color` in config.jsonc. The color is applied from that prefix to the end of the line (fastfetch resets between lines).

Color sections:
- Lines 1–8: `${c1}` (Teal)
- Lines 9–16: `${c2}` (Sky)
- Lines 17–24: `${c3}` (Sapphire)
- Lines 25–32: `${c4}` (Green)

- [ ] **Step 1: Replace eagle.txt with the color-annotated version**

Write the following content exactly to `fastfetch/.config/fastfetch/eagle.txt`:

```
${c1}              ______
${c1}           ,-'  __ ,`--.
${c1}         ,'  ,-'O) \' _ \
${c1}        /  _     _,:,'-`'
${c1}       :  , /  ,'   :
${c1}       ; : \ (    ) |
${c1}      /. \_ `-`  /, `.
${c1}     /;`-._\    '/ \  `.
${c2}    // `- ,`'  ,' -','`-`.
${c2}   /`:/  '-'  ._,  / `-'`-\
${c2}  ;`-|`/   /   ,  :`-'`-'`-\
${c2}  |`-: `-' `-' `- |-'`-'`-':
${c2}  :`-: |  |_ |  | :`-'`-'`-|
${c2}  :`- :`-'   `-' `\'`-'`-'`;
${c2}  \`-'\ \_, \_, |_:-'`-'`-':
${c2}   \-''\    '-     \`-'`-'`/
${c3}    `.-'\ \  `-'  `-:`-'`-'\
${c3}      \-'\ `-'  \_, |'`-'`-':
${c3}       :-'\ \_      : ' ' ' :
${c3}       `.-'\  `-' \  \ ' ' ';
${c3}         \-':`-'  :  : ' ' '\
${c3}          `.|  `-':. (/ ;',';
${c3}            ;`-'  \/'.\( ( (:
${c3}             ),._// /. :''`.:
${c4}            _/ /_/  )'`|''`.(
${c4}       _..-`_,-`_. ( ' :''`.;
${c4}      (,;/;_,-''  \,:' |\'`.:`.
${c4}     / (,(/        `/\ ||\`.|  \
${c4}    ;-'' '   ,-'   .  `:||:.(-. \
${c4} ,-' .    /         `   \| `'  `'
${c4}'    ':._        )     ,'('
${c4}               ,'        \
```

- [ ] **Step 2: Verify the color variables render correctly**

Run:
```bash
fastfetch --logo ~/.config/fastfetch/eagle.txt \
  --logo-position top \
  --logo-color-1 "38;2;148;228;213" \
  --logo-color-2 "38;2;137;220;235" \
  --logo-color-3 "38;2;116;199;236" \
  --logo-color-4 "38;2;166;227;161" \
  --structure ""
```

Expected: the eagle renders in four color bands — teal at the top, fading through sky and sapphire, to green at the talons. No literal `${c1}` text visible.

- [ ] **Step 3: Commit**

```bash
git add fastfetch/.config/fastfetch/eagle.txt
git commit -m "feat: add catppuccin color variables to eagle ascii art"
```

---

### Task 2: Update config.jsonc

**Files:**
- Modify: `fastfetch/.config/fastfetch/config.jsonc`

Replace the entire file with the following. Key changes from the original:
- `logo` block: type `file`, source pointing to eagle.txt, position `top`, Catppuccin color map, left padding 4
- `command` module added at the top for the time-aware greeting
- `kernel` module removed
- All nerd font glyphs stripped from `key` strings (plain text labels only)
- `"showErrors": false` added to the GPU module
- `{#1}` in format strings now resolves to Teal (38;2;148;228;213) via the new `logo.color` map

- [ ] **Step 1: Write the updated config.jsonc**

Write the following to `fastfetch/.config/fastfetch/config.jsonc`:

```jsonc
{
    "$schema": "https://github.com/fastfetch-cli/fastfetch/raw/dev/doc/json_schema.json",
    "logo": {
        "type": "file",
        "source": "~/.config/fastfetch/eagle.txt",
        "position": "top",
        "color": {
            "1": "38;2;148;228;213",
            "2": "38;2;137;220;235",
            "3": "38;2;116;199;236",
            "4": "38;2;166;227;161"
        },
        "padding": {
            "top": 1,
            "left": 4
        }
    },
    "display": {
        "separator": " "
    },
    "modules": [
        {
            "type": "command",
            "text": "h=$(date +%H); if [ $h -lt 12 ]; then echo 'good morning, talon ☀️'; elif [ $h -lt 17 ]; then echo 'good afternoon, talon ☁️'; else echo 'good evening, talon 🌙'; fi",
            "key": " "
        },
        {
            "type": "title",
            "format": "{#1}╭──────────── {#}{user-name-colored}{#1} ────────────╮"
        },
        {
            "type": "os",
            "key": "{#1}│ {#keys} OS",
            "keyColor": "blue"
        },
        {
            "type": "uptime",
            "key": "{#1}│ {#keys} Uptime",
            "keyColor": "blue"
        },
        {
            "type": "shell",
            "key": "{#1}│ {#keys} Shell",
            "keyColor": "green"
        },
        {
            "type": "custom",
            "format": "{#1}│"
        },
        {
            "type": "cpu",
            "key": "{#1}│ {#keys} CPU",
            "keyColor": "yellow"
        },
        {
            "type": "gpu",
            "key": "{#1}│ {#keys} GPU",
            "keyColor": "yellow",
            "showErrors": false
        },
        {
            "type": "memory",
            "key": "{#1}│ {#keys} RAM",
            "keyColor": "yellow"
        },
        {
            "type": "disk",
            "key": "{#1}│ {#keys} Disk",
            "keyColor": "yellow",
            "folders": "/"
        },
        {
            "type": "colors",
            "key": "{#1}│",
            "symbol": "circle",
            "paddingLeft": 1
        },
        {
            "type": "custom",
            "format": "{#1}╰────────────────────────────────────╯"
        }
    ]
}
```

- [ ] **Step 2: Run fastfetch and verify full output**

```bash
fastfetch
```

Expected output (top to bottom):
1. Eagle in four color bands (teal → sky → sapphire → green)
2. A time-appropriate greeting line (`good morning/afternoon/evening, talon` + emoji)
3. Teal-bordered info box with: OS, Uptime, Shell, (blank separator), CPU, GPU (or absent if no GPU), RAM, Disk, color swatches

No nerd font glyphs in any label. No `${c1}` or `{#1}` literal text visible anywhere.

- [ ] **Step 3: Verify greeting changes with time (optional sanity check)**

```bash
# Simulate morning
TZ=UTC date -d "06:00" +%H 2>/dev/null || echo "06"
# Confirm logic manually: h=06 < 12 → "good morning, talon ☀️"

# Simulate evening
TZ=UTC date -d "20:00" +%H 2>/dev/null || echo "20"
# h=20 >= 17 → "good evening, talon 🌙"
```

- [ ] **Step 4: Commit**

```bash
git add fastfetch/.config/fastfetch/config.jsonc
git commit -m "feat: cozy fastfetch redesign — eagle logo, catppuccin colors, time greeting"
```
