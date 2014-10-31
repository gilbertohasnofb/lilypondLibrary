subroutine CHANGE_STAFF(staffName)

character (LEN=*), intent(IN) :: staffName

! information about advance="NO" for the other subroutines
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"

write(*,"(A,A,A)",advance="NO") ' \change Staff = "', staffName, '"'
write(11,"(A,A,A)",advance="NO") ' \change Staff = "', staffName, '"'

end subroutine CHANGE_STAFF
