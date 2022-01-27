% HECHOS

hijo("Diana", "Marta").
hijo("May", "Marta").
hijo("Rachel", "Marta").
hijo("Barry", "Marta"). % se asume que Barry es la cuarta hija de Marta

hijo("Diana", "Bruce").
hijo("May", "Bruce").
hijo("Rachel", "Bruce").
hijo("Barry", "Bruce"). % se asume que Barry es la cuarta hija de Bruce

% Diana y Peter
hijo("Mary", "Diana").
hijo("Mary", "Peter").
hijo("Harry", "Diana").
hijo("Harry", "Peter").
% May y Ben
hijo("Ezio", "May").
hijo("Lorenzo", "May").
hijo("Sergio", "May").
hijo("Ezio", "Ben").
hijo("Lorenzo", "Ben").
hijo("Sergio", "Ben").
% Rachel y Enrique
hijo("Clark", "Rachel").
hijo("Lois", "Rachel").
hijo("Clark", "Enrique").
hijo("Lois", "Enrique").
% Barry y Pepper
hijo("Lara", "Pepper").
hijo("Tony", "Pepper").
hijo("Lara", "Barry").
hijo("Tony", "Barry").


% padre Bruce
padre("Bruce","Diana").
padre("Bruce","May").
padre("Bruce","Rachel").
padre("Bruce","Barry").

% padre Peter
padre("Peter", "Mary").
padre("Peter", "Harry").

% padre Ben
padre("Ben", "Ezio").
padre("Ben", "Lorenzo").
padre("Ben", "Sergio").

% padre Enrique
padre("Enrique", "Clark").
padre("Enrique", "Lois").

% padre Barry
padre("Barry", "Lara").
padre("Barry", "Tony").

% madre Marta
madre("Marta", "Diana").
madre("Marta", "May").
madre("Marta", "Rachel").
madre("Marta", "Barry").

% madre Diana
madre("Diana", "Mary").
madre("Diana", "Harry").

% madre May
madre("May", "Ezio").
madre("May", "Lorenzo").
madre("May", "Sergio").

% madre Rachel
madre("Rachel", "Clark").
madre("Rachel", "Lois").

% madre Pepper
madre("Pepper", "Lara").
madre("Pepper", "Tony").


% Diana es hermana de...
hermana("Diana", "May").
hermana("Diana", "Rachel").
hermana("Diana", "Barry").
% May es hermana de...
hermana("May", "Diana").
hermana("May", "Rachel").
hermana("May", "Barry").
% Rachel es hermana de...
hermana("Rachel", "Diana").
hermana("Rachel", "May").
hermana("Rachel", "Barry").
% Mary es hermana de...
hermana("Mary", "Harry").

% Lois es hermana de...
hermana("Lois", "Clark").

% Lara es hermana de...
hermana("Lara", "Tony").

% Barry es hermano de...
hermano("Barry", "Diana").
hermano("Barry", "May").
hermano("Barry", "Rachel").

% Harry es hermano de...
hermano("Harry", "Mary").

% Ezio es hermano de...
hermano("Ezio", "Lorenzo").
hermano("Ezio", "Sergio").

% Lorenzo es hermano de...
hermano("Lorenzo", "Ezio").
hermano("Lorenzo", "Sergio").

% Sergio es hermano de...
hermano("Sergio", "Ezio").
hermano("Sergio", "Lorenzo").

% Clark es hermano de...
hermano("Clark", "Lois").

% Tony es hermano de...
hermano("Tony", "Lara").


pareja("Marta","Bruce").
pareja("Diana", "Peter").
pareja("May","Ben").
pareja("Rachel","Enrique").
pareja("Pepper","Barry").

% REGLAS

son_pareja(X,Y) :-
(
	pareja(X,Y) ;
	pareja(Y,X)
).

es_abuelo(X,Y) :-
	padre(X,Z) ,
	(
		padre(Z,Y) ;
		madre(Z,Y)
	). % Z es el padre de Y

son_hermanos(X,Y) :-
(
	hermano(X,Y) ;
	hermano(Y,X) ;
	hermana(X,X) ;
	hermana(Y,X)
).

es_hermana(X) :-
(
	hermana("Diana", X) ;
	hermana("Marta", X) ;
	hermana("May", X) ;
	hermana("Rachel", X) ;
	hermana("Pepper", X) ;
	hermana("Mary", X) ;
	hermana("Lois", X) ;
	hermana("Lara", X)
).

son_primos(X, Y) :-
(
    (padre(P1, X), padre(P2, Y)) ;
    (madre(P1, X), madre(P2, Y)) ;
    (padre(P1, X), madre(P2, Y)) ;
    (madre(P1, X), padre(P2, Y))

),
(son_hermanos(P1, P2)).

es_hijo(X,Y) :-
(
	hijo(X,Y)
).

es_tio(X,Y) :-
(
    padre(P, Y) ;
    madre(P, Y) % verifica que tenga padre (y determinar quién es)
),
(
	son_hermanos(X, P) ;
	(
		son_pareja(F,X) ,
		son_hermanos(F,P)
	)
).

es_culpable(X) :-
(
	es_hermana(X) ,
	es_abuelo("Bruce", X) ,
	es_tio("Barry", X) ,
	son_primos("Clark", X)
).

imprimir_arbol(P) :- %final
(
	(
		son_pareja(P, P2) ,
		write('[') ,
		write(P) ,
		write('-') ,
		write(P2),
                write("]=>") ,
		es_hijo(H,P) ,
		write(H) ,
                fail ,
                write(',') , nl ,

                imprimir_arbol(H)

	)

).

%es_culpable(X) :- (hermana(MUJER, X)), (padre("Bruce", X),(padre(HOMBRE,X);madre(MUJER,X))),primos("Clark", X), tio("Barry", X).
