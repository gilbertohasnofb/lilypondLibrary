! minimal example

include "lilypondLibrary.f95"

program example1
use lilypondLibrary
implicit none

call HEADER(title="Example 1",filename="example1.ly") ! always start your code by calling HEADER

	call STAFF() ! creating a new staff
		call NOTE(60,"4")
	call END_STAFF() ! ending the previous staff

call SCORE() ! always finish your code by calling SCORE

end program example1
