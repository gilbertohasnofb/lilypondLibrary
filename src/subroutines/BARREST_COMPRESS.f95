! this subroutine reads through an input file and groups all consecutive "  R1 |" or "  R1" into a single R1*n, where n is the number of consecutive bar rests. It only works for bar rests in a 4/4 meter

subroutine BARREST_COMPRESS(input,output,removeInput)
	
	character (LEN=*), intent(IN) :: input, output
	logical, optional, intent(IN) :: removeInput
	character(LEN=10000) :: var, command
	integer :: error, n
	logical :: previousR1
	
	previousR1 = .FALSE.
	n = 0	
	
	open(unit=12,file=TRIM(input))
	open(unit=13,file=TRIM(output))
	
	do 
		
		read(12,"(A)",IOSTAT=error) var
		
		if (error/=0) then
			if (.NOT. previousR1) then
				exit
				else
					write(13,"(A,I2,A)") "*", n, " | "
					exit
			endif
		endif
		
		if (((TRIM(var) /= "  R1 |") .AND. (TRIM(var) /= "  R1")) .AND. (.NOT. previousR1)) then
			write(13,"(A)") TRIM(var)
			previousR1 = .FALSE.
		endif
		
		if (((TRIM(var) /= "  R1 |") .AND. (TRIM(var) /= "  R1")) .AND. (previousR1)) then
			if (n<10) then
				write(13,"(A,I1,A)") "*", n, " | "
				else if (n<100) then
					write(13,"(A,I2,A)") "*", n, " | "
				else if (n<1000) then 
					write(13,"(A,I3,A)") "*", n, " | "
				else
					write(13,"(A,I4,A)") "*", n, " | "
			endif          
			write(13,"(A)") TRIM(var)
			previousR1 = .FALSE.
		endif
		
		if (((TRIM(var) == "  R1 |") .OR. (TRIM(var) == "  R1")) .AND. (.NOT. previousR1)) then
			write(13,"(A)",advance="NO") "  R1"
			n = 0
			previousR1 = .TRUE.
		endif
		
		if (((TRIM(var) == "  R1 |") .OR. (TRIM(var) == "  R1")) .AND. (previousR1)) then
			n = n + 1
			previousR1 = .TRUE.
		endif
		
	enddo
	
	close(unit=12)
	close(unit=13)
	
	if ((present(removeInput)) .AND. (removeInput)) call SYSTEM("rm "//TRIM(input))
	
end subroutine BARREST_COMPRESS
