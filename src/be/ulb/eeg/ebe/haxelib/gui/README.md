# GUI

Useful classes for GUI programming.

# Color

A color class. The class represents a rgba color.

red, green and blue value should be between 0 and 255 (inclusive).
The alpha value should be between 0 and 100 (0 means transparent,
100 fully opaque).

Usage:

```
var c:Color = new Color(0, 0, 0);
var d:Color = new Color(0, 0, 0, 30);
var e:Color = Color.parse("red");
var f:Color = Color.parse("rgb(12, 13, 14)");
var g:Color = Color.parse("rgba(12, 13, 14, 0.15)");
var h:Color = Color.parse("#123");
var i:Color = Color.parse("#123456");
```

# KeyboardShortcut

A class representing a keyboard shortcut.

Usage:

```
var s:KeyboardShortcut = new KeyboardShortcut(true, false, false, "s"); // ctrl, alt, shift, key
trace(s.toString());
```