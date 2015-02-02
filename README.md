lilypondLibrary
===============

A library of Fortran subroutines for outputting LilyPond code, by Gilberto Agostinho (gilbertohasnofb@gmail.com).

List of available subroutines
-----------------------------

- AL_NIENTE
- ARPEGGIO
- AUTOCHANGE
- BAR_CHECK
- BAR
- BARREST
- BREAK
- CHANGE_STAFF
- CHORD
- CLEF
- CADENZA
- COMMAND
- END_ANY
- END_GRACE
- END_MAKECLUSTERS
- END_OTTAVATE
- END_POLY
- END_REPEAT
- END_REPEATBRACKET          
- END_STAFF
- END_TUPLET
- GLISSANDO
- GRACE
- HEADER
- KEY
- MAKECLUSTERS
- MARK
- NOTE
- NOTEHEAD_STYLE          
- NOTEHEAD_TRANSPARENT
- OTTAVA
- OTTAVATE
- PAGEBREAK
- PAPER
- PITCHEDTRILL
- POLY
- REPEAT
- REPEATBRACKET
- SNIPPET          
- SCORE
- STAFF          
- STAFF_LINE_COUNT
- STEM
- STOPSTAFF
- STYLE
- SYMBOL
- TEMPO
- TEXT
- TIE
- TIE_TYPE
- TIME
- TIMESIG_NOTE
- TRILL
- TUPLET
- VOICE
- XNOTE

Usage in Linux (and probably OS X)
----------------------------------

- copy the files "lilypondlibrary.o" and "lilypondLibrary.mod" to the same directory as your Fortran project
- immediately after declaring your program's name, add the line: `use lilypondLibrary`
- compile your code with the following command: `$ gfortran your-code.f95 lilypondLibrary.o`
- or compile it using this other command in order to specify the name of the output file: `$ gfortran your-code.f95 lilypondLibrary.o -o output-file-name.out`
- if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments.f95" to your project's directory and add the following line in your code immediately before declaring your variables: `include "arguments.f95"`
- for OS X users: you will need to compile the library yourself as I have no means of doing it myself. This library has NOT been tested with OS X, but I'd gladly try to fix any issues with the compilation/usage of it.
	
Usage in Windows
----------------

- copy the files "lilypondlibraryWin.o" and "lilypondLibraryWin.mod" to the same directory as your Fortran project
- immediately after declaring your program name, add the line: `use lilypondLibraryWin`
- compile your code with the following command: `gfortran yourcode.f95 lilypondLibraryWin.o`
- or compile it using this other command in order to specify the name of the output file: `gfortran your-code.f95 lilypondLibraryWin.o -o output-file-name.out`
- if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments.f95" to your project's directory and add the following line in your code immediately before declaring your variables: `include "arguments.f95"`
- please note that I do not recompile the Windows version of this library as often as the Linux version, so you may want to compile it by yourself. 

Compiling
----------------

To compile this library yourself, simply navigate to the sourceCode folder and execute the following commands in the terminal (depending on your OS): ```gfortran -c lilypondLibrary.f95``` under Linux (and possibly under OS X) and ```gfortran -c lilypondLibraryWin.f95``` under Windows

Structure of .f95 file
----------------------

Here is the basic structure of a .f95 file using these subroutines:

	include "lilypondLibrary.f95"
	
	program example
	use lilypondLibrary
	implicit none

	call HEADER
	
		call STAFF
			...music...
		call END_STAFF
	
	call SCORE
	
	end program example
	
For more concrete and detailed examples, please check the examples folder.
	
Compability
-----------

These subroutines have only been tested with Linux Mint 17.1 64-bit Cinnamon, LilyPond 2.19.15 and GNU Fortran 4.8.2 (Ubuntu 4.8.2-19ubuntu1).

FAQ
---

__Why Fortran?__

Why not? Fortran is certainly not the first choice of anyone dealing with music, but that's the first programming language I was taught while on university and the one I am most comfortable with.

__Do you plan to write a manual for this library?__

If someone would be interested in that, yes I could.

__Do you plan to migrate this library to Python?__

Potentially yes (and particularly so if someone else shows interest), but there are no previsions of when.

__Would you add a subroutine to do this/that in LilyPond?__

If feasable, then very likely yes! Simply contact me for the request.
