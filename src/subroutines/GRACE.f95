! Subroutine start grace. Creates a grace note group. The argument c is optional (default= "grace"). If not present, then options are:
! "\grace"
! "\slashedGrace"
! "\appoggiatura"
! "\acciaccatura"
subroutine GRACE(c)

character (LEN=*), optional, intent(in) :: c ! optional, If not present, then regular graces will be produced. Else, options are: "\grace", "\slashedGrace", "\appoggiatura" or "\acciaccatura"
! if using arguments.f95, variables slashedGrace (or simply slashed), appoggiatura and acciaccatura are available
character (LEN=256) c_AUX
integer :: i
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
  write(*,"(A)",advance="NO") " "
  write(11,"(A)",advance="NO") " "
  else
    write(*,"(A)",advance="NO") "  "
    write(11,"(A)",advance="NO") "  "    
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .TRUE. ! this will mean to the next subroutine that this one did finish with an advance="NO"
! =================================

if (.NOT. present(c)) then
  write(*,"(A)",advance="NO") "\grace {"
  write(11,"(A)",advance="NO") "\grace {"
  else
    c_AUX = c
    call LCASE(c_AUX)
    ! if starts with \, I will remove it. This way, the user can enter either \grace or grace, meaning less errors
    if (c_AUX(1:1) == "\") then
      do i=1,LEN_TRIM(c_AUX)-1
        c_AUX(i:i) = c_AUX(i+1:i+1)
      enddo
      c_AUX(LEN_TRIM(c_AUX):LEN_TRIM(c_AUX)) = " "
    endif
    
    select case (TRIM(c_AUX))
      case("grace")
        write(*,"(A)",advance="NO") "\grace {"
        write(11,"(A)",advance="NO") "\grace {"
      case("default")
        write(*,"(A)",advance="NO") "\grace {"
        write(11,"(A)",advance="NO") "\grace {"
      case default
        write(*,"(A)",advance="NO") "\grace {"
        write(11,"(A)",advance="NO") "\grace {"
      case("slashedgrace")
        write(*,"(A)",advance="NO") "\slashedGrace {"
        write(11,"(A)",advance="NO") "\slashedGrace {"
      case("appoggiatura")
        write(*,"(A)",advance="NO") "\appoggiatura {"
        write(11,"(A)",advance="NO") "\appoggiatura {"
      case("acciaccatura")
        write(*,"(A)",advance="NO") "\acciaccatura {"
        write(11,"(A)",advance="NO") "\acciaccatura {"
    end select
    
endif

end subroutine GRACE
