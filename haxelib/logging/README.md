# Logger

A haxe logging package.

## Usage

```
import haxelib.logging.Log;
import haxelib.logging.BaseLogger;

var logger:BaseLogger = new BaseLogger("myLogger");
logger.log(Log.WARN, "My warning message");
```