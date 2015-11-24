! Paper options
! All variables are optional
subroutine PAPER(globalStaffSize, paperSize, landscape, topMargin, bottomMargin, leftMargin, rightMargin, indent, &
printPageNumber, printFirstPageNumber, firstPageNumber, bottomPageNumber, raggedLast, raggedLastBottom, slashSeparator, &
doubleSlashSeparator, minSystemsPerPage, maxSystemsPerPage, systemDistance, systemPadding, markupSystemSpacing)

real, optional, intent(in) :: globalStaffSize ! sets the staff size globally, format nn.n
character (LEN=*), optional, intent(in) :: paperSize ! Paper size, values can be "a4", "a3", "ledger", "letter", etc.
logical, optional, intent(in) :: landscape ! if .TRUE., paper is set to landscape orientation. Default = .FALSE. (i.e., portrait orientation)
real, optional, intent(in) :: topMargin ! Top margin, in cm
real, optional, intent(in) :: bottomMargin ! Bottom margin, in cm
real, optional, intent(in) :: leftMargin ! Left margin, in cm
real, optional, intent(in) :: rightMargin ! Right margin, in cm
real, optional, intent(in) :: indent ! Indentation, in cm. Format n.n
logical, optional, intent(in) :: printPageNumber ! If .TRUE. then page numbers are visible (except for the 1st)
logical, optional, intent(in) :: printFirstPageNumber ! If .TRUE. then 1st page number is visible
integer, optional, intent(in) :: firstPageNumber ! Makes the first page of the score to have a different page number. Default = 1
logical, optional, intent(in) :: bottomPageNumber ! If .TRUE. then page numbers will be displayed in the centre of the bottom of the page
logical, optional, intent(in) :: raggedLast ! If .TRUE., last system will not spread to fill the line horizontally. Default = .FALSE.
logical, optional, intent(in) :: raggedLastBottom ! If .TRUE., then systems will spread vertically down the last page
logical, optional, intent(in) :: slashSeparator ! If .TRUE. then a pair of slashes are drawn between systems (use either this or doubleSlashSeparator, but not both)
logical, optional, intent(in) :: doubleSlashSeparator ! If .TRUE. then two pairs of slashes are drawn between systems (use either this or slashSeparator, but not both)
integer, optional, intent(in) :: minSystemsPerPage ! sets a minimal number of systems in one page
integer, optional, intent(in) :: maxSystemsPerPage ! sets a maximal number of systems in one page
real, optional, intent (in) :: systemDistance ! Vertical distance between systems. Format nn.n
real, optional, intent (in) :: systemPadding ! Vertical distance between a system and the other system's objects. Format nn.n
real, optional, intent (in) :: markupSystemSpacing ! Vertical distance between a markup and the next system, useful for controlling the distance between the title and the 1st system. Format nn.n

if (present(globalStaffSize)) then
  write(*,"(A,1X,F4.1,A)") "#(set-global-staff-size", globalStaffSize, ")"
  write(11,"(A,1X,F4.1,A)") "#(set-global-staff-size", globalStaffSize, ")"
endif

if (present(paperSize)) then

  write(*,"(A,A)",advance="NO") '#(set-default-paper-size "', paperSize
  write(11,"(A,A)",advance="NO") '#(set-default-paper-size "', paperSize
  if (present(landscape)) then
    if (landscape) then
      write(*,"(A)") 'landscape" )'
      write(11,"(A)") 'landscape" )'
      else
        write(*,"(A)") '" )'
        write(11,"(A)") '" )'
    endif
    else
      write(*,"(A)") '" )'
      write(11,"(A)") '" )'
  endif
  
  else
  
  if (present(landscape)) then
    if (landscape) then
      write(*,"(A)") '#(set-default-paper-size "a4landscape" )'
      write(11,"(A)") '#(set-default-paper-size "a4landscape" )'
    endif
  endif
  
endif

write(*,*)
write(11,*)

write(*,"(A)") '\paper {'
write(11,"(A)") '\paper {'

if (present(topMargin)) then
  write(*,"(A,1X,F3.1,A)") '  top-margin =', topMargin, '\cm'
  write(11,"(A,1X,F3.1,A)") '  top-margin =', topMargin, '\cm'
endif
if (present(bottomMargin)) then
write(*,"(A,1X,F3.1,A)") '  bottom-margin =', bottomMargin, '\cm'
write(11,"(A,1X,F3.1,A)") '  bottom-margin =',bottomMargin, '\cm'
endif
if (present(leftMargin)) then
write(*,"(A,1X,F3.1,A)") '  left-margin =', leftMargin, '\cm'
write(11,"(A,1X,F3.1,A)") '  left-margin =', leftMargin, '\cm'
endif
if (present(rightMargin)) then
write(*,"(A,1X,F3.1,A)") '  right-margin =', rightMargin, '\cm'
write(11,"(A,1X,F3.1,A)") '  right-margin =', rightMargin, '\cm'
endif

if (present(indent)) then
  write(*,"(A,F3.1,A)") '  indent = ', indent, '\cm'
  write(11,"(A,F3.1,A)") '  indent = ', indent, '\cm'
endif

if (present(printPageNumber)) then
  if (printPageNumber) then
    write(*,"(A)") '  print-page-number = ##t'
    write(11,"(A)") '  print-page-number = ##t'
    else
      write(*,"(A)") '  print-page-number = ##f'
      write(11,"(A)") '  print-page-number = ##f'
  endif
endif

if (present(printFirstPageNumber)) then
  if (printFirstPageNumber) then
    write(*,"(A)") '  print-first-page-number = ##t'
    write(11,"(A)") '  print-first-page-number = ##t'
    else
      write(*,"(A)") '  print-first-page-number = ##f'
      write(11,"(A)") '  print-first-page-number = ##f'
  endif
endif

if (present(firstPageNumber) .AND. (firstPageNumber > 1)) then
  if (firstPageNumber < 10) then
    write(*,"(A,I1)")"  first-page-number = ", firstPageNumber
    write(11,"(A,I1)")"  first-page-number = ", firstPageNumber
    else if (firstPageNumber < 100) then
      write(*,"(A,I2)")"  first-page-number = ", firstPageNumber
      write(11,"(A,I2)")"  first-page-number = ", firstPageNumber
    else 
      write(*,"(A,I3)")"  first-page-number = ", firstPageNumber
      write(11,"(A,I3)")"  first-page-number = ", firstPageNumber
  endif
endif

if (present(bottomPageNumber)) then
  if (bottomPageNumber) then
    write(*,"(A)") '  oddHeaderMarkup = ""'
    write(11,"(A)") '  oddHeaderMarkup = ""'
    write(*,"(A)") '  evenHeaderMarkup = ""'
    write(11,"(A)") '  evenHeaderMarkup = ""'
    write(*,"(A)") "  oddFooterMarkup = \markup \fill-line {\fromproperty #'page:page-number-string }"
    write(11,"(A)") "  oddFooterMarkup = \markup \fill-line {\fromproperty #'page:page-number-string }"
    write(*,"(A)")"  evenFooterMarkup = \markup \fill-line {\fromproperty #'page:page-number-string }"
    write(11,"(A)")"  evenFooterMarkup = \markup \fill-line {\fromproperty #'page:page-number-string }"
  endif
endif

if (present(raggedlast)) then
  if (raggedlast) then
    write(*,"(A)") '  ragged-last = ##t'
    write(11,"(A)") '  ragged-last = ##t'
    else
      write(*,"(A)") '  ragged-last = ##f'
      write(11,"(A)") '  ragged-last = ##f'
  endif
endif

if (present(raggedLastBottom)) then
  if (raggedLastBottom) then
    write(*,"(A)") '  ragged-last-bottom = ##f'
    write(11,"(A)") '  ragged-last-bottom = ##f'
    else
      write(*,"(A)") '  ragged-last-bottom = ##t'
      write(11,"(A)") '  ragged-last-bottom = ##t'
  endif
endif

if (present(slashSeparator)) then
  if (slashSeparator) then
    write(*,"(A)") '  system-separator-markup = \slashSeparator'
    write(11,"(A)") '  system-separator-markup = \slashSeparator'
    else
      write(*,"(A)") '  system-separator-markup = ##f'
      write(11,"(A)") '  system-separator-markup = ##f'
  endif
endif

if (present(slashSeparator)) then
  if (slashSeparator) then
    write(*,"(A)",advance="NO") '  system-separator-markup = '
    write(11,"(A)",advance="NO") '  system-separator-markup = '
    write(*,"(A)") '\markup { \fill-line { \slashSeparator \slashSeparator }}'
    write(11,"(A)") '\markup { \fill-line { \slashSeparator \slashSeparator }}'    
    else
      write(*,"(A)") '  system-separator-markup = ##f'
      write(11,"(A)") '  system-separator-markup = ##f'
  endif
endif

if (present(minSystemsPerPage)) then
  write(*,"(A,1X,I1)") "  min-systems-per-page =", minSystemsPerPage
  write(11,"(A,1X,I1)") "  min-systems-per-page =", minSystemsPerPage
endif

if (present(maxSystemsPerPage)) then
  write(*,"(A,1X,I1)") "  max-systems-per-page =", maxSystemsPerPage
  write(11,"(A,1X,I1)") "  max-systems-per-page =", maxSystemsPerPage
endif

if ( (present(systemDistance)) .AND. (present(systemPadding)) ) then
  write(*,"(A,1X)",advance="NO") "  system-system-spacing = #'((basic-distance ."
  write(11,"(A,1X)",advance="NO") "  system-system-spacing = #'((basic-distance ."
  write(*,"(F4.1,A,1X,F4.1,A)") systemDistance, ") (padding .", systemPadding, "))"
  write(11,"(F4.1,A,1X,F4.1,A)") systemDistance, ") (padding .", systemPadding, "))"
  else if (present(systemDistance)) then
    write(*,"(A,1X)",advance="NO") "  system-system-spacing = #'(basic-distance ."
    write(11,"(A,1X)",advance="NO") "  system-system-spacing = #'(basic-distance ."
    write(*,"(F4.1,A,1X,F4.1,A)") systemDistance, ")"
    write(11,"(F4.1,A,1X,F4.1,A)") systemDistance, ")"
  else if (present(systemPadding)) then
    write(*,"(A,1X)",advance="NO") "  system-system-spacing = #'(padding ."
    write(11,"(A,1X)",advance="NO") "  system-system-spacing = #'(padding ."
    write(*,"(F4.1,A,1X,F4.1,A)") systemPadding, ")"
    write(11,"(F4.1,A,1X,F4.1,A)") systemPadding, ")"
endif

if (present(markupSystemSpacing)) then
  write(*,"(A,F4.1,A)") "  markup-system-spacing = #'((basic-distance . ", markupSystemSpacing, "))"
  write(11,"(A,F4.1,A)") "  markup-system-spacing = #'((basic-distance . ", markupSystemSpacing, "))"
endif

write(*,"(A)") '}'
write(11,"(A)") '}'

write(*,*)
write(11,*)

end subroutine PAPER

