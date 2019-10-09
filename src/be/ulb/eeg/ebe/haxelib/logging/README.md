# Logger

A haxe logging package.

## Usage

```
import be.ulb.eeg.ebe.haxelib.logging.Log;
import be.ulb.eeg.ebe.haxelib.logging.BaseLogger;

var logger:BaseLogger = new BaseLogger("myLogger");
logger.log(Log.WARN, "My warning message");
```