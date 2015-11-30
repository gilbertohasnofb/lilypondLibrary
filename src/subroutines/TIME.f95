! Subroutine to write time signatures
! If called without TIMESIG_hidden value, it will show the Time Signature
subroutine TIME(top,bottom,hidden,hiddenScore,doubleBarline,bottomNote)

integer, intent(in) :: top, bottom ! Time Signature's upper and lower numbers, respectively. 
logical, optional, intent(in) :: hidden ! If .TRUE., then the time signatures are hidden for the current staff (defalt = .FALSE.)
logical, optional, intent(in) :: hiddenScore ! If .TRUE., then the time signatures are hidden at this point for the whole score (defalt = .FALSE.)
logical, optional, intent(in) :: doubleBarline ! if .TRUE., then a double barline is added before the Time Signature change (defalt = .FALSE.)
logical, optional, intent(in) :: bottomNote ! if .TRUE., then the bottom number will be displayed as a note (defalt = .FALSE.). IMPORTANT!!!: you MUST call TIMESIG_NOTE to add this function in the beginning of your code, before any LilyPond variables start to be created! Applies to the context Score, not Staff.
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

if (present(bottomNote) .AND. (bottomNote)) then
  write(*,"(A)") "  \override Score.TimeSignature.stencil = #format-time-sig-note"
  write(11,"(A)") "  \override Score.TimeSignature.stencil = #format-time-sig-note"
endif

if (present(hiddenScore) .AND. (hiddenScore)) then
  write(*,"(A)") "  \once \override Score.TimeSignature.stencil = ##f"
  write(11,"(A)") "  \once \override Score.TimeSignature.stencil = ##f"
endif

if (present(hidden) .AND. (hidden)) then
  write(*,"(A)") "  \once \override Staff.TimeSignature.stencil = ##f"
  write(11,"(A)") "  \once \override Staff.TimeSignature.stencil = ##f"
endif

if (present(doubleBarline) .AND. (doubleBarline)) call BAR("||")

if (top < 10) then
  write(*,"(A, I1)",advance="NO") "  \time ", top
  write(11,"(A, I1)",advance="NO") "  \time ", top
  else if (top < 100) then
    write(*,"(A, I2)",advance="NO") "  \time ", top
    write(11,"(A, I2)",advance="NO") "  \time ", top
  else
    write(*,"(A, I3)",advance="NO") "  \time ", top
    write(11,"(A, I3)",advance="NO") "  \time ", top
endif

if (bottom < 10) then
  write(*,"(A, I1)") "/", bottom
  write(11,"(A, I1)") "/", bottom
  else if (bottom < 100) then
    write(*,"(A, I2)") "/", bottom
    write(11,"(A, I2)") "/", bottom
  else
    write(*,"(A, I3)") "/", bottom
    write(11,"(A, I3)") "/", bottom    
endif

end subroutine TIME
