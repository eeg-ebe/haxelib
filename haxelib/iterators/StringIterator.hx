package haxelib.iterators;

/**
 * A String iterator (to iterate over the different characters of a string.
 *
 * @copyed from https://haxe.org/manual/lf-iterators.html
 */
class StringIterator
{
    var s:String;
    var i:Int;

    public function new(s:String) {
        this.s = s;
        this.i = 0;
    }

    public function hasNext() {
        return i < s.length;
    }

    public function next() {
        return s.charAt(i++);
    }
}
