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
- XNOTE

Usage
-----

- copy the file "lilypondLibrary.f95" and the folder "subroutines" to the same directory as your Fortran project
- immediately before the program block, add the line: include "lilypondLibrary.f95"
- immediately after the program block, add the line: use lilypondLibrary

Structure
---------

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

These subroutines have only been tested with Linux Mint 17 Cinnamon 64-bit, LilyPond 2.19.15 and GNU Fortran (Ubuntu 4.8.2-19ubuntu1) 4.8.2.
