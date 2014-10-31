! If called with a .TRUE. argument, it transform as subsequent hairpins into al niente hairpins (circled tip). If called with a .FALSE. argument, or if called without arguments, it reverts the subsequent hairpin
subroutine AL_NIENTE(TF)

logical, optional, intent(in) :: TF
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

if ((present(TF)) .AND. (TF)) then
 write(*,"(A)") "  \override Hairpin.circled-tip = ##t"
 write(11,"(A)") "  \override Hairpin.circled-tip = ##t"
 else
   write(*,"(A)") "  \revert Hairpin.circled-tip"
   write(11,"(A)") "  \revert Hairpin.circled-tip"
endif

end subroutine AL_NIENTE
