Maky
====

Generic and ready-to-use Makefile for C or C++ projects.

What is Maky
------------

Maky is a generic, reusable and ready-to-use Makefile for C or C++.
In most case, you have no configuration to set to make it work.
In other general cases, you have at most 2 variables to set in the file if you want to be minimal.

Maky includes an awesome feature as it can handle several main files. If you have two executables to compile, relying on the same sources, it will compile them as easy as tying a shoelace (if you have learnt how to do it).

Requirements
------------

Maky uses some commands to work.
Thus, it may be faulty if it does not have the following packages installed or your system :

 * pkg-config

Make it run !
-------------

Ok ! Ok !
It is a piece of cake !
Go to your project where you have your sources.

    $ cd ~/my_awesome_project/sources/
    $ ls
    main.cpp   lib/   hello.h   hello.cpp

And copy maky into it as `Makefile`
And run it !

    $ cp ~/Downloads/maky/maky.mk Makefile
    $ make

Run `make help` to get some more information.
Run `make -f maky.mk help` if you do not want to copy the original file as `Makefile`.


Just as easy ?!
---------------

Ok... It may need some configuration for some projects.
Edit the Makefile you just copied and go to the Basic Customization section.
You will see 5 variables that you can set.

 * EXTENTION: Change the file extension depending on your project : c or cpp.
 * COMPILER: Change the compiler : gcc or g++.
 * PACKAGES: Add some packages separing them with whitespace.
 * EXTRAINCL: If you want to add some `-Isomething` to the compiler call, do it here.
 * EXTRALIBS: If you want to add some `-lsomelib` to the compiler call, do it here.

Want to go further ?
--------------------

There is Plumbing Customization section in the Maky file.
It contains three variables you can set.
If you have several main source files, indicate them here.
If your main file is not called main.cpp or main.c, you can change it here too.
You can change the compilation and linker flags too.

In projects where you have several main files, you can compile a single target by naming it.
If the main file is unicorn.cpp, run :

    $ make unicorn

Trouble shootings
-----------------

 * `make[1]: *** No rule to make target 'main.o'. Stop.`

It means you do not have a main.cpp or main.c file.
Go to the Plumbing Customization section in the Makefile and edit the MAINS variable with the name of your main file.

 * `make: pkg-config : command not found`

You have not installed pkg-config which is required to run Maky properly.
Use your package manager to install it. On ubuntu-like (debian too) just run :

    $ sudo apt-get install pkg-builder

Drawbacks
---------

Maky is made for little projects.
It does not optimize the compilation chain.
Every header is required for every target. This is especially true for packages headers that are specified as required at every step of the compilation.
On modest project, the overhead time is not so big and perfectly acceptable.
