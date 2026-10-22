# -*- coding: utf-8 -*-
"""Generates a macOS .keylayout mirroring X11's us(altgr-intl):
   3rd level = Option (AltGr), 4th level = Option+Shift, dead keys on ' " ` ~ ^ ."""
import sys

LETTERS = {0:'a',1:'s',2:'d',3:'f',4:'h',5:'g',6:'z',7:'x',8:'c',9:'v',11:'b',
           12:'q',13:'w',14:'e',15:'r',16:'y',17:'t',31:'o',32:'u',34:'i',35:'p',
           37:'l',38:'j',40:'k',45:'n',46:'m'}

OTHER_BASE = {50:'`',18:'1',19:'2',20:'3',21:'4',23:'5',22:'6',26:'7',28:'8',25:'9',
              29:'0',27:'-',24:'=',33:'[',30:']',42:'\\',41:';',39:"'",43:',',47:'.',
              44:'/',49:' ',10:'§'}
OTHER_SHIFT = {50:'~',18:'!',19:'@',20:'#',21:'$',23:'%',22:'^',26:'&',28:'*',25:'(',
               29:')',27:'_',24:'+',33:'{',30:'}',42:'|',41:':',39:'"',43:'<',47:'>',
               44:'?',49:' ',10:'±'}

# Option layer (3rd level) and Option+Shift (4th level), per us(altgr-intl)
OPT = {12:'ä',13:'å',14:'é',15:'®',17:'þ',16:'ü',
       32:'ú',34:'í',31:'ó',35:'ö',0:'á',1:'ß',
       2:'ð',37:'ø',6:'æ',7:'œ',8:'©',45:'ñ',
       46:'µ',43:'ç',44:'¿',41:'¶',18:'¡',19:'²',
       20:'³',21:'¤',23:'€',26:'&',28:'•',25:'‘',
       29:'’',27:'¥',24:'×',9:'“',11:'”',3:'Ƶ',
       5:'ŋ',4:'ħ',38:'ĵ',40:'ĸ',33:'«',30:'»',
       42:'¬',47:'·',49:' ',10:'§'}
OPT_SHIFT = {12:'Ä',13:'Å',14:'É',15:'®',17:'Þ',16:'Ü',
             32:'Ú',34:'Í',31:'Ó',35:'Ö',0:'Á',1:'ẞ',
             2:'Ð',37:'Ø',6:'Æ',7:'Œ',8:'¢',45:'Ñ',
             46:'µ',43:'Ç',44:'¿',41:'°',18:'¹',19:'½',
             20:'¾',21:'¼',23:'¢',26:'⅝',28:'°',
             25:'“',29:'”',27:'¥',24:'÷',9:'„',11:'”',
             3:'Ƶ',5:'Ŋ',4:'Ħ',38:'Ĵ',40:'ĸ',33:'‹',
             30:'›',42:'¦',47:'…',49:' ',10:'±'}

# Dead keys: (keycode, needs_shift) -> state, mirroring us(altgr-intl) levels 3/4
DEAD_OPT       = {50:'grave', 39:'acute', 22:'circumflex', 33:'diaeresis'}
DEAD_OPT_SHIFT = {50:'tilde', 39:'diaeresis', 30:'tilde'}

TERMINATORS = {'grave':'`','acute':'´','circumflex':'^','tilde':'~','diaeresis':'¨'}
COMBINE = {
  'grave':      {'a':'à','e':'è','i':'ì','o':'ò','u':'ù','n':'ǹ','y':'ỳ',
                 'A':'À','E':'È','I':'Ì','O':'Ò','U':'Ù','N':'Ǹ','Y':'Ỳ'},
  'acute':      {'a':'á','e':'é','i':'í','o':'ó','u':'ú','y':'ý','c':'ć','n':'ń','s':'ś','z':'ź','l':'ĺ','r':'ŕ',
                 'A':'Á','E':'É','I':'Í','O':'Ó','U':'Ú','Y':'Ý','C':'Ć','N':'Ń','S':'Ś','Z':'Ź','L':'Ĺ','R':'Ŕ'},
  'circumflex': {'a':'â','e':'ê','i':'î','o':'ô','u':'û','w':'ŵ','y':'ŷ','c':'ĉ','g':'ĝ','h':'ĥ','j':'ĵ','s':'ŝ','z':'ẑ',
                 'A':'Â','E':'Ê','I':'Î','O':'Ô','U':'Û','W':'Ŵ','Y':'Ŷ','C':'Ĉ','G':'Ĝ','H':'Ĥ','J':'Ĵ','S':'Ŝ','Z':'Ẑ'},
  'tilde':      {'a':'ã','e':'ẽ','i':'ĩ','o':'õ','u':'ũ','n':'ñ','y':'ỹ','v':'ṽ',
                 'A':'Ã','E':'Ẽ','I':'Ĩ','O':'Õ','U':'Ũ','N':'Ñ','Y':'Ỹ','V':'Ṽ'},
  'diaeresis':  {'a':'ä','e':'ë','i':'ï','o':'ö','u':'ü','y':'ÿ','h':'ḧ','w':'ẅ','x':'ẍ','t':'ẗ',
                 'A':'Ä','E':'Ë','I':'Ï','O':'Ö','U':'Ü','Y':'Ÿ','H':'Ḧ','W':'Ẅ','X':'Ẍ','T':'ẖ'},
}

SPECIAL = {36:0x0D, 48:0x09, 51:0x08, 53:0x1B, 71:0x1B, 76:0x03, 114:0x05, 115:0x01,
           116:0x0B, 117:0x7F, 119:0x04, 121:0x0C, 123:0x1C, 124:0x1D, 125:0x1F, 126:0x1E}
FKEYS = [122,120,99,118,96,97,98,100,101,109,103,111,105,107,113,106,64,79,80,90,
         63,110,130,131,132,133,134,135]
KEYPAD = {82:'0',83:'1',84:'2',85:'3',86:'4',87:'5',88:'6',89:'7',91:'8',92:'9',
          65:'.',67:'*',69:'+',75:'/',78:'-',81:'='}
ALL_CODES = sorted(set(list(range(0, 127))))

def esc(ch):
    if ch in '&<>"\'':
        return {'&':'&amp;','<':'&lt;','>':'&gt;','"':'&quot;',"'":'&#x0027;'}[ch]
    o = ord(ch)
    return ch if 0x20 <= o < 0x7F else '&#x%04X;' % o

def out(ch):
    return ''.join(esc(c) for c in ch)

def base_for(code, shift):
    if code in LETTERS:
        return LETTERS[code].upper() if shift else LETTERS[code]
    table = OTHER_SHIFT if shift else OTHER_BASE
    if code in table:
        return table[code]
    return None

def render_key(code, char, use_action):
    if use_action and char and char in set(sum([list(v) for v in COMBINE.values()], [])):
        return '      <key code="%d" action="%s"/>' % (code, 'a_' + ('%04X' % ord(char)))
    return '      <key code="%d" output="%s"/>' % (code, out(char))

def fixed_keys(lines):
    for code, cp in SPECIAL.items():
        lines.append('      <key code="%d" output="&#x%04X;"/>' % (code, cp))
    for code in FKEYS:
        lines.append('      <key code="%d" output="&#x0010;"/>' % code)
    for code, ch in KEYPAD.items():
        lines.append('      <key code="%d" output="%s"/>' % (code, out(ch)))

def keymap(index, resolver, use_action):
    lines = ['    <keyMap index="%d">' % index]
    for code in sorted(set(list(LETTERS) + list(OTHER_BASE))):
        ch = resolver(code)
        if ch is None:
            continue
        lines.append(render_key(code, ch, use_action))
    fixed_keys(lines)
    lines.append('    </keyMap>')
    return '\n'.join(lines)

def dead_keymap(index, resolver, deads):
    lines = ['    <keyMap index="%d">' % index]
    for code in sorted(set(list(LETTERS) + list(OTHER_BASE))):
        if code in deads:
            lines.append('      <key code="%d" action="dead_%s"/>' % (code, deads[code]))
            continue
        ch = resolver(code)
        if ch is None:
            continue
        lines.append(render_key(code, ch, False))
    fixed_keys(lines)
    lines.append('    </keyMap>')
    return '\n'.join(lines)

def ctrl_keymap(index):
    lines = ['    <keyMap index="%d">' % index]
    for code, ch in LETTERS.items():
        lines.append('      <key code="%d" output="&#x%04X;"/>' % (code, ord(ch) - 0x60))
    for code, cp in {33:0x1B, 42:0x1C, 30:0x1D, 22:0x1E, 27:0x1F, 49:0x00}.items():
        lines.append('      <key code="%d" output="&#x%04X;"/>' % (code, cp))
    for code in sorted(OTHER_BASE):
        if code in (33,42,30,22,27,49):
            continue
        lines.append('      <key code="%d" output="%s"/>' % (code, out(OTHER_BASE[code])))
    fixed_keys(lines)
    lines.append('    </keyMap>')
    return '\n'.join(lines)

# ---- actions: every letter that can carry an accent becomes an action
combining = sorted({c for v in COMBINE.values() for c in v})
actions = []
for ch in combining:
    aid = 'a_%04X' % ord(ch)
    body = ['      <when state="none" output="%s"/>' % out(ch)]
    for state, table in COMBINE.items():
        if ch in table:
            body.append('      <when state="%s" output="%s"/>' % (state, out(table[ch])))
    actions.append('    <action id="%s">\n%s\n    </action>' % (aid, '\n'.join(body)))
for state in TERMINATORS:
    actions.append('    <action id="dead_%s">\n      <when state="none" next="%s"/>\n    </action>'
                   % (state, state))

terminators = '\n'.join('    <when state="%s" output="%s"/>' % (s, out(t))
                        for s, t in TERMINATORS.items())

maps = [
    keymap(0, lambda c: base_for(c, False), True),
    keymap(1, lambda c: base_for(c, True), True),
    keymap(2, lambda c: base_for(c, True) if c in LETTERS else base_for(c, False), True),
    keymap(3, lambda c: base_for(c, False) if c in LETTERS else base_for(c, True), True),
    dead_keymap(4, lambda c: OPT.get(c), DEAD_OPT),
    dead_keymap(5, lambda c: OPT_SHIFT.get(c), DEAD_OPT_SHIFT),
    dead_keymap(6, lambda c: OPT.get(c), DEAD_OPT),
    dead_keymap(7, lambda c: OPT_SHIFT.get(c), DEAD_OPT_SHIFT),
    ctrl_keymap(8),
]

MODMAP = """  <modifierMap id="Modifiers" defaultIndex="0">
    <keyMapSelect mapIndex="0"><modifier keys="command?"/></keyMapSelect>
    <keyMapSelect mapIndex="1"><modifier keys="anyShift command?"/></keyMapSelect>
    <keyMapSelect mapIndex="2"><modifier keys="caps"/></keyMapSelect>
    <keyMapSelect mapIndex="3"><modifier keys="anyShift caps"/></keyMapSelect>
    <keyMapSelect mapIndex="4"><modifier keys="anyOption command?"/></keyMapSelect>
    <keyMapSelect mapIndex="5"><modifier keys="anyShift anyOption command?"/></keyMapSelect>
    <keyMapSelect mapIndex="6"><modifier keys="caps anyOption"/></keyMapSelect>
    <keyMapSelect mapIndex="7"><modifier keys="anyShift caps anyOption"/></keyMapSelect>
    <keyMapSelect mapIndex="8"><modifier keys="anyControl anyShift? anyOption? command?"/></keyMapSelect>
  </modifierMap>"""

doc = """<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE keyboard SYSTEM "file://localhost/System/Library/DTDs/KeyboardLayout.dtd">
<!--
  US altgr-intl : macOS port of X11's us(altgr-intl).
  Option acts as AltGr: Option+q/p/y/s give the umlauts and the sharp s,
  Option+apostrophe / quote / grave / tilde / 6 are the dead keys.
  Generated by gen_keylayout.py; edit freely.
-->
<keyboard group="126" id="-4711" name="US altgr-intl" maxout="2">
  <layouts>
    <layout first="0" last="255" mapSet="ANSI" modifiers="Modifiers"/>
  </layouts>
%s
  <keyMapSet id="ANSI">
%s
  </keyMapSet>
  <actions>
%s
  </actions>
  <terminators>
%s
  </terminators>
</keyboard>
""" % (MODMAP, '\n'.join(maps), '\n'.join(actions), terminators)

open(sys.argv[1], 'w', encoding='utf-8').write(doc)
print("keys:", doc.count('<key '), "actions:", doc.count('<action '))
