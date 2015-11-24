! this subroutine will call a function which creates repeat brackets above repeated barlines in the style |----3x----|--2x--| etc. 
! Remeber to activate it immediately after VERSION via SNIPPET(repetitionBracket=.TRUE.)
! call REPEATBRACKET(n) to start a repetition of n times, and to finish the repetition use call END_REPEATBRACKET or END_ANY
subroutine REPEATBRACKET(n)

integer, intent(IN) :: n ! number of repetitions
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
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

if (n < 10) then
  write(*,"(A,I1,A)") "  \repeatBracket ", n, " {"
  write(11,"(A,I1,A)") "  \repeatBracket ", n, " {"
  else if (n < 100) then
    write(*,"(A,I2,A)") "  \repeatBracket ", n, " {"
    write(11,"(A,I2,A)") "  \repeatBracket ", n, " {"
  else ! with minimalist music, you never know :o)
    write(*,"(A,I3,A)") "  \repeatBracket ", n, " {"
    write(11,"(A,I3,A)") "  \repeatBracket ", n, " {"
endif

end subroutine REPEATBRACKET
