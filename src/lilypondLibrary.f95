! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
!                                                     Library of Fortran Subroutines for LilyPond v2.0                                                       !
!                                                                        LINUX VERSION                                                                       !
!                                                                                                                                                            !
!                                                     by Gilberto Agostinho (gilbertohasnofb@gmail.com)                                                      !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! IMPORTANT NOTES:                                                                                                                                           !
!                                                                                                                                                            !
! - Tested with LilyPond version 2.19.95 (Linux) and GNU Fortran (Ubuntu 4.8.2-19ubuntu1) 4.8.2.                                                             !
!                                                                                                                                                            !
! - Labels 7 and 11 are reserved (label 11 is used for writing the output .ly file. DO NOT USE ANY OF THEM DIRECTLY IN YOUR CODE!                            !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! Usage:                                                                                                                                                     !
!                                                                                                                                                            !
! - copy the files "lilypondlibrary.o" and "lilypondLibrary.mod" to the same directory as your Fortran project                                               !
! - compile your code with the following command:                                                                                                            !
!   $ gfortran yourcode.f95 lilypondLibrary.o                                                                                                                !
! - if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments.f95" to your project's directory and    !
!   add the following line in your code immediately before declaring your variables:                                                                         !
!   include "arguments.f95"                                                                                                                                  !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !

module lilypondLibrary
implicit none

private :: LCASE, MIDI_PITCH_TO_LP, SNIPPET_LIVEELECTRONICS, SNIPPET_NATURALIZEMUSIC, SNIPPET_OTTAVATE, SNIPPET_REPEATBRACKET, &
SNIPPET_SLASHEDGRACES, SNIPPET_TIMESIG_NOTE

contains

	include "./subroutines/AL_NIENTE.f95"
	include "./subroutines/ARPEGGIO.f95"
	include "./subroutines/BAR_CHECK.f95"
	include "./subroutines/BAR.f95"
	include "./subroutines/BARREST.f95"
	include "./subroutines/BREAK.f95"
	include "./subroutines/CHANGE_STAFF.f95"
	include "./subroutines/CHORD.f95"
	include "./subroutines/CLEF.f95"
	include "./subroutines/CADENZA.f95"
	include "./subroutines/COMMAND.f95"
	include "./subroutines/COMMENT.f95"
	include "./subroutines/END_ANY.f95"
	include "./subroutines/END_GRACE.f95"
	include "./subroutines/END_MAKECLUSTERS.f95"
	include "./subroutines/END_OTTAVATE.f95"
	include "./subroutines/END_POLY.f95"
	include "./subroutines/END_REPEAT.f95"
	include "./subroutines/END_REPEATBRACKET.f95"          
	include "./subroutines/END_STAFF.f95"
	include "./subroutines/END_TUPLET.f95"
	include "./subroutines/GLISSANDO.f95"
	include "./subroutines/GRACE.f95"
	include "./subroutines/HEADER.f95"
	include "./subroutines/KEY.f95"
	include "./subroutines/LCASE.f95" ! private subroutine	
	include "./subroutines/LIVEELECTRONICS.f95"
	include "./subroutines/MAKECLUSTERS.f95"
	include "./subroutines/MARK.f95"
	include "./subroutines/MIDI_PITCH_TO_LP.f95" ! private subroutine
 	include "./subroutines/NOTE.f95"
	include "./subroutines/NOTEHEAD_STYLE.f95"          
	include "./subroutines/NOTEHEAD_TRANSPARENT.f95"
	include "./subroutines/OTTAVA.f95"
	include "./subroutines/OTTAVATE.f95"
	include "./subroutines/PAGEBREAK.f95"
	include "./subroutines/PAPER.f95"
	include "./subroutines/PITCHEDTRILL.f95"
	include "./subroutines/POLY.f95"
	include "./subroutines/REPEAT.f95"
	include "./subroutines/REPEATBRACKET.f95"
	include "./subroutines/SNIPPET.f95"
	include "./subroutines/SNIPPET_LIVEELECTRONICS.f95" ! private subroutine
	include "./subroutines/SNIPPET_NATURALIZEMUSIC.f95" ! private subroutine
	include "./subroutines/SNIPPET_OTTAVATE.f95" ! private subroutine
	include "./subroutines/SNIPPET_REPEATBRACKET.f95" ! private subroutine
	include "./subroutines/SNIPPET_SLASHEDGRACES.f95" ! private subroutine
	include "./subroutines/SNIPPET_TIMESIG_NOTE.f95" ! private subroutine	
	include "./subroutines/SCORE.f95"
	include "./subroutines/STAFF.f95"          
	include "./subroutines/STAFF_LINE_COUNT.f95"
	include "./subroutines/STEM.f95"
	include "./subroutines/STOPSTAFF.f95"
	include "./subroutines/STYLE.f95"
	include "./subroutines/SYMBOL.f95"
	include "./subroutines/TEMPO.f95"
	include "./subroutines/TEXT.f95"
	include "./subroutines/TIE.f95"
	include "./subroutines/TIE_TYPE.f95"
	include "./subroutines/TIME.f95"
	include "./subroutines/TRILL.f95"
	include "./subroutines/TUPLET.f95"
	include "./subroutines/VOICE.f95"
	include "./subroutines/XNOTE.f95"

end module lilypondLibrary
