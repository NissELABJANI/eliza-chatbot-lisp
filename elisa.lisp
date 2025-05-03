(defvar *bindings* nil)  


(defun match-eq (pat in)
  "Compare si les deux listes pat et in sont strictement identiques."
  (if (null pat) 
      (null in)  ;; Si pat est vide, in doit aussi être vide pour retourner vrai
      (if (and in (equal (car pat) (car in))) 
          (match-eq (cdr pat) (cdr in))  ;; Vérifie récursivement le reste des listes
          nil)))  ;; Si un élément diffère, retourne nil  


(defun match (pat in)
  "Compare un motif `pat` avec une entrée `in`, gère les jokers `*`, et met à jour `*bindings*`."
  (setq *bindings* nil)  ;; Réinitialisation de *bindings* avant chaque exécution
  (cond
    ((null pat) (null in))  ;; Si le motif est vide, l'entrée doit aussi être vide pour correspondre
    ((eq (car pat) '*)  ;; Si le premier élément est `*`, il peut correspondre à n'importe quel élément
     (or (match (cdr pat) in)  ;; Essaye d'ignorer le `*`
         (and in
              (push (list 'X (car in)) *bindings*)  ;; Stocke la correspondance dans *bindings*
              (match pat (cdr in)))))  ;; Continue avec le reste de l'entrée
    ((and in (equal (car pat) (car in)))  ;; Vérifie l'égalité des éléments actuels
     (match (cdr pat) (cdr in)))
    (t nil)))  ;; Sinon, échec de la correspondance

(defun wildcard (pat in)
  "Gère les jokers `*` en utilisant `match-eq`."
  (if (match-eq (cdr (cdr pat)) in)
      t
      (if (match-eq pat (cdr in))
          t
            nil)))

(defun bind (var value bindings)
  "Ajoute une valeur à une variable dans bindings. Si la variable existe, ajoute la valeur au début de sa liste."
  (cond
    ((null bindings) ;; Si la liste est vide, créer une nouvelle association
     (list (list var value)))
    ((eq (caar bindings) var) ;; Si la variable existe déjà
     (cons (cons var (cons value (cdar bindings))) (cdr bindings)))
    (t ;; Sinon, continuer récursivement
     (cons (car bindings) (bind var value (cdr bindings))))))

(defun lookup (key alist)
  "Retourne la valeur associée à la clé dans une liste d’associations. NIL si la clé n’est pas trouvée."
  (cond
    ((null alist) nil) ; Fin de la liste sans correspondance
    ((eq key (caar alist)) (car alist)) ; Si la clé correspond, retourne la paire (clé . valeur(s))
    (t (lookup key (cdr alist))))) ; Sinon, continue la recherche

(defun subs (lst)
  "Remplace les variables dans la liste `lst` selon les liaisons contenues dans *bindings*."
  (cond
    ((null lst) nil)  ; fin de la liste
    (t
     (let ((found (lookup (car lst) *bindings*)))
       (if found
           (append (cdr found) (subs (cdr lst)))  ; remplace et continue
           (cons (car lst) (subs (cdr lst)))))))) ; garde le mot si pas de correspondance

(defvar *viewpoint* 
  '((I YOU) (YOU I) 
    (MY YOUR) (YOUR MY) 
    (AM ARE) (WAS WERE)))

(defun swap (value)
  "Remplace un mot selon la table *viewpoint*, ou retourne le mot s’il n’est pas trouvé."
  (labels ((swap-rec (val vp)
             (cond
               ((null vp) val)
               ((eq val (caar vp)) (cadar vp))
               ((eq val (cadar vp)) (caar vp))
               (t (swap-rec val (cdr vp))))))
    (swap-rec value *viewpoint*)))

(defun random-elt (lst)
  "Retourne un élément aléatoire de la liste lst."
  (nth (random (length lst)) lst))

(defparameter *rules*
  '(
    ((* x hello * y) ("HELLO. HOW CAN I HELP YOU?"))
    ((* x i want * y) ("WHY DO YOU WANT Y?" "WHAT WOULD IT MEAN IF YOU GOT Y?"))
    ((* x i hate * y) ("WHAT MAKES YOU HATE Y?" "WHY DO YOU FEEL SO STRONGLY ABOUT Y?"))
    ((* x because * y) ("IS THAT THE REAL REASON?" "WHAT OTHER REASONS COME TO MIND?"))
  ))

(defun split-string (str)
  "Découpe une chaîne STR en mots, séparés par des espaces."
  (loop with stream = (make-string-input-stream str)
        for word = (read stream nil nil)
        while word
        collect (string-upcase (string word))))

(defun find-response (input)
  "Parcourt les règles et retourne une réponse adaptée à l'entrée utilisateur."
  (let ((matched-rule
          (find-if
           (lambda (rule)
             (let ((pattern (first rule)))
               (match pattern input))) ; essaie de faire correspondre le motif
           *rules*)))
    (if matched-rule
        (let* ((responses (second matched-rule)) ; récupère les réponses possibles
               (raw-response (random-elt responses)) ; réponse brute avec variables
               (words (subs raw-response)) ; remplace les variables (X, Y, ...)
               (final-response (mapcar #'swap words))) ; ajuste les pronoms
          final-response)
        '("I'M NOT SURE I UNDERSTAND.")))) ; fallback si aucune règle ne correspond

(defun eliza ()
  (format t "~%ELIZA: Bonjour. Parlez-moi.~%")
  (loop
    (format t "~%> ")
    (let* ((input (read-line))
           (words (remove-if #'(lambda (w) (equal w "")) 
                             (split-string input))))
      (if (string= input "bisous")
          (progn (format t "Au revoir.~%") (return))
          (progn
            (let ((response (find-response words)))
              (format t "~%ELIZA: ~{~a~}~%" response)))))))
