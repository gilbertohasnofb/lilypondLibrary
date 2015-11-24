! Subroutine Tempo: creates metronome markings
subroutine TEMPO(tempo_ref,bpm,bpm2,padding,ca,offsetX,offsetY,modernStraightFlag)

character (LEN=*), intent(in) :: tempo_ref ! Durations in LilyPond notation, such as "2." or "8.." or "64"
integer, intent(in) :: bpm ! tempo in bpm
integer, optional, intent(in) :: bpm2 ! tempo will be written as bpm - bpm2, such as "quarter-note = 120 - 128". Cannot be used together with ca.
real, optional, intent(in) :: padding ! controls the vertical position of the metronome. Format n.n
logical, optional, intent(in) :: ca ! if .TRUE., then it writes "tempo_ref = ca. bpm". Cannot be used together with bpm2. Default value = .FALSE.
real, optional, intent(in) :: offsetX, offsetY
logical, optional, intent(in) :: modernStraightFlag ! if .TRUE., the style of the flag changes to modern straight flag
integer :: bpm2_AUX ! auxiliary
logical :: ca_AUX, modernStraightFlag_AUX ! auxiliary
logical :: offset
real :: offsetX_AUX,offsetY_AUX
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
  write(*,*)
  write(11,*)
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one didn't finish with an advance="NO"
! =================================

ca_AUX=.FALSE.
bpm2_AUX=0
offset=.FALSE.
offsetX_AUX=0.
offsetY_AUX=0.
modernStraightFlag_AUX=.FALSE.
if (present(ca)) ca_AUX=ca
if (present(bpm2)) bpm2_AUX=bpm2
if (present(offsetX)) offsetX_AUX=offsetX
if (present(offsetY)) offsetY_AUX=offsetY
if (present(offsetX) .OR. present(offsetY)) offset = .TRUE.
if (present(modernStraightFlag)) modernStraightFlag_AUX = modernStraightFlag 
 
if (present(padding)) then
  write(*,"(A,F3.1)") "  \once \override Score.MetronomeMark.padding = #", padding
  write(11,"(A,F3.1)") "  \once \override Score.MetronomeMark.padding = #", padding
endif

! tweak offset
if (offset) then
  write(*,"(A,F4.1,A,F4.1,A)") "  \once \override Score.MetronomeMark.extra-offset = #'(", &
  offsetX_AUX, " . ", offsetY_AUX, ")"
  write(11,"(A,F4.1,A,F4.1,A)") "  \once \override Score.MetronomeMark.extra-offset = #'(", &
  offsetX_AUX, " . ", offsetY_AUX, ")"
endif


if ((.NOT. ca_AUX).AND.(.NOT. modernStraightFlag_AUX)) then

  if (bpm2_AUX == 0) then
    if (bpm < 100) then
      write(*,"(A,A,A,I2)") "  \tempo ", TRIM(tempo_ref), " = ", bpm
      write(11,"(A,A,A,I2)") "  \tempo ", TRIM(tempo_ref), " = ", bpm
      else
        write(*,"(A,A,A,I3)") "  \tempo ", TRIM(tempo_ref), " = ", bpm
        write(11,"(A,A,A,I3)") "  \tempo ", TRIM(tempo_ref), " = ", bpm
    endif
    else
      if (bpm < 100) then
        write(*,"(A,A,A,I2,A)") "  \tempo ", TRIM(tempo_ref), " = ", bpm,"-"
        write(11,"(A,A,A,I2,A)") "  \tempo ", TRIM(tempo_ref), " = ", bpm,"-"
        else
          write(*,"(A,A,A,I3,A)") "  \tempo ", TRIM(tempo_ref), " = ", bpm,"-"
          write(11,"(A,A,A,I3,A)") "  \tempo ", TRIM(tempo_ref), " = ", bpm,"-"
      endif
      if (bpm2_AUX < 100) then
        write(*,"(I2)") bpm2_AUX
        write(11,"(I2)") bpm2_AUX
        else
          write(*,"(I3)") bpm2_AUX
          write(11,"(I3)") bpm2_AUX
      endif
  endif
 
  else
  
    write(*,"(A)") "  \tempo \markup {\concat { \normal-text \normalsize { "
    write(11,"(A)") "  \tempo \markup {\concat { \normal-text \normalsize { "        
    if (modernStraightFlag_AUX) then
      write(*,"(A)") "    \override #'(flag-style . modern-straight-flag)"
      write(11,"(A)") "    \override #'(flag-style . modern-straight-flag)"
    endif
    write(*,"(A,A,A)") '    \general-align #Y #DOWN \note #"', TRIM(tempo_ref), '" #1 " = "'
    write(11,"(A,A,A)") '    \general-align #Y #DOWN \note #"', TRIM(tempo_ref), '" #1 " = "'
    if (ca_AUX) then   
      write(*,"(A)",advance="NO") "    \italic ca. \hspace #0.25 "
      write(11,"(A)",advance="NO") "    \italic ca. \hspace #0.25 "
    endif
    write(*,"(A,I3)",advance="NO") '"', bpm
    write(11,"(A,I3)",advance="NO") '"', bpm   
    if (bpm2_AUX /= 0) then
      write(*,"(A,I3)",advance="NO")    " – ", bpm2
      write(11,"(A,I3)",advance="NO")    " – ", bpm2
    endif
    write(*,"(A)") '" }}}'
    write(11,"(A)") '" }}}'
   
endif

end subroutine TEMPO
