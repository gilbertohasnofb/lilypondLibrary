subroutine ARPEGGIO()

! information about advance="NO" for the other subroutines
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"

write(*,"(A)",advance="NO") "\arpeggio "
write(11,"(A)",advance="NO") "\arpeggio "

end subroutine ARPEGGIO
