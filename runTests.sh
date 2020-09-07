#! /usr/bin/env bash
# -*- coding: UTF-8 -*-

# execute tests with neko
haxe -cp src -cp tests -main be.ulb.eeg.ebe.haxelib.AllTestsTestRunner -neko test.n
compilationExitCode=$?

if [ $compilationExitCode -ne 0 ]
then
    echo "Compilation failed!"
    exit 1
fi

neko test.n
nekoExitCode=$?

if [ $nekoExitCode -ne 0 ]
then
    echo "Neko tests failed!"
    exit 1
fi

# execute tests with python
haxe -cp src -cp tests -main be.ulb.eeg.ebe.haxelib.AllTestsTestRunner -python test.py
compilationExitCode=$?

if [ $compilationExitCode -ne 0 ]
then
    echo "Compilation failed!"
    exit 1
fi

python3 test.py
pythonExitCode=$?

if [ $pythonExitCode -ne 0 ]
then
    echo "Python tests failed!"
    exit 1
fi
