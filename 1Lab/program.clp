(deffunction ask-value (?question)
    	(print ?question)
    	(bind ?answer (read))
    	?answer
    	)

(deffunction ask-question (?question $?allowed-values)
    	(print ?question)
    	(bind ?answer (read))
    	(if (lexemep ?answer) 
        	then (bind ?answer (lowcase ?answer))
	    	)
    	(while (not (member$ ?answer ?allowed-values)) do
        	(print ?question)
        	(bind ?answer (read))
        	(if (lexemep ?answer) 
            	then (bind ?answer (lowcase ?answer))
		    	)
	    	)
    	?answer
    	)

(deffunction yes-or-no (?question)
    	(bind ?response (ask-question ?question yes no y n))
    	(if (or (eq ?response yes) (eq ?response y))
        	then yes 
        	else no
	    	)
    	)

; Сколько лет

(defrule question-age
	(not (solution ?))
	(not (age ?))
	=>
	(assert (age (ask-value "How old are you?: ")))
	)

(defrule rule-young
	(not (solution ?))
	(age ?value)
	=>
	(if (< ?value 12)
		then (assert (young yes))
		else (assert (young no))
		)
	)
	

; Для личных нужд

(defrule question-creative-person
    	(not (solution ?))
    	(not (creative-person ?))
    	=>
    	(assert (creative-person (yes-or-no "Are you a creative person?: ")))
    	)		

(defrule question-work-in-animation-industry
	(not (solution ?))
	(not (work-in-animation-industry ?))
	=>
	(assert (work-in-animation-industry (yes-or-no "Do you work in the animation industry?: ")))
	)
	
(defrule rule-for-personal-needs
	(not (solution ?))
	(not (for-personal-needs ?))
	(or
		(creative-person yes)
		(work-in-animation-industry yes)
	)
	=>
	(assert (for-personal-needs yes))
	)

; Нравятся короткоментражные фильмы

(defrule question-little-stories
	(not (solution ?))
	(not (little-stories ?))
	=>
	(assert (little-stories (yes-or-no "Do you like small but exciting stories?: ")))
	)

(defrule question-arthouse-movies
	(not (solution ?))
	(not (arthouse-movies ?))
	=>
	(assert (little-stories (yes-or-no "Do you like arthouse movies?: ")))
	)

(defrule rule-short-films
	(not (solution ?))
	(not (short-films ?))
	(and
		(little-stories yes)
		(arthouse-movies yes)
	)
	=>
	(assert (short-films yes))
	)

; Нравится мультипликация

(defrule rule-animation
	(not (solution ?))
	(not (animation ?))
	(or
		(for-personal-needs yes)
		(short-films yes)
	)
	=>
	(assert (animation yes))
	)

; Мало времени

(defrule question-working-studing
	(not (solution ?))
	(not (working-studing ?))
	=>
	(assert (working-studing (yes-or-no "Do you working/studing?: ")))
	)

(defrule question-family
	(not (solution ?))
	(not (family ?))
	=>
	(assert (family (yes-or-no "Do you have a family?: ")))
	)

(defrule rule-short-time
	(not (solution ?))
	(not (short-time ?))
	(and
		(working-studing yes)
		(family yes)
	)
	=>
	(assert (short-time yes))
	)

; Не любите открытые концовки

(defrule question-delve-deeply
	(not (solution ?))
	(not (delve-deeply ?))
	=>
	(assert (delve-deeply (yes-or-no "Do you delve deeply into the plot?: ")))
	)

(defrule question-divide-view
	(not (solution ?))
	(not (divide-view ?))
	=>
	(assert (divide-view (yes-or-no "Do you like to divide the view into several times?: ")))
	)

(defrule rule-open-ending
	(not (solution ?))
	(not (open-ending ?))
	(or
		(delve-deeply yes)
		(divide-view no)
	)
	=>
	(assert (open-ending no))
	)

; Любите законченность истории

(defrule rule-complete-stories
	(not (solution ?))
	(not (complete-stories ?))
	(or
		(short-time yes)
		(open-ending no)
	)
	=>
	(assert (complete-stories yes))
	)

; Мультфильмы

(defrule cartoons
    	(or 
	    	(and 
		    	(animation yes) 
				(complete-stories yes)
			) 
			(and
	    		(young yes)
				(complete-stories yes)
	    	)
		)
    	(not (solution ?))
    	=>
    	(assert (solution yes))
	(print "Watch cartoons" crlf)
	)

; Нравится развитие персонажей

(defrule question-character-development
	(not (solution ?))
	(not (character-development ?))
	=>
	(assert (character-development (yes-or-no "Do you like to follow the development of characters?: ")))
	)

(defrule question-lot-key-characters
	(not (solution ?))
	(not (lot-key-characters ?))
	=>
	(assert (lot-key-characters (yes-or-no "Do you like it when there are a lot of key characters in the picture?: ")))
	)

(defrule rule-character
	(not (solution ?))
	(not (character ?))
	(and
		(character-development yes)
		(lot-key-characters yes)
	)
	=>
	(assert (character yes))
	)

; Много времени

(defrule rule-lot-time
	(not (solution ?))
	(not (lot-time ?))
	(or
		(working-studing no)
		(family no)
	)
	=>
	(assert (lot-time yes))
	)

; Любите длинные истории

(defrule rule-long-stories
	(not (solution ?))
	(not (long-stories ?))
	(or
		(character yes)
		(lot-time yes)
	)
	=>
	(assert (long-stories yes))
	)

; Мультсериалы

(defrule cartoon-serials
    	(or 
	    	(and 
		    	(animation yes) 
				(long-stories yes)
			) 
			(and
	    		(young yes)
				(long-stories yes)
	    	)
		)
    	(not (solution ?))
    	=>
    	(assert (solution yes))
		(print "Watch cartoon-serials" crlf)
	)

; Импонирует актерское мастерство

(defrule question-evoke-emotions
	(not (solution ?))
	(not (evoke-emotions ?))
	=>
	(assert (evoke-emotions (yes-or-no "Does this actor evoke emotions in you?: ")))
	)

(defrule question-count-films
	(not (solution ?))
	(not (count-films ?))
	=>
	(assert (count-films (ask-value "How many movies have you watched with this actor?: ")))
	)

(defrule rule-lot-films-with-actor
	(not (solution ?))
	(not (lot-films-with-actor ?))
	(count-films ?value)
	=>
	(if (> ?value 2)
		then (assert (lot-films-with-actor yes))
		else (assert (lot-films-with-actor no))
		)
	)
	

(defrule rule-impressed-acting-skills
	(not (solution ?))
	(not (impressed-acting-skills ?))
	(and
		(evoke-emotions yes)
		(lot-films-with-actor yes)
	)
	=>
	(assert (impressed-acting-skills yes))
	)

; Интересная личность

(defrule question-follow-outside
	(not (solution ?))
	(not (follow-outside ?))
	=>
	(assert (follow-outside (yes-or-no "Do you follow the actor outside of the pictures?: ")))
	)

(defrule question-actions-affect
	(not (solution ?))
	(not (actions-affect ?))
	=>
	(assert (actions-affect (yes-or-no "Do the actor's actions affect you?: ")))
	)

(defrule rule-interesting-personality
	(not (solution ?))
	(not (interesting-personality ?))
	(and
		(follow-outside yes)
		(actions-affect yes)
	)
	=>
	(assert (interesting-personality yes))
	)

; Симпатия к актеру

(defrule rule-sympathy-actor
	(not (solution ?))
	(not (sympathy-actor ?))
	(or
		(impressed-acting-skills yes)
		(interesting-personality yes)
	)
	=>
	(assert (sympathy-actor yes))
	)

; Сериалы

(defrule serials
	(or
		(and
			(sympathy-actor yes) 
			(long-stories yes)
		)
		(and
			(young no) 
			(long-stories yes)
		)
	)
    (not (solution ?))
	=>
	(assert (solution yes))
	(print "Watch serials" crlf)
	)

; Стимул к саморазвитию

(defrule question-purpose-in-life
	(not (solution ?))
	(not (purpose-in-life ?))
	=>
	(assert (purpose-in-life (yes-or-no "Do you have a purpose in life?: ")))
	)

(defrule question-devote-time-to-interests
	(not (solution ?))
	(not (devote-time-to-interests ?))
	=>
	(assert (devote-time-to-interests (yes-or-no "Do you like to devote time to your interests?: ")))
	)

(defrule rule-self-development
	(not (solution ?))
	(not (self-development ?))
	(and
		(purpose-in-life yes)
		(devote-time-to-interests yes)
	)
	=>
	(assert (self-development yes))
	)

; Документальные фильмы

(defrule question-documentaries
	(not (solution ?))
	(not (documentaries ?))
	=>
	(assert (documentaries (yes-or-no "Do you like watching documentaries?: ")))
	)

; Просвещение

(defrule rule-education
	(not (solution ?))
	(not (education ?))
	(and
		(self-development yes)
		(documentaries yes)
	)
	=>
	(assert (education yes))
	)

; Фильмы

(defrule films
	(or
		(and
			(complete-stories yes) 
			(education yes)
		)
		(and
			(complete-stories yes) 
			(young no)
		)
	)
	(not (solution ?))
	=>
	(assert (solution yes))
	(print "Watch films" crlf)
	)


