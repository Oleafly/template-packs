PU PhD. thesis template
=======================

[![GitHub issues](https://img.shields.io/github/issues/zbeekman/PU-thesis-template.svg?style=plastic)](https://github.com/zbeekman/PU-thesis-template/issues)
[![Ready in backlog](https://badge.waffle.io/zbeekman/PU-thesis-template.png?label=Ready&title=Ready)](https://waffle.io/zbeekman/PU-thesis-template)
[![In Progress](https://badge.waffle.io/zbeekman/PU-thesis-template.png?label=In%20Progress&title=In%20Progress)](https://waffle.io/zbeekman/PU-thesis-template)
[![Needs Review](https://badge.waffle.io/zbeekman/PU-thesis-template.png?label=Needs%20Review&title=Needs%20Review)](https://waffle.io/zbeekman/PU-thesis-template)

[![Travis](https://img.shields.io/travis/zbeekman/PU-thesis-template.svg?style=plastic)](https://travis-ci.org/zbeekman/PU-thesis-template)

This is an update to Jeffery Dwoskin's puthesis class and puthesis
template, which itself was adapted from the Princeton University
Mathematics Department's thesis template.

The main contribution of this iteration is to use
[CMake](http://cmake.org) and
[UseLATEX](https://github.com/kmorel/UseLATEX) to build the LaTeX
file(s) which trivializes document compilation, image format
conversion and changing between digital, ProQuest and print
modes. Care was taken to preserve backward compatibility so that a use
provided build-script, makefile or series of commands can be used in
the same way as was originally required, before the CMake build
functionality was added. For more information also consult the
[PU-Template-Instructions](./PU-Template-Instructions.pdf).
