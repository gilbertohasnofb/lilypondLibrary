subroutine SNIPPET_SLASHEDGRACES()

write(*,"(A)") "#(define (degrees->radians deg)"
write(*,"(A)") "  (* PI (/ deg 180.0)))"
write(*,*) 
write(*,"(A)") "slash ="
write(*,"(A)") "#(define-music-function (parser location ang stem-fraction protrusion)"
write(*,"(A)") "  (number? number? number?)"
write(*,"(A)") "  (remove-grace-property 'Voice 'Stem 'direction)"
write(*,"(A)") "  #{ "
write(*,"(A)") "    \once \override Stem #'stencil ="
write(*,"(A)") "    #(lambda (grob)"
write(*,"(A)") "      (let* ((x-parent (ly:grob-parent grob X))"
write(*,"(A)") "              (is-rest? (ly:grob? (ly:grob-object x-parent 'rest))))"
write(*,"(A)") "        (if is-rest?"
write(*,"(A)") "            empty-stencil "
write(*,"(A)") "            (let* ((refp (ly:grob-system grob))"
write(*,"(A)") "                    (stem-y-ext (ly:grob-extent grob grob Y)) "
write(*,"(A)") "                    (stem-length (- (cdr stem-y-ext) (car stem-y-ext)))"
write(*,"(A)") "                    (beam (ly:grob-object grob 'beam))"
write(*,"(A)") "                    (beam-X-pos (ly:grob-property beam 'X-positions))"
write(*,"(A)") "                    (beam-Y-pos (ly:grob-property beam 'positions))"
write(*,"(A)") "                    (beam-slope (/ (- (cdr beam-Y-pos) (car beam-Y-pos))"
write(*,"(A)") "                                   (- (cdr beam-X-pos) (car beam-X-pos))))"
write(*,"(A)") "                    (beam-angle (atan beam-slope))"
write(*,"(A)") "                    (dir (ly:grob-property grob 'direction))"
write(*,"(A)") "                    (line-dy (* stem-length stem-fraction))"
write(*,"(A)") "                    (line-dy-with-protrusions (if (= dir 1)"
write(*,"(A)") "                                                  (+ (* 4 protrusion) beam-angle)"
write(*,"(A)") "                                                  (- (* 4 protrusion) beam-angle)))"
write(*,"(A)") "                    (ang (if (> beam-slope 0)"
write(*,"(A)") "                      (if (= dir 1)"
write(*,"(A)") "                        (+ (degrees->radians ang) (* beam-angle 0.7))"
write(*,"(A)") "                        (degrees->radians ang))"
write(*,"(A)") "                      (if (= dir 1)"
write(*,"(A)") "                        (degrees->radians ang)"
write(*,"(A)") "                        (- (degrees->radians ang) (* beam-angle 0.7)))))"
write(*,"(A)") "                    (line-dx (/ line-dy-with-protrusions (tan ang)))"
write(*,"(A)") "                    (protrusion-dx (/ protrusion (tan ang)))"
write(*,"(A)") "                    (corr (if (= dir 1) (car stem-y-ext) (cdr stem-y-ext)))"
write(*,"(A)") "                    (stil (ly:stem::print grob)))"
write(*,"(A)") "             (ly:stencil-add "
write(*,"(A)") "               stil "
write(*,"(A)") "               (grob-interpret-markup grob"
write(*,"(A)") "                 (markup"
write(*,"(A)") "                   ;#:with-color red"
write(*,"(A)") "                   #:translate"
write(*,"(A)") "                     (cons (- protrusion-dx)"
write(*,"(A)") "                            (+ corr"
write(*,"(A)") "                               (* dir"
write(*,"(A)") "                                  (- stem-length (+ stem-fraction protrusion)))))"
write(*,"(A)") "                   #:draw-line"
write(*,"(A)") "                     (cons line-dx"
write(*,"(A)") "                            (* dir line-dy-with-protrusions)))))))))"
write(*,"(A)") "  #})"
write(*,*) 
write(*,"(A)") "startSlashedGraceMusic = {"
write(*,"(A)") "  \slash 40 1 0.5"
write(*,"(A)") '  \override Flag.stroke-style = #"grace"'
write(*,"(A)") "}"
write(*,"(A)") "stopSlashedGraceMusic = {"
write(*,"(A)") "  \revert Flag.stroke-style"
write(*,"(A)") "}"
write(*,*) 
write(*,"(A)") "startAcciaccaturaMusic = {"
write(*,"(A)") "  \slash 40 1 0.5"
write(*,"(A)") "  s1*0("
write(*,"(A)") '  \override Flag.stroke-style = #"grace"'
write(*,"(A)") "}"
write(*,"(A)") "stopAcciaccaturaMusic = {"
write(*,"(A)") "  \revert Flag.stroke-style"
write(*,"(A)") "  s1*0)"
write(*,"(A)") "}"

write(11,"(A)") "#(define (degrees->radians deg)"
write(11,"(A)") "  (* PI (/ deg 180.0)))"
write(11,*) 
write(11,"(A)") "slash ="
write(11,"(A)") "#(define-music-function (parser location ang stem-fraction protrusion)"
write(11,"(A)") "  (number? number? number?)"
write(11,"(A)") "  (remove-grace-property 'Voice 'Stem 'direction)"
write(11,"(A)") "  #{ "
write(11,"(A)") "    \once \override Stem #'stencil ="
write(11,"(A)") "    #(lambda (grob)"
write(11,"(A)") "      (let* ((x-parent (ly:grob-parent grob X))"
write(11,"(A)") "              (is-rest? (ly:grob? (ly:grob-object x-parent 'rest))))"
write(11,"(A)") "        (if is-rest?"
write(11,"(A)") "            empty-stencil "
write(11,"(A)") "            (let* ((refp (ly:grob-system grob))"
write(11,"(A)") "                    (stem-y-ext (ly:grob-extent grob grob Y)) "
write(11,"(A)") "                    (stem-length (- (cdr stem-y-ext) (car stem-y-ext)))"
write(11,"(A)") "                    (beam (ly:grob-object grob 'beam))"
write(11,"(A)") "                    (beam-X-pos (ly:grob-property beam 'X-positions))"
write(11,"(A)") "                    (beam-Y-pos (ly:grob-property beam 'positions))"
write(11,"(A)") "                    (beam-slope (/ (- (cdr beam-Y-pos) (car beam-Y-pos))"
write(11,"(A)") "                                   (- (cdr beam-X-pos) (car beam-X-pos))))"
write(11,"(A)") "                    (beam-angle (atan beam-slope))"
write(11,"(A)") "                    (dir (ly:grob-property grob 'direction))"
write(11,"(A)") "                    (line-dy (* stem-length stem-fraction))"
write(11,"(A)") "                    (line-dy-with-protrusions (if (= dir 1)"
write(11,"(A)") "                                                  (+ (* 4 protrusion) beam-angle)"
write(11,"(A)") "                                                  (- (* 4 protrusion) beam-angle)))"
write(11,"(A)") "                    (ang (if (> beam-slope 0)"
write(11,"(A)") "                      (if (= dir 1)"
write(11,"(A)") "                        (+ (degrees->radians ang) (* beam-angle 0.7))"
write(11,"(A)") "                        (degrees->radians ang))"
write(11,"(A)") "                      (if (= dir 1)"
write(11,"(A)") "                        (degrees->radians ang)"
write(11,"(A)") "                        (- (degrees->radians ang) (* beam-angle 0.7)))))"
write(11,"(A)") "                    (line-dx (/ line-dy-with-protrusions (tan ang)))"
write(11,"(A)") "                    (protrusion-dx (/ protrusion (tan ang)))"
write(11,"(A)") "                    (corr (if (= dir 1) (car stem-y-ext) (cdr stem-y-ext)))"
write(11,"(A)") "                    (stil (ly:stem::print grob)))"
write(11,"(A)") "             (ly:stencil-add "
write(11,"(A)") "               stil "
write(11,"(A)") "               (grob-interpret-markup grob"
write(11,"(A)") "                 (markup"
write(11,"(A)") "                   ;#:with-color red"
write(11,"(A)") "                   #:translate"
write(11,"(A)") "                     (cons (- protrusion-dx)"
write(11,"(A)") "                            (+ corr"
write(11,"(A)") "                               (* dir"
write(11,"(A)") "                                  (- stem-length (+ stem-fraction protrusion)))))"
write(11,"(A)") "                   #:draw-line"
write(11,"(A)") "                     (cons line-dx"
write(11,"(A)") "                            (* dir line-dy-with-protrusions)))))))))"
write(11,"(A)") "  #})"
write(11,*) 
write(11,"(A)") "startSlashedGraceMusic = {"
write(11,"(A)") "  \slash 40 1 0.5"
write(11,"(A)") '  \override Flag.stroke-style = #"grace"'
write(11,"(A)") "}"
write(11,"(A)") "stopSlashedGraceMusic = {"
write(11,"(A)") "  \revert Flag.stroke-style"
write(11,"(A)") "}"
write(11,*) 
write(11,"(A)") "startAcciaccaturaMusic = {"
write(11,"(A)") "  \slash 40 1 0.5"
write(11,"(A)") "  s1*0("
write(11,"(A)") '  \override Flag.stroke-style = #"grace"'
write(11,"(A)") "}"
write(11,"(A)") "stopAcciaccaturaMusic = {"
write(11,"(A)") "  \revert Flag.stroke-style"
write(11,"(A)") "  s1*0)"
write(11,"(A)") "}"

end subroutine SNIPPET_SLASHEDGRACES
