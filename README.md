lilypondLibrary
===============

A library of Fortran subroutines for outputting LilyPond code, by Gilberto Agostinho (gilbertohasnofb@gmail.com).

List of available subroutines
-----------------------------

- AL_NIENTE
- ARPEGGIO
- ARPEGGIO_TYPE
- BAR_CHECK
- BAR
- BARREST
- BARREST_COMPRESS
- BREAK
- CHANGE_STAFF
- CHORD
- CLEF
- CADENZA
- COMMAND
- COMMENT
- COMPILE
- END_ANY
- END_GRACE
- END_ILY
- END_MAKECLUSTERS
- END_OTTAVATE
- END_POLY
- END_REPEAT
- END_REPEATBRACKET          
- END_STAFF
- END_TUPLET
- FORCE_CLOSE
- GLISSANDO
- GRACE
- HEADER
- HIDE
- HORIZONTAL_TUPLETS
- ILY
- INCLUDE_FILE
- KEY
- LIVEELECTRONICS
- MAKECLUSTERS
- MARK
- NOTE
- NOTEHEAD_STYLE          
- NOTEHEAD_TRANSPARENT
- NUMERICOTTAVA  
- OMIT
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
- TRILL
- TUPLET
- TUPLET_ANGLES
- VOICE
- XNOTE

Usage in Linux
--------------

- copy the files "lilypondlibrary.o" and "lilypondLibrary.mod" to the same directory as your Fortran project
- immediately after declaring your program name, add the line "use lilypondLibrary"
- compile your code with the following command:
	$ gfortran yourcode.f95 lilypondLibrary.o
- if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments to your project's directory and add the following line in your code immediately before declaring your variables:
	include "arguments
	
Usage in Windows
----------------

- copy the files "lilypondlibraryWin.o" and "lilypondLibraryWin.mod" to the same directory as your Fortran project
- immediately after declaring your program name, add the line "use lilypondLibraryWin"
- compile your code with the following command:
	gfortran yourcode.f95 lilypondLibraryWin.o
- if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments to your project's directory and add the following line in your code immediately before declaring your variables:
	include "arguments

Please note that I do not recompile the Windows version of this library as often as the Linux version, so you may want to compile it by yourself. To do so, simply navigate to the sourceCode folder and execute the following command in the terminal (then follow the instructions above):
gfortran -c lilypondLibraryWin.f95

Structure of .f95 file
----------------------

	program example
	use lilypondLibrary
	implicit none

	call HEADER
	
		call STAFF
		
			...music...
			
		call END_STAFF
	
	call SCORE
	
	end program example
	
Compability
-----------

These subroutines have only been tested with Linux Mint 17 Cinnamon 64-bit, LilyPond 2.19.15 and GNU Fortran 4.8.2 (Ubuntu 4.8.2-19ubuntu1).
