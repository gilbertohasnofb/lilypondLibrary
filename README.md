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
- END_POLY
- END_REPEAT
- END_REPEATBRACKET          
- END_STAFF
- END_TUPLET
- GLISSANDO
- GRACE
- HEADER
- KEY
- MARK
- NOTE
- NOTEHEAD_STYLE          
- NOTEHEAD_TRANSPARENT
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

Usage
-----

- copy the files "lilypondlibrary.mod" and "lilypondLibrary.o" to the same directory as your Fortran project
- compile your code with the following command:
	$ gfortran yourcode.f95 lilypondLibrary.o
- if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments.f95" to your project's directory and add the following line in your code immediately before declaring your variables:
	include "arguments.f95"

Structure of .f95 file
----------------------

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
	
Compability
-----------

These subroutines have only been tested with Linux Mint 17 Cinnamon 64-bit, LilyPond 2.19.15 and GNU Fortran 4.8.2 (Ubuntu 4.8.2-19ubuntu1).
