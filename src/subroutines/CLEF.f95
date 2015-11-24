! Subroutine for clefs: options are "treble", "bass", "alto", "tenor" and "percussion", and also "treble^8", "bass_15", etc.
! If hidden is .TRUE., then clef is not printed on the score. Affects only the current clef (next ones will be visible)
! If called without arguments, it will produce a visible treble clef
subroutine CLEF(string,hidden)

character (LEN=*), optional, intent(IN) :: string
logical, optional, intent(IN) :: hidden
character (LEN=256) :: string_AUX
logical :: hidden_AUX
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

string_AUX="treble"
hidden_AUX=.FALSE.
if (present(string)) string_AUX = string
if (present(hidden)) hidden_AUX = hidden
call LCASE(string_AUX) ! just in case someone writes Treble, Bass, etc. with
 
if (present(hidden)) then
  if (hidden_AUX) then
    write(*,"(A)") "  \once \override Staff.Clef.stencil = ##f"
    write(11,"(A)") "  \once \override Staff.Clef.stencil = ##f"
  endif
endif

write(*,"(A,A,A)") '  \clef "', TRIM(string_AUX), '"'
write(11,"(A,A,A)") '  \clef "', TRIM(string_AUX), '"'

end subroutine CLEF
