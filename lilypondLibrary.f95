! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
!                                                     Library of Fortran Subroutines for LilyPond v2.0                                                       !
!                                                                        LINUX VERSION                                                                       !
!                                                                                                                                                            !
!                                                     by Gilberto Agostinho (gilbertohasnofb@gmail.com)                                                      !
!                                                                                                                                                            !
!                                                          (current version created on 31/10/2014)                                                           !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! IMPORTANT NOTES:                                                                                                                                           !
!                                                                                                                                                            !
! - Tested with LilyPond version 2.19.15 (Linux) and GNU Fortran (Ubuntu 4.8.2-19ubuntu1) 4.8.2.                                                             !
!                                                                                                                                                            !
! - Labels 7 and 11 are reserved (label 11 is used for writing the output .ly file. DO NOT USE ANY OF THEM DIRECTLY IN YOUR CODE!                            !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! Usage:                                                                                                                                                     !
!                                                                                                                                                            !
! - copy all these files to the directory of your Fortran code                                                                                               !
! - immediately before the program block, add the line: include "lilypondLibrary.f95"                                                                        !
! - immediately after the program block, add the line: use lilypondLibrary                                                                                   !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !

module lilypondLibrary
implicit none

private :: LCASE, SNIPPET_SLASHEDGRACES, SNIPPET_REPEATBRACKET, SNIPPET_NATURALIZEMUSIC

contains

	include "./subroutines/AL_NIENTE.f95"
	include "./subroutines/ARPEGGIO.f95"
	include "./subroutines/AUTOCHANGE.f95"
	include "./subroutines/BAR_CHECK.f95"
	include "./subroutines/BAR.f95"
	include "./subroutines/BARREST.f95"
	include "./subroutines/BREAK.f95"
	include "./subroutines/CHANGE_STAFF.f95"
	include "./subroutines/CHORD.f95"
	include "./subroutines/CLEF.f95"
	include "./subroutines/CADENZA.f95"
	include "./subroutines/COMMAND.f95"
	include "./subroutines/END_ANY.f95"
	include "./subroutines/END_GRACE.f95"
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
	include "./subroutines/MARK.f95"
	include "./subroutines/MIDI_PITCH_TO_LP.f95"
 	include "./subroutines/NOTE.f95"
	include "./subroutines/NOTEHEAD_STYLE.f95"          
	include "./subroutines/NOTEHEAD_TRANSPARENT.f95"
	include "./subroutines/PAPER.f95"
	include "./subroutines/PITCHEDTRILL.f95"
	include "./subroutines/POLY.f95"
	include "./subroutines/REPEAT.f95"
	include "./subroutines/REPEATBRACKET.f95"
	include "./subroutines/SNIPPET.f95"          
	include "./subroutines/SNIPPET_REPEATBRACKET.f95"          ! private subroutine
	include "./subroutines/SNIPPET_SLASHEDGRACES.f95"          ! private subroutine
	include "./subroutines/SNIPPET_NATURALIZEMUSIC.f95"          ! private subroutine
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
	include "./subroutines/TIMESIG_NOTE.f95"
	include "./subroutines/TRILL.f95"
	include "./subroutines/TUPLET.f95"
	include "./subroutines/XNOTE.f95"

end module lilypondLibrary
