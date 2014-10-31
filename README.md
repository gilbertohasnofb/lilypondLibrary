lilypondLibrary
===============

lilypondLibrary : a library of Fortran subroutines for outputting LilyPond code

Usage:

- copy the file "lilypondLibrary.f95" and the folder "subroutines" to the same directory as your Fortran project
- immediately before the program block, add the line: include "lilypondLibrary.f95"
- immediately after the program block, add the line: use lilypondLibrary

Structure:

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
