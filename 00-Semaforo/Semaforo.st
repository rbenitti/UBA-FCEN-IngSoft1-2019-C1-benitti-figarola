!classDefinition: #LuzDeSemaforo category: #Semaforo!
DenotativeObject subclass: #LuzDeSemaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzDeSemaforo class' category: #Semaforo!
LuzDeSemaforo class
	instanceVariableNames: 'morph'!

!LuzDeSemaforo class methodsFor: 'control' stamp: 'rb 3/26/2019 21:30:43'!
apagar
	self morph color: Color black.
	^self. ! !

!LuzDeSemaforo class methodsFor: 'control' stamp: 'rb 3/26/2019 21:31:05'!
prender
	self morph color: self colorEncendido.
	^self. ! !

!LuzDeSemaforo class methodsFor: 'control' stamp: 'rb 3/27/2019 10:23:32'!
titilar: veces
	veces timesRepeat: [
		self prender.
		(Delay forSeconds: 0.5) wait.
		self apagar.
		]! !


!LuzDeSemaforo class methodsFor: 'UI' stamp: 'rb 3/26/2019 21:31:23'!
colorEncendido
	self childResponsibility .! !

!LuzDeSemaforo class methodsFor: 'UI' stamp: 'rb 3/27/2019 09:53:52'!
initializeMorph
	morph := EllipseMorph new color: self colorEncendido .! !

!LuzDeSemaforo class methodsFor: 'UI' stamp: 'rb 3/26/2019 21:08:41'!
morph
	morph isNil ifTrue: [self initializeMorph].
	
	^morph.! !

!LuzDeSemaforo class methodsFor: 'UI' stamp: 'rb 3/27/2019 09:57:06'!
resetearColaboradores
	morph := nil .
	^self.! !


!LuzDeSemaforo class methodsFor: 'as yet unclassified' stamp: 'rb 3/27/2019 11:14:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzDeAlto category: #Semaforo!
LuzDeSemaforo subclass: #LuzDeAlto
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzDeAlto class' category: #Semaforo!
LuzDeAlto class
	instanceVariableNames: ''!

!LuzDeAlto class methodsFor: 'UI' stamp: 'rb 3/26/2019 21:31:44'!
colorEncendido
	^Color red.! !


!LuzDeAlto class methodsFor: 'as yet unclassified' stamp: 'rb 3/27/2019 11:14:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzDeAvance category: #Semaforo!
LuzDeSemaforo subclass: #LuzDeAvance
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzDeAvance class' category: #Semaforo!
LuzDeAvance class
	instanceVariableNames: ''!

!LuzDeAvance class methodsFor: 'UI' stamp: 'rb 3/26/2019 21:31:55'!
colorEncendido
	^Color green.! !


!LuzDeAvance class methodsFor: 'as yet unclassified' stamp: 'rb 3/27/2019 11:14:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #LuzDeAviso category: #Semaforo!
LuzDeSemaforo subclass: #LuzDeAviso
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'LuzDeAviso class' category: #Semaforo!
LuzDeAviso class
	instanceVariableNames: ''!

!LuzDeAviso class methodsFor: 'UI' stamp: 'rb 3/26/2019 21:32:05'!
colorEncendido
	^Color yellow.! !


!LuzDeAviso class methodsFor: 'as yet unclassified' stamp: 'rb 3/27/2019 11:14:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	morph := nil.! !


!classDefinition: #Semaforo category: #Semaforo!
DenotativeObject subclass: #Semaforo
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Semaforo'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Semaforo class' category: #Semaforo!
Semaforo class
	instanceVariableNames: 'luzDeAlto luzDeAviso luzDeAvance contenedorDeLuces'!

!Semaforo class methodsFor: 'UI' stamp: 'rb 3/27/2019 09:53:04'!
mostrar

	contenedorDeLuces isNil ifTrue: [self inicializarContenedor].

	contenedorDeLuces openInWorld.
	
	^self.! !

!Semaforo class methodsFor: 'UI' stamp: 'rb 3/27/2019 09:53:08'!
ocultar

	contenedorDeLuces isNil ifTrue: [self inicializarContenedor].

	contenedorDeLuces dismissMorph .
	
	^self.! !


!Semaforo class methodsFor: 'control' stamp: 'rb 3/26/2019 21:55:55'!
apagar
	self apagarTodasLasLuces.
	^self.! !

!Semaforo class methodsFor: 'control' stamp: 'rb 3/27/2019 10:22:04'!
iniciarSecuenciaDePrendido
	self apagarTodasLasLuces.
	self luzDeAviso titilar: 1! !

!Semaforo class methodsFor: 'control' stamp: 'rb 3/27/2019 10:20:24'!
prender
	self iniciarSecuenciaDePrendido.! !


!Semaforo class methodsFor: 'private - accesorios para jugar' stamp: 'rb 3/27/2019 09:57:06'!
resetearColaboradores
	contenedorDeLuces isNil ifFalse:  [contenedorDeLuces dismissMorph. contenedorDeLuces := nil].
	
	luzDeAlto isNil ifFalse:  [luzDeAlto resetearColaboradores. luzDeAlto := nil].
	luzDeAviso isNil ifFalse:  [luzDeAviso resetearColaboradores. luzDeAviso := nil].
	luzDeAvance isNil ifFalse:  [luzDeAvance resetearColaboradores. luzDeAvance := nil].
	
	^self! !


!Semaforo class methodsFor: 'private - colaboradores' stamp: 'rb 3/26/2019 22:32:12'!
contenedorDeLuces
	^contenedorDeLuces! !

!Semaforo class methodsFor: 'private - colaboradores' stamp: 'rb 3/26/2019 21:40:23'!
luzDeAlto
	luzDeAlto isNil ifTrue: [self asignarLuzDeAlto].
	^luzDeAlto.
! !

!Semaforo class methodsFor: 'private - colaboradores' stamp: 'rb 3/26/2019 21:44:36'!
luzDeAvance
	luzDeAvance isNil ifTrue: [self asignarLuzDeAvance].
	^luzDeAvance.
! !

!Semaforo class methodsFor: 'private - colaboradores' stamp: 'rb 3/26/2019 21:44:55'!
luzDeAviso
	luzDeAviso isNil ifTrue: [self asignarLuzDeAviso].
	^luzDeAviso.
! !


!Semaforo class methodsFor: 'private - control' stamp: 'rb 3/27/2019 10:18:55'!
apagarTodasLasLuces
	self luzDeAlto apagar.
	self luzDeAviso apagar.
	self luzDeAvance apagar.
	^self.! !


!Semaforo class methodsFor: 'private - inicializacion' stamp: 'rb 3/26/2019 21:40:45'!
asignarLuzDeAlto
	luzDeAlto := LuzDeAlto.
	^self.! !

!Semaforo class methodsFor: 'private - inicializacion' stamp: 'rb 3/26/2019 21:41:10'!
asignarLuzDeAvance
	luzDeAvance := LuzDeAvance.
	^self.! !

!Semaforo class methodsFor: 'private - inicializacion' stamp: 'rb 3/26/2019 22:39:48'!
asignarLuzDeAviso
	luzDeAviso := LuzDeAviso.
	^self.! !

!Semaforo class methodsFor: 'private - inicializacion' stamp: 'rb 3/26/2019 22:20:41'!
inicializarContenedor
	contenedorDeLuces := LayoutMorph newColumn morphExtent: 60 @ 130.
	
	contenedorDeLuces addMorph: self luzDeAlto morph.
	contenedorDeLuces addMorph: self luzDeAviso morph.
	contenedorDeLuces addMorph: self luzDeAvance morph.
	! !


!Semaforo class methodsFor: 'as yet unclassified' stamp: 'rb 3/27/2019 11:14:04'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	luzDeAlto := nil.
	luzDeAviso := nil.
	luzDeAvance := nil.
	contenedorDeLuces := nil.! !

LuzDeSemaforo initializeAfterFileIn!
LuzDeAlto initializeAfterFileIn!
LuzDeAvance initializeAfterFileIn!
LuzDeAviso initializeAfterFileIn!
Semaforo initializeAfterFileIn!