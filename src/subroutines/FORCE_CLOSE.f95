! if using a custom \score block written out by calling several instances of COMMAND, then this subroutine can be used to close all temp files
subroutine FORCE_CLOSE(autoCompile)

logical, optional, intent(IN) :: autoCompile ! if set to .TRUE., then the first will automatically compile your score when the executable finishes running automatically. Default = .FALSE.
character (LEN=256) :: filename
logical :: condition

rewind(unit=10)
read(10,"(A)") filename

close(unit=7,status="delete")
open(unit=9,file="temp2")
close(unit=9,status="delete") 
close(unit=10,status="delete")
close(unit=11,status="keep")

inquire(file=filename,exist=condition)
if (condition) then
  write(*,"(A)") "* * *"
  write(*,*)
  write(*,"(A)") "Your file "//TRIM(filename)//" was successfully created!"
  write(*,*)
  else
    write(*,"(A)") "* * *"
    write(*,*)
    write(*,"(A)") "ERROR: something went wrong!"
    write(*,*)    
endif

close(unit=11,status="keep") ! closing the file!

if ( (present(autoCompile)) .AND. (condition) )then
  if (autoCompile) then
    write(*,"(A)") "Compiling your code:"
    write(*,*)
    call SYSTEM('lilypond "'//TRIM(filename)//'"')
    write(*,*)
  endif
endif

end subroutine FORCE_CLOSE
