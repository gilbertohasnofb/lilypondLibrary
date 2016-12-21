subroutine ARPEGGIO_TYPE(c)

character (LEN=*), intent(IN) :: c ! options are: "normal" or "revert", "arrowup", "arrowdown", "bracket"
character (LEN=20) :: c_aux
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

c_aux = c
call LCASE(c_aux)

if (TRIM(c_aux) == "arrowup") then
  write(*,"(A)") "  \connectArpeggioArrowUp"
  write(11,"(A)") "  \connectArpeggioArrowUp"
  else if (TRIM(c_aux) == "arrowdown") then
    write(*,"(A)") "  \connectArpeggioArrowDown"
    write(11,"(A)") "  \connectArpeggioArrowDown"
  else if (TRIM(c_aux) == "bracket") then
    write(*,"(A)") "  \connectArpeggioBracket"
    write(11,"(A)") "  \connectArpeggioBracket"
  else
    write(*,"(A)") "  \connectArpeggioNormal"
    write(11,"(A)") "  \connectArpeggioNormal"
endif

end subroutine ARPEGGIO_TYPE
