import QtQuick
import QtTest

TestCase {
    name: "PlasmoidTemplate"

    // Mirrors the exampleCounter pattern in package/contents/ui/main.qml —
    // a real (if small) assertion instead of verify(true), so `ctest` can
    // actually fail if this kind of logic breaks. Replace/extend with
    // tests for your own plasmoid's state as it grows.
    Item {
        id: counterHolder
        property int exampleCounter: 0
    }

    function test_counter_increments() {
        counterHolder.exampleCounter = 0;
        counterHolder.exampleCounter++;
        compare(counterHolder.exampleCounter, 1);
    }
}
