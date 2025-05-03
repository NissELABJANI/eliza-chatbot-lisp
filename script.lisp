;;; Fichier : script.lisp
;;; Script pour charger et exécuter ELIZA

(load "elisa.lisp") ;; Charger les définitions
(setf *random-state* (make-random-state t))


(format t "~%Test 1: (match-eq '(i feel happy) '(i feel happy))~%")
(format t "Résultat: ~a~%" (match-eq '(i feel happy) '(i feel happy)))

(format t "~%Test 2: (match-eq '(i feel sad) '(i feel happy))~%")
(format t "Résultat: ~a~%" (match-eq '(i feel sad) '(i feel happy)))

(format t "~%Test 3: (match '(i feel *) '(i feel happy))~%")
(format t "Résultat: ~a~%" (match '(i feel *) '(i feel happy)))
(format t "Bindings: ~a~%" *bindings*)


(format t "~%Test 4: (wildcard '(* x i hate * y) '(sometimes i hate my job))~%")
(format t "Résultat: ~a~%" (wildcard '(* x i hate * y) '(sometimes i hate my job)))
(format t "Bindings: ~a~%" *bindings*)

(format t "~%Test 5: (bind 'x 'cat '((x dog) (y sheep)))~%")
(let ((result (bind 'x 'cat '((x dog) (y sheep)))))
  (format t "Résultat: ~a~%" result))

(format t "~%Test 6: lookup dans *bindings*~%")
(setq *bindings* '((x dogs) (y cats and sheep)))

(format t "Bindings actuels: ~a~%" *bindings*)

(format t "lookup 'x → ~a~%" (lookup 'x *bindings*))
(format t "lookup 'y → ~a~%" (lookup 'y *bindings*))
(format t "lookup 'z → ~a~%" (lookup 'z *bindings*))

(format t "~%Test 7: subs avec *bindings*~%")
(setq *bindings* '((x dogs) (y cats and sheep)))

(format t "Phrase initiale: '(I think y are chased by x)~%")
(format t "Résultat: ~a~%" (subs '(I think y are chased by x)))

(format t "~%Test 8: Fonction swap~%")
(format t "swap 'i → ~a~%" (swap 'i))
(format t "swap 'my → ~a~%" (swap 'my))
(format t "swap 'was → ~a~%" (swap 'was))
(format t "swap 'computer → ~a~%" (swap 'computer)) 

(format t "~%Test 9: Fonction random-elt~%")
(format t "Liste 1: (yes no maybe) → ~a~%" (random-elt '(yes no maybe)))
(format t "Liste 2: (\"Tell me more.\" \"Why do you think so?\") → ~a~%" 
        (random-elt '("Tell me more." "Why do you think so?")))

(format t "~%Démarrage de la session ELIZA... Tapez 'bisous' pour quitter.~%")
(eliza)
