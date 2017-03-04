# Psi Phi Quantum Mechanics

      ___ ___  ___  __  __ 
     | _ \ _ \/ _ \|  \/  |
     |  _/  _/ (_) | |\/| |
     |_| |_|  \__\_\_|  |_|
 

## Installation

Using `gfortran` currently

    git clone https://github.com/ppqm/ppqm
    cd ppqm
    make

for python bindings use

    make python

to test the installation use

    make test

                     
## Format

    - Use a well-defined format for input (INI-format) for easily extendable keywords and parameters (this format also supports arrays)

    - Use MarkDown format for results, which is human readable and easy `grep`-able


## Developers

    - All modules must be standalone for easy extendability and for easy python-binding port
    - No common blocks

## Tests

    - Creating a new module or extending some functionality? Use python bindings in `tests/` to test the functionality


## TODO

    - Documentation of functions. Which format? Similar to JavaDoc?

