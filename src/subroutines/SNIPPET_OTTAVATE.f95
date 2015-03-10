! by David Nalesnik. From: http://lilypond.1069038.n5.nabble.com/Automatic-ottava-handling-td167190i20.html
subroutine SNIPPET_OTTAVATE()

write(*,"(A)") "#(define (ledger-line-no middle-C-pos p)"
write(*,"(A)") "   (let* ((ps (ly:pitch-steps p))"
write(*,"(A)") "          (mid-staff-steps (- middle-C-pos))"
write(*,"(A)") "          (top-line (+ mid-staff-steps 4))"
write(*,"(A)") "          (bottom-line (- mid-staff-steps 4))"
write(*,"(A)") "          (above? (> ps top-line))"
write(*,"(A)") "          (below? (< ps bottom-line))"
write(*,"(A)") "          (steps-outside-staff"
write(*,"(A)") "           (cond"
write(*,"(A)") "            (below? (- ps bottom-line))"
write(*,"(A)") "            (above? (- ps top-line))"
write(*,"(A)") "            (else 0))))"
write(*,"(A)") "     (truncate (/ steps-outside-staff 2))))"
write(*,*)
write(*,"(A)") "#(define (find-clefMiddleCPosition mus)"
write(*,"(A)") "   (let ((clef-pos -6)) ; treble is default"
write(*,"(A)") "     (for-some-music"
write(*,"(A)") "      (lambda (x)"
write(*,"(A)") "        (let ((n (ly:music-property x 'symbol)))"
write(*,"(A)") "          (and (eq? n 'middleCClefPosition)"
write(*,"(A)") "               (set! clef-pos (ly:music-property x 'value)))))"
write(*,"(A)") "      mus)"
write(*,"(A)") "     clef-pos))"
write(*,*)
write(*,"(A)") "#(define clefs"
write(*,"(A)") "   '((treble . -6)"
write(*,"(A)") "     (treble_8 . 1)"
write(*,"(A)") "     (bass . 6)"
write(*,"(A)") "     (bass_8 . 13)"
write(*,"(A)") "     (alto . 0)"
write(*,"(A)") "     (tenor . 2)))"
write(*,*)
write(*,"(A)") "#(define (make-ottava-music arg)"
write(*,"(A)") "   (list (make-music"
write(*,"(A)") "          'OttavaMusic"
write(*,"(A)") "          'ottava-number arg)))"
write(*,*)
write(*,"(A)") "#(define (select-ottava-music str)"
write(*,"(A)") "   (let ((options"
write(*,"(A,A)") "          '((",'"up-an-octave" . 1)'
write(*,"(A)") '            ("down-an-octave" . -1)'
write(*,"(A)") '            ("up-two-octaves" . 2)'
write(*,"(A)") '            ("down-two-octaves" . -2)'
write(*,"(A)") '            ("loco" . 0))))'
write(*,"(A)") "     (make-ottava-music (assoc-get str options))))"
write(*,*)
write(*,"(A)") "#(define naming-options"
write(*,"(A,A)") "   '((short . ((",'"up-an-octave" . "8")'
write(*,"(A)") '               ("down-an-octave" . "8")'
write(*,"(A)") '               ("up-two-octaves" . "15")'
write(*,"(A)") '               ("down-two-octaves" . "15")'
write(*,"(A)") '               ("loco" . #f)))'
write(*,"(A,A)") "     (long . ((",'"up-an-octave" . "8va")'
write(*,"(A)") '              ("down-an-octave" . "8va bassa")'
write(*,"(A)") '              ("up-two-octaves" . "15ma")'
write(*,"(A)") '              ("down-two-octaves" . "15ma")'
write(*,"(A)") '              ("loco" , #f)))'
write(*,"(A)") "     (default . #f)))"
write(*,*)
write(*,"(A)") "#(define (make-alternate-name name)"
write(*,"(A)") "   (let* ((ps (make-music"
write(*,"(A)") "               'PropertySet"
write(*,"(A)") "               'symbol 'ottavation"
write(*,"(A)") "               'value name))"
write(*,"(A)") "          (csm (make-music"
write(*,"(A)") "                'ContextSpeccedMusic"
write(*,"(A)") "                'element ps"
write(*,"(A)") "                'context-type 'Staff)))"
write(*,"(A)") "     (list csm)))"
write(*,*)
write(*,"(A)") "#(define (select-name displacement name-style)"
write(*,"(A)") "   (let* ((style (assoc-get name-style naming-options))"
write(*,"(A)") "          (name (if style"
write(*,"(A)") "                    (assoc-get displacement style)"
write(*,"(A)") "                    #f)))"
write(*,"(A)") "     (if name"
write(*,"(A)") "         (make-alternate-name name)"
write(*,"(A)") "         '())))"
write(*,*)
write(*,"(A)") "ottavate = #(define-music-function (parser location upper lower options mus)"
write(*,"(A)") "   (number-pair? number-pair? (list? '()) ly:music?)"
write(*,"(A)") "   (let* ((upper8 (car upper))"
write(*,"(A)") "          (upper15 (cdr upper))"
write(*,"(A)") "          (lower8 (car lower))"
write(*,"(A)") "          (lower15 (cdr lower))"
write(*,"(A)") "          (name-style (assoc-get 'name-style options 'default))"
write(*,"(A)") "          ;; Since clef information is found by scanning the music expression, any clef"
write(*,"(A)") "          ;; change must be within the music expression fed to ottavate.  There is no access"
write(*,"(A)") "          ;; to context properties from within a music function.  User needs to tell"
write(*,"(A)") "          ;; \ottavate the opening clef if it is other than treble and not set within"
write(*,"(A)") "          ;; the music expression on which \ottavate is called."
write(*,"(A)") "          (opening-clef (assoc-get 'opening-clef options 'treble))"
write(*,"(A)") "          (opening-middle-C-pos (assoc-get opening-clef clefs)) "
write(*,"(A)") "          (loco (make-ottava-music 0)))"
write(*,*)     
write(*,"(A)") "     (define (select-displacement-string ledger-count)"
write(*,"(A)") "       (cond" 
write(*,"(A)") "        ((> ledger-count upper15)"
write(*,"(A)") '         "up-two-octaves")'
write(*,"(A)") "        ((>= ledger-count upper8)"
write(*,"(A)") '         "up-an-octave")'
write(*,"(A)") "        ((< ledger-count lower15)"
write(*,"(A)") '         "down-two-octaves")'
write(*,"(A)") "        ((<= ledger-count lower8)"
write(*,"(A)") '         "down-an-octave")'
write(*,"(A)") '        (else "loco")))'
write(*,*)     
write(*,"(A)") "     (define (calc-displacement clef-pos mus-expr)"
write(*,"(A)") "       (cond"
write(*,"(A)") "        ((music-is-of-type? mus-expr 'event-chord)"
write(*,"(A)") "         (let* ((elts (ly:music-property mus-expr 'elements))"
write(*,"(A)") "                (ledger-list"
write(*,"(A)") "                 (map (lambda (e)"
write(*,"(A)") "                        (ledger-line-no clef-pos (ly:music-property e 'pitch)))"
write(*,"(A)") "                   elts))"
write(*,"(A)") "                (lowest (apply min ledger-list))"
write(*,"(A)") "                (highest (apply max ledger-list)))"
write(*,"(A)") "           (cond"
write(*,"(A)") "            ((every positive? ledger-list)"
write(*,"(A)") "             (select-displacement-string lowest))"
write(*,"(A)") "            ((every negative? ledger-list)"
write(*,"(A)") "             (select-displacement-string highest))"
write(*,"(A)") '            (else "loco"))))'
write(*,"(A)") "        ((music-is-of-type? mus-expr 'note-event)"
write(*,"(A)") "         (let* ((pitch (ly:music-property mus-expr 'pitch))"
write(*,"(A)") "                (ledger-count (ledger-line-no clef-pos pitch)))"
write(*,"(A)") "           (select-displacement-string ledger-count)))))"
write(*,*)     
write(*,"(A)") "     (define (build-new-elts mus-expr new-expr prev clef-pos)"
write(*,"(A)") "       (if (null? mus-expr)"
write(*,"(A)") "           new-expr"
write(*,"(A)") "           (begin"
write(*,"(A)") "            (if (music-is-of-type? (car mus-expr) 'context-specification)"
write(*,"(A)") "                (set! clef-pos (find-clefMiddleCPosition (car mus-expr))))"
write(*,"(A)") "            (cond"
write(*,"(A)") "             ;; We do not extend across rests for now."
write(*,"(A)") "             ((music-is-of-type? (car mus-expr) 'rest-event)"
write(*,"(A)") "              (build-new-elts"
write(*,"(A)") "               (cdr mus-expr)"
write(*,"(A)") "               (append"
write(*,"(A)") "                new-expr"
write(*,"(A)") "                loco"
write(*,"(A)") "                (list (car mus-expr)))"
write(*,"(A)") '               "loco" clef-pos))'
write(*,*)             
write(*,"(A)") "             ((or (music-is-of-type? (car mus-expr) 'event-chord)"
write(*,"(A)") "                  (music-is-of-type? (car mus-expr) 'note-event))"
write(*,"(A)") "              (let ((d (calc-displacement clef-pos (car mus-expr))))"
write(*,"(A)") "                (cond"
write(*,"(A)") "                 ((and d (not (string=? d prev)))"
write(*,"(A)") "                  (build-new-elts"
write(*,"(A)") "                   (cdr mus-expr)"
write(*,"(A)") "                   (append"
write(*,"(A)") "                    new-expr"
write(*,"(A)") "                    (select-ottava-music d)"
write(*,"(A)") "                    (select-name d name-style)"
write(*,"(A)") "                    (list (car mus-expr)))"
write(*,"(A)") "                   d clef-pos))"
write(*,"(A)") "                 (else"
write(*,"(A)") "                  (build-new-elts"
write(*,"(A)") "                   (cdr mus-expr)"
write(*,"(A)") "                   (append new-expr (list (car mus-expr)))"
write(*,"(A)") "                   prev clef-pos)))))"
write(*,"(A)") "             ; ew."
write(*,"(A)") "             (else" 
write(*,"(A)") "              (build-new-elts"
write(*,"(A)") "               (cdr mus-expr)"
write(*,"(A)") "               (append new-expr (list (car mus-expr)))"
write(*,"(A)") "               prev clef-pos))))))"
write(*,*)     
write(*,"(A)") "     (define (recurse music)"
write(*,"(A)") "       (let ((elts (ly:music-property music 'elements))"
write(*,"(A)") "             (e (ly:music-property music 'element)))"
write(*,"(A)") "         (if (ly:music? e)"
write(*,"(A)") "             (recurse e))"
write(*,"(A)") "         (if (pair? elts)"
write(*,"(A)") "             (if (or"
write(*,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'note-event)) elts)"
write(*,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'event-chord)) elts)"
write(*,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'rest-event)) elts))"
write(*,"(A)") "                 (set! (ly:music-property music 'elements)"
write(*,"(A,A)") "                       (build-new-elts elts '",'() "loco" opening-middle-C-pos))'
write(*,"(A)") "                 (map recurse elts)))))"
write(*,"(A)") "     (recurse mus)"
write(*,"(A)") "     mus))"

write(11,"(A)") "#(define (ledger-line-no middle-C-pos p)"
write(11,"(A)") "   (let* ((ps (ly:pitch-steps p))"
write(11,"(A)") "          (mid-staff-steps (- middle-C-pos))"
write(11,"(A)") "          (top-line (+ mid-staff-steps 4))"
write(11,"(A)") "          (bottom-line (- mid-staff-steps 4))"
write(11,"(A)") "          (above? (> ps top-line))"
write(11,"(A)") "          (below? (< ps bottom-line))"
write(11,"(A)") "          (steps-outside-staff"
write(11,"(A)") "           (cond"
write(11,"(A)") "            (below? (- ps bottom-line))"
write(11,"(A)") "            (above? (- ps top-line))"
write(11,"(A)") "            (else 0))))"
write(11,"(A)") "     (truncate (/ steps-outside-staff 2))))"
write(11,*)
write(11,"(A)") "#(define (find-clefMiddleCPosition mus)"
write(11,"(A)") "   (let ((clef-pos -6)) ; treble is default"
write(11,"(A)") "     (for-some-music"
write(11,"(A)") "      (lambda (x)"
write(11,"(A)") "        (let ((n (ly:music-property x 'symbol)))"
write(11,"(A)") "          (and (eq? n 'middleCClefPosition)"
write(11,"(A)") "               (set! clef-pos (ly:music-property x 'value)))))"
write(11,"(A)") "      mus)"
write(11,"(A)") "     clef-pos))"
write(11,*)
write(11,"(A)") "#(define clefs"
write(11,"(A)") "   '((treble . -6)"
write(11,"(A)") "     (treble_8 . 1)"
write(11,"(A)") "     (bass . 6)"
write(11,"(A)") "     (bass_8 . 13)"
write(11,"(A)") "     (alto . 0)"
write(11,"(A)") "     (tenor . 2)))"
write(11,*)
write(11,"(A)") "#(define (make-ottava-music arg)"
write(11,"(A)") "   (list (make-music"
write(11,"(A)") "          'OttavaMusic"
write(11,"(A)") "          'ottava-number arg)))"
write(11,*)
write(11,"(A)") "#(define (select-ottava-music str)"
write(11,"(A)") "   (let ((options"
write(11,"(A,A)") "          '((",'"up-an-octave" . 1)'
write(11,"(A)") '            ("down-an-octave" . -1)'
write(11,"(A)") '            ("up-two-octaves" . 2)'
write(11,"(A)") '            ("down-two-octaves" . -2)'
write(11,"(A)") '            ("loco" . 0))))'
write(11,"(A)") "     (make-ottava-music (assoc-get str options))))"
write(11,*)
write(11,"(A)") "#(define naming-options"
write(11,"(A,A)") "   '((short . ((",'"up-an-octave" . "8")'
write(11,"(A)") '               ("down-an-octave" . "8")'
write(11,"(A)") '               ("up-two-octaves" . "15")'
write(11,"(A)") '               ("down-two-octaves" . "15")'
write(11,"(A)") '               ("loco" . #f)))'
write(11,"(A,A)") "     (long . ((",'"up-an-octave" . "8va")'
write(11,"(A)") '              ("down-an-octave" . "8va bassa")'
write(11,"(A)") '              ("up-two-octaves" . "15ma")'
write(11,"(A)") '              ("down-two-octaves" . "15ma")'
write(11,"(A)") '              ("loco" , #f)))'
write(11,"(A)") "     (default . #f)))"
write(11,*)
write(11,"(A)") "#(define (make-alternate-name name)"
write(11,"(A)") "   (let* ((ps (make-music"
write(11,"(A)") "               'PropertySet"
write(11,"(A)") "               'symbol 'ottavation"
write(11,"(A)") "               'value name))"
write(11,"(A)") "          (csm (make-music"
write(11,"(A)") "                'ContextSpeccedMusic"
write(11,"(A)") "                'element ps"
write(11,"(A)") "                'context-type 'Staff)))"
write(11,"(A)") "     (list csm)))"
write(11,*)
write(11,"(A)") "#(define (select-name displacement name-style)"
write(11,"(A)") "   (let* ((style (assoc-get name-style naming-options))"
write(11,"(A)") "          (name (if style"
write(11,"(A)") "                    (assoc-get displacement style)"
write(11,"(A)") "                    #f)))"
write(11,"(A)") "     (if name"
write(11,"(A)") "         (make-alternate-name name)"
write(11,"(A)") "         '())))"
write(11,*)
write(11,"(A)") "ottavate = #(define-music-function (parser location upper lower options mus)"
write(11,"(A)") "   (number-pair? number-pair? (list? '()) ly:music?)"
write(11,"(A)") "   (let* ((upper8 (car upper))"
write(11,"(A)") "          (upper15 (cdr upper))"
write(11,"(A)") "          (lower8 (car lower))"
write(11,"(A)") "          (lower15 (cdr lower))"
write(11,"(A)") "          (name-style (assoc-get 'name-style options 'default))"
write(11,"(A)") "          ;; Since clef information is found by scanning the music expression, any clef"
write(11,"(A)") "          ;; change must be within the music expression fed to ottavate.  There is no access"
write(11,"(A)") "          ;; to context properties from within a music function.  User needs to tell"
write(11,"(A)") "          ;; \ottavate the opening clef if it is other than treble and not set within"
write(11,"(A)") "          ;; the music expression on which \ottavate is called."
write(11,"(A)") "          (opening-clef (assoc-get 'opening-clef options 'treble))"
write(11,"(A)") "          (opening-middle-C-pos (assoc-get opening-clef clefs)) "
write(11,"(A)") "          (loco (make-ottava-music 0)))"
write(11,*)     
write(11,"(A)") "     (define (select-displacement-string ledger-count)"
write(11,"(A)") "       (cond" 
write(11,"(A)") "        ((> ledger-count upper15)"
write(11,"(A)") '         "up-two-octaves")'
write(11,"(A)") "        ((>= ledger-count upper8)"
write(11,"(A)") '         "up-an-octave")'
write(11,"(A)") "        ((< ledger-count lower15)"
write(11,"(A)") '         "down-two-octaves")'
write(11,"(A)") "        ((<= ledger-count lower8)"
write(11,"(A)") '         "down-an-octave")'
write(11,"(A)") '        (else "loco")))'
write(11,*)     
write(11,"(A)") "     (define (calc-displacement clef-pos mus-expr)"
write(11,"(A)") "       (cond"
write(11,"(A)") "        ((music-is-of-type? mus-expr 'event-chord)"
write(11,"(A)") "         (let* ((elts (ly:music-property mus-expr 'elements))"
write(11,"(A)") "                (ledger-list"
write(11,"(A)") "                 (map (lambda (e)"
write(11,"(A)") "                        (ledger-line-no clef-pos (ly:music-property e 'pitch)))"
write(11,"(A)") "                   elts))"
write(11,"(A)") "                (lowest (apply min ledger-list))"
write(11,"(A)") "                (highest (apply max ledger-list)))"
write(11,"(A)") "           (cond"
write(11,"(A)") "            ((every positive? ledger-list)"
write(11,"(A)") "             (select-displacement-string lowest))"
write(11,"(A)") "            ((every negative? ledger-list)"
write(11,"(A)") "             (select-displacement-string highest))"
write(11,"(A)") '            (else "loco"))))'
write(11,"(A)") "        ((music-is-of-type? mus-expr 'note-event)"
write(11,"(A)") "         (let* ((pitch (ly:music-property mus-expr 'pitch))"
write(11,"(A)") "                (ledger-count (ledger-line-no clef-pos pitch)))"
write(11,"(A)") "           (select-displacement-string ledger-count)))))"
write(11,*)     
write(11,"(A)") "     (define (build-new-elts mus-expr new-expr prev clef-pos)"
write(11,"(A)") "       (if (null? mus-expr)"
write(11,"(A)") "           new-expr"
write(11,"(A)") "           (begin"
write(11,"(A)") "            (if (music-is-of-type? (car mus-expr) 'context-specification)"
write(11,"(A)") "                (set! clef-pos (find-clefMiddleCPosition (car mus-expr))))"
write(11,"(A)") "            (cond"
write(11,"(A)") "             ;; We do not extend across rests for now."
write(11,"(A)") "             ((music-is-of-type? (car mus-expr) 'rest-event)"
write(11,"(A)") "              (build-new-elts"
write(11,"(A)") "               (cdr mus-expr)"
write(11,"(A)") "               (append"
write(11,"(A)") "                new-expr"
write(11,"(A)") "                loco"
write(11,"(A)") "                (list (car mus-expr)))"
write(11,"(A)") '               "loco" clef-pos))'
write(11,*)             
write(11,"(A)") "             ((or (music-is-of-type? (car mus-expr) 'event-chord)"
write(11,"(A)") "                  (music-is-of-type? (car mus-expr) 'note-event))"
write(11,"(A)") "              (let ((d (calc-displacement clef-pos (car mus-expr))))"
write(11,"(A)") "                (cond"
write(11,"(A)") "                 ((and d (not (string=? d prev)))"
write(11,"(A)") "                  (build-new-elts"
write(11,"(A)") "                   (cdr mus-expr)"
write(11,"(A)") "                   (append"
write(11,"(A)") "                    new-expr"
write(11,"(A)") "                    (select-ottava-music d)"
write(11,"(A)") "                    (select-name d name-style)"
write(11,"(A)") "                    (list (car mus-expr)))"
write(11,"(A)") "                   d clef-pos))"
write(11,"(A)") "                 (else"
write(11,"(A)") "                  (build-new-elts"
write(11,"(A)") "                   (cdr mus-expr)"
write(11,"(A)") "                   (append new-expr (list (car mus-expr)))"
write(11,"(A)") "                   prev clef-pos)))))"
write(11,"(A)") "             ; ew."
write(11,"(A)") "             (else" 
write(11,"(A)") "              (build-new-elts"
write(11,"(A)") "               (cdr mus-expr)"
write(11,"(A)") "               (append new-expr (list (car mus-expr)))"
write(11,"(A)") "               prev clef-pos))))))"
write(11,*)     
write(11,"(A)") "     (define (recurse music)"
write(11,"(A)") "       (let ((elts (ly:music-property music 'elements))"
write(11,"(A)") "             (e (ly:music-property music 'element)))"
write(11,"(A)") "         (if (ly:music? e)"
write(11,"(A)") "             (recurse e))"
write(11,"(A)") "         (if (pair? elts)"
write(11,"(A)") "             (if (or"
write(11,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'note-event)) elts)"
write(11,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'event-chord)) elts)"
write(11,"(A)") "                  (any (lambda (elt) (music-is-of-type? elt 'rest-event)) elts))"
write(11,"(A)") "                 (set! (ly:music-property music 'elements)"
write(11,"(A,A)") "                       (build-new-elts elts '",'() "loco" opening-middle-C-pos))'
write(11,"(A)") "                 (map recurse elts)))))"
write(11,"(A)") "     (recurse mus)"
write(11,"(A)") "     mus))"

end subroutine SNIPPET_OTTAVATE
