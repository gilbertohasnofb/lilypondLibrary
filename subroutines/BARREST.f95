subroutine BARREST(N, TIMEtop, TIMEbottom, invisible, fermata)

integer, optional, intent(in) :: N ! number of bar rests (i.e., multibar rest)
integer, optional, intent(in) :: TIMEtop, TIMEbottom ! Current time Signature's upper and lower numbers, respectively. If nothing is entered, then a 4/4 measure is assumed
logical, optional, intent(in) :: invisible ! if .TRUE., then the bar rest is invisible (useful when using CHANGE_STAFF, for instance). Default = .FALSE.
logical, optional, intent(in) :: fermata ! if .TRUE., then a fermata is added above the bar rest. Default = .FALSE.
integer :: N_AUX, TIMEtop_AUX, TIMEbottom_AUX ! Auxiliary variables
logical :: invisible_AUX ! Auxiliary variable
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

N_AUX = 1
TIMEtop_AUX = 4
TIMEbottom_AUX = 4
invisible_AUX = .FALSE.
if (present(N)) N_AUX = N
if ((present(TIMEtop)).AND.(present(TIMEbottom))) then
  TIMEtop_AUX = TIMEtop
  TIMEbottom_AUX = TIMEbottom
endif
if (present(invisible)) invisible_AUX=invisible

! visibility
if (.NOT. invisible_AUX) then
  write(*,"(A)",advance="NO") "R1"
  write(11,"(A)",advance="NO") "R1"
  else
    write(*,"(A)",advance="NO") "s1"
    write(11,"(A)",advance="NO") "s1"
endif 

if (TIMEtop_AUX /= TIMEbottom_AUX) then ! i.e., not 4/4, 2/2, 8/8, etc.

  if ((TIMEtop_AUX*N_AUX < 10) .AND. (TIMEbottom_AUX < 10)) then
    write(*,"(A,I1,A,I1)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
    write(11,"(A,I1,A,I1)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
  endif
  if ((TIMEtop_AUX*N_AUX >= 10) .AND. (TIMEbottom_AUX < 10)) then
    write(*,"(A,I2,A,I1)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
    write(11,"(A,I2,A,I1)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
  endif
  if ((TIMEtop_AUX*N_AUX < 10) .AND. (TIMEbottom_AUX >= 10)) then
    write(*,"(A,I1,A,I2)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
    write(11,"(A,I1,A,I2)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
  endif
  if ((TIMEtop_AUX*N_AUX >= 10) .AND. (TIMEbottom_AUX >= 10)) then
    write(*,"(A,I2,A,I2)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
    write(11,"(A,I2,A,I2)",advance="NO") "*", TIMEtop_AUX*N_AUX, "/", TIMEbottom_AUX
  endif
 
  else ! i.e., if 4/4, 2/2, etc.
   
		if (N_AUX /= 1) then ! since if N_AUX=1, then it is not necessary to have R1*1, only R1
			if (N_AUX < 10) then 
				write(*,"(A,I1)",advance="NO") "*", N_AUX
				write(11,"(A,I1)",advance="NO") "*", N_AUX
				else
					write(*,"(A,I2)",advance="NO") "*", N_AUX
					write(11,"(A,I2)",advance="NO") "*", N_AUX
			endif
		endif
   
endif

if (present(fermata)) then
	if ((fermata).AND.(.NOT. invisible_AUX)) then
		write(*,"(A)",advance="NO") "\fermataMarkup"
		write(11,"(A)",advance="NO") "\fermataMarkup"
	endif
endif
   
end subroutine BARREST
