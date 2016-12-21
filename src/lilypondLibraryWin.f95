! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
!                                                     Library of Fortran Subroutines for LilyPond v2.0                                                       !
!                                                                       WINDOWS VERSION                                                                      !
!                                                                                                                                                            !
!                                                     by Gilberto Agostinho (gilbertohasnofb@gmail.com)                                                      !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! IMPORTANT NOTES:                                                                                                                                           !
!                                                                                                                                                            !
! - Tested with LilyPond version 2.19.15 (Linux) and GNU Fortran                                                                                             !
!                                                                                                                                                            !
! - Labels 7 through 13 are reserved (label 11 is used for writing the output .ly file. DO NOT USE ANY OF THEM DIRECTLY IN YOUR CODE!                        !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !
!                                                                                                                                                            !
! Usage:                                                                                                                                                     !
!                                                                                                                                                            !
! - copy the files "lilypondlibrary-win.o" and "lilypondLibraryWin.mod" to the same directory as your Fortran project                                        !
! - compile your code with the following command:                                                                                                            !
!   gfortran yourcode.f95 lilypondLibraryWin.o                                                                                                               !
! - if you also wish to use a set of predefined constants as arguments for the subroutines, copy the file "arguments.f95" to your project's directory and    !
!   add the following line in your code immediately before declaring your variables:                                                                         !
!   include "arguments.f95"                                                                                                                                  !
!                                                                                                                                                            !
! ********************************************************************************************************************************************************** !

module lilypondLibraryWin
implicit none

private :: LCASE, MIDI_PITCH_TO_LP, SNIPPET_GRACE_MIDI_DURATION, SNIPPET_GRACE_ON_BEAT, SNIPPET_LIVE_ELECTRONICS, &
SNIPPET_MINOR_TRILLS, SNIPPET_NATURALIZEMUSIC, SNIPPET_OTTAVATE, SNIPPET_REPEATBRACKET, SNIPPET_SLASHEDGRACES, &
SNIPPET_TIMESIG_NOTE, SNIPPET_TRILL_SPEED, SNIPPET_CROSS_STAFF_ARPEGGIOS, SNIPPET_NUMERICOTTAVA, SNIPPET_TUPLET_ANGLES, &
SNIPPET_HORIZONTAL_TUPLETS

contains

  include "subroutines\AL_NIENTE.f95"
  include "subroutines\ARPEGGIO.f95"
  include "subroutines\ARPEGGIO_TYPE.f95"
  include "subroutines\BAR_CHECK.f95"
  include "subroutines\BAR.f95"
  include "subroutines\BARREST.f95"
  include "subroutines\BARREST_COMPRESS.f95"
  include "subroutines\BREAK.f95"
  include "subroutines\CHANGE_STAFF.f95"
  include "subroutines\CHORD.f95"
  include "subroutines\CLEF.f95"
  include "subroutines\CADENZA.f95"
  include "subroutines\COMMAND.f95"
  include "subroutines\COMMENT.f95"
  include "subroutines\COMPILE.f95"
  include "subroutines\END_ANY.f95"
  include "subroutines\END_GRACE.f95"
  include "subroutines\END_ILY.f95"
  include "subroutines\END_MAKECLUSTERS.f95"
  include "subroutines\END_OTTAVATE.f95"
  include "subroutines\END_POLY.f95"
  include "subroutines\END_REPEAT.f95"
  include "subroutines\END_REPEATBRACKET.f95"          
  include "subroutines\END_STAFF.f95"
  include "subroutines\END_TUPLET.f95"
  include "subroutines\FORCE_CLOSE.f95"
  include "subroutines\GLISSANDO.f95"
  include "subroutines\GRACE.f95"
  include "subroutines\HEADER.f95"
  include "subroutines\HIDE.f95"
  include "subroutines\HORIZONTAL_TUPLETS.f95"
  include "subroutines\ILY.f95"
  include "subroutines\INCLUDE_FILE.f95"
  include "subroutines\KEY.f95"
  include "subroutines\LCASE.f95" ! private subroutine  
  include "subroutines\LIVE_ELECTRONICS.f95"
  include "subroutines\MAKECLUSTERS.f95"
  include "subroutines\MARK.f95"
  include "subroutines\MIDI_PITCH_TO_LP.f95" ! private subroutine
  include "subroutines\NOTE.f95"
  include "subroutines\NOTEHEAD_STYLE.f95"          
  include "subroutines\NOTEHEAD_TRANSPARENT.f95"
  include "subroutines\NUMERICOTTAVA.f95"  
  include "subroutines\OMIT.f95"
  include "subroutines\OTTAVA.f95"
  include "subroutines\OTTAVATE.f95"
  include "subroutines\PAGEBREAK.f95"
  include "subroutines\PAPER.f95"
  include "subroutines\PITCHEDTRILL.f95"
  include "subroutines\POLY.f95"
  include "subroutines\REPEAT.f95"
  include "subroutines\REPEATBRACKET.f95"
  include "subroutines\SNIPPET.f95"
  include "subroutines\SNIPPET_CROSS_STAFF_ARPEGGIOS.f95" ! private subroutine
  include "subroutines\SNIPPET_GRACE_MIDI_DURATION.f95" ! private subroutine
  include "subroutines\SNIPPET_GRACE_ON_BEAT.f95" ! private subroutine
  include "subroutines\SNIPPET_HORIZONTAL_TUPLETS.f95" ! private subroutine
  include "subroutines\SNIPPET_LIVE_ELECTRONICS.f95" ! private subroutine
  include "subroutines\SNIPPET_MINOR_TRILLS.f95" ! private subroutine
  include "subroutines\SNIPPET_NATURALIZEMUSIC.f95" ! private subroutine
  include "subroutines\SNIPPET_NUMERICOTTAVA.f95" ! private subroutine  
  include "subroutines\SNIPPET_OTTAVATE.f95" ! private subroutine
  include "subroutines\SNIPPET_REPEATBRACKET.f95" ! private subroutine
  include "subroutines\SNIPPET_SLASHEDGRACES.f95" ! private subroutine
  include "subroutines\SNIPPET_TIMESIG_NOTE.f95" ! private subroutine
  include "subroutines\SNIPPET_TRILL_SPEED.f95" ! private subroutine
  include "subroutines\SNIPPET_TUPLET_ANGLES.f95" ! private subroutine
  include "subroutines\SCORE.f95"
  include "subroutines\STAFF.f95"          
  include "subroutines\STAFF_LINE_COUNT.f95"
  include "subroutines\STEM.f95"
  include "subroutines\STOPSTAFF.f95"
  include "subroutines\STYLE.f95"
  include "subroutines\SYMBOL.f95"
  include "subroutines\TEMPO.f95"
  include "subroutines\TEXT.f95"
  include "subroutines\TIE.f95"
  include "subroutines\TIE_TYPE.f95"
  include "subroutines\TIME.f95"
  include "subroutines\TRILL.f95"
  include "subroutines\TUPLET.f95"
  include "subroutines\TUPLET_ANGLES.f95"
  include "subroutines\VOICE.f95"
  include "subroutines\XNOTE.f95"

end module lilypondLibraryWin
