subroutine MAKECLUSTERS(style,thickness)

character (LEN=*), optional, intent(in) :: style ! options are: left (or leftsided and leftsided-stairs), right (or rightsided and rightsided-stairs) or centered (or centered-stairs)
real, optional, intent (in) :: thickness ! thickness of the line when applied to a single note. A reasonable value is -0.25 (if values get smaller than that, the thickness start to grow again since it is related to the padding of the bottom of the cluster). Format nn.nn
character (LEN=256) :: style_AUX
logical :: previousAdvanceNo ! used to find out what was the spacing before this subroutine was called. if it finished with an advance="NO" or not

style_AUX = " "
if (present(style)) style_AUX = TRIM(style)
call LCASE(style_AUX)

! =========== spacing ==============
rewind(unit=7)
read(7,"(L1)") previousAdvanceNo
if (previousAdvanceNo) then
	write(*,*)
	write(11,*)
endif
close(unit=7,status="delete")
open(unit=7,file="temp3")
write(7,"(L1)") .FALSE. ! this will mean to the next subroutine that this one did not finish with an advance="NO"
! =================================

if ((style_AUX == "left") .OR. (style_AUX == "leftsided") .OR. (style_AUX == "leftsided-stairs")) then
	write(*,"(A)") "  \once \override ClusterSpanner.style = #'leftsided-stairs"
	write(11,"(A)") "  \once \override ClusterSpanner.style = #'leftsided-stairs"
endif

if ((style_AUX == "right") .OR. (style_AUX == "rightsided") .OR. (style_AUX == "rightsided-stairs")) then
	write(*,"(A)") "  \once \override ClusterSpanner.style = #'rightsided-stairs"
	write(11,"(A)") "  \once \override ClusterSpanner.style = #'rightsided-stairs"
endif

if ((style_AUX == "centered") .OR. (style_AUX == "centered-stairs")) then
	write(*,"(A)") "  \once \override ClusterSpanner.style = #'centered-stairs"
	write(11,"(A)") "  \once \override ClusterSpanner.style = #'centered-stairs"
endif

write(*,"(A)") "  \makeClusters {"
write(11,"(A)") "  \makeClusters {"

if (present(thickness)) then
	write(*,"(A,F5.2)") "  \override ClusterSpanner.padding = #", thickness
	write(11,"(A,F5.2)") "  \override ClusterSpanner.padding = #", thickness
endif

end subroutine MAKECLUSTERS
