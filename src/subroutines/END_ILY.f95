! needed to close VARIABLE()
subroutine END_ILY()

close(unit=7,status="delete")
close(unit=11,status="keep")

end subroutine END_ILY
