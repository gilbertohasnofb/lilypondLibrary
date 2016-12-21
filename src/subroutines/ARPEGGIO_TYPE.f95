subroutine ARPEGGIO_TYPE(c)

character (LEN=*), intent(IN) :: c ! options are: "normal" or "revert", "arrowup", "arrowdown", "bracket"
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

if (TRIM(c) == "arrowup") then
  write(*,"(A)",advance="NO") "  \connectArpeggioArrowUp"
  write(11,"(A)",advance="NO") "  \connectArpeggioArrowUp"
  else if (TRIM(c) == "arrowdown") then
    write(*,"(A)",advance="NO") "  \connectArpeggioArrowDown"
    write(11,"(A)",advance="NO") "  \connectArpeggioArrowDown"
  else if (TRIM(c) == "bracket") then
    write(*,"(A)",advance="NO") "  \connectArpeggioBracket"
    write(11,"(A)",advance="NO") "  \connectArpeggioBracket"
  else
    write(*,"(A)",advance="NO") "  \connectArpeggioNormal"
    write(11,"(A)",advance="NO") "  \connectArpeggioNormal"
endif

end subroutine ARPEGGIO_TYPE
