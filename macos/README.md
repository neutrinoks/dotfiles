# macOS

Bits that only matter on the MacBook, to make it behave like the Arch/Hyprland setup.
Not stow-managed — the files have to live at fixed OS paths; install them with the
commands below.

## Keyboard layout: `US altgr-intl`

`keyboard/USaltgrintl.keylayout` is a macOS port of X11's `us(altgr-intl)`:
Option acts as AltGr, so the Linux muscle memory works unchanged.

| Keys | Output |
|---|---|
| `⌥q` `⌥p` `⌥y` `⌥s` | ä ö ü ß |
| `⇧⌥q` `⇧⌥p` `⇧⌥y` `⇧⌥s` | Ä Ö Ü ẞ |
| `⌥'` then vowel | á é í ó ú (dead acute) |
| `⇧⌥'` then vowel | ä ë ï ö ü (dead diaeresis) |
| `⌥\`` / `⇧⌥\`` then vowel | à è ì ò ù / ã ñ õ (dead grave / tilde) |
| `⌥6` then vowel | â ê î ô û (dead circumflex) |
| `⌥e` `⌥a` `⌥o` `⌥u` `⌥i` | é á ó ú í |
| `⌥n` `⌥c` `⌥z` `⌥l` `⌥m` `⌥5` | ñ © æ ø µ € |

A dead key followed by Space emits the bare accent; followed by a
non-combining key it emits accent + that character.

Install:

```sh
cp keyboard/USaltgrintl.keylayout ~/Library/Keyboard\ Layouts/
# then log out and back in, and pick "US altgr-intl" in
# System Settings > Keyboard > Text Input > Input Sources
```

Regenerate after editing the tables in `keyboard/gen_keylayout.py`:

```sh
python3 keyboard/gen_keylayout.py keyboard/USaltgrintl.keylayout
# xmllint rejects the C0 control refs that macOS itself accepts, so validate a copy:
sed -E 's/&#x00(0[0-9A-F]|1[0-9A-F]);/\&#x00B7;/g' keyboard/USaltgrintl.keylayout > /tmp/v.keylayout
xmllint --noout --dtdvalid /System/Library/DTDs/KeyboardLayout.dtd /tmp/v.keylayout
```

## Modifier keys

System Settings > Keyboard > Keyboard Shortcuts… > Modifier Keys, for
"Apple Internal Keyboard / Trackpad":

| Key | Role |
|---|---|
| 🌐 Globe/fn | **Control** — bottom-left, same position as Ctrl on a PC keyboard |
| ⌃ Control | Control |
| ⌥ Option | Option — left = Alt/Meta, right = AltGr (see above) |
| ⌘ Command | Command |
| right ⌘ (next to space) | **right Option = AltGr**, like on a PC keyboard |
| right ⌥ (outer) | right Command |

The right-hand swap is asymmetric, which the System Settings UI cannot express
(it has one dropdown per modifier for both sides). Opening that dialog and
pressing *Done* rewrites the mapping symmetrically and loses the swap.

Stored per host in `com.apple.keyboard.modifiermapping.0-0-0`
(vendor/product `0-0` is the internal keyboard); applies after logout.
Trade-off: no fn key left, so the media functions on F1–F12 are gone — which is
what you want anyway once `com.apple.keyboard.fnState` is `true`.

## Terminal

See the `wezterm` package: no binding uses CTRL alone, so `C-d`/`C-u`/`C-w`
reach NeoVim; terminal actions sit on CTRL+SHIFT like in kitty.
