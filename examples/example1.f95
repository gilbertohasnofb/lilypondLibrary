include "lilypondLibrary.f95"

program example1
use lilypondLibrary
implicit none

call HEADER("Example 1")

call STAFF()
	call NOTE(60,"4")
call END_STAFF()

call SCORE()

end program example1
