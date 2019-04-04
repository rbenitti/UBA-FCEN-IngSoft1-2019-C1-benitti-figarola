!classDefinition: #I category: #'Numeros De Peano'!
DenotativeObject subclass: #I
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'I class' category: #'Numeros De Peano'!
I class
	instanceVariableNames: 'next'!

!I class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:42:21'!
SubtractTo: unMinuendo

	^unMinuendo previous

	! !

!I class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:42:35'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^self descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural 
	! !

!I class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:42:42'!
descripcionDeErrorDeNumerosNegativosNoSoportados
	^'No se admiten numeros negativos ni el cero. Solo se admiten numeros naturales'! !

!I class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:42:50'!
descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural
	^'Solo se admite divisiones con resultado natural'! !

!I class methodsFor: 'ParaImplementacion' stamp: 'ARM 3/28/2019 17:40:14'!
next

	^next! !

!I class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:43:01'!
previous

	self error: 'El I no tiene previo'! !


!I class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:40:34'!
* unFactor

	^unFactor
	! !

!I class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:40:44'!
+ unSumando

	^unSumando next

	! !

!I class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:41:58'!
- unSustraendo

	self error: self descripcionDeErrorDeNumerosNegativosNoSoportados

	! !

!I class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:41:34'!
/ unDivisor
	
	unDivisor = self ifTrue: [^self].
	self error: self descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural

	! !

!I class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:42:12'!
< unNumeroDePeano
	
	^(unNumeroDePeano = I) not

	! !


!I class methodsFor: 'as yet unclassified' stamp: 'Lucas 3/31/2019 16:54:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := II.! !


!classDefinition: #II category: #'Numeros De Peano'!
DenotativeObject subclass: #II
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numeros De Peano'!

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'II class' category: #'Numeros De Peano'!
II class
	instanceVariableNames: 'next previous'!

!II class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:47:01'!
* unFactor

	^self previous * unFactor + unFactor! !

!II class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:47:14'!
+ unSumando

	^self previous + unSumando next! !

!II class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:47:26'!
- unSustraendo
	
	^unSustraendo SubtractTo: self! !

!II class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:50:47'!
/ unDivisor

	self < unDivisor ifTrue:[self error: self descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural].	
	unDivisor = I ifTrue: [^self].
	self = unDivisor ifTrue: [^I].
	^((self - unDivisor) / unDivisor) next

	

	! !

!II class methodsFor: 'operadores' stamp: 'Lucas 3/31/2019 16:48:08'!
< unNumeroDePeano
	
	unNumeroDePeano = I ifTrue: [^false].
	^self previous < unNumeroDePeano previous
	

	! !


!II class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:49:59'!
SubtractTo: unMinuendo

	"este objeto es el sustraendo de una resta. Realizar la operacion unMinuendo - self"
	^unMinuendo previous - self previous! !

!II class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:50:10'!
descripcionDeErrorDeNoSePuedeDividirPorUnNumeroMayor
	^self descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural ! !

!II class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:50:17'!
descripcionDeErrorSoloSeAdmiteDivisionConResultadoNatural
	^'Solo se admite divisiones con resultado natural'! !

!II class methodsFor: 'ParaImplementacion' stamp: 'ARM 3/28/2019 18:07:16'!
next

	next ifNil:
	[
		next _ self cloneNamed: (self name , 'I').
		next previous: self.
	].
	^next! !

!II class methodsFor: 'ParaImplementacion' stamp: 'ARM 3/28/2019 18:01:40'!
previous
	^previous! !

!II class methodsFor: 'ParaImplementacion' stamp: 'Lucas 3/31/2019 16:49:20'!
previous: unNumeroDePeano

	previous _ unNumeroDePeano! !

!II class methodsFor: 'ParaImplementacion' stamp: 'ARM 3/28/2019 18:06:24'!
removeAllNext

	next ifNotNil:
	[
		next removeAllNext.
		next removeFromSystem.
		next := nil.
	]! !


!II class methodsFor: 'as yet unclassified' stamp: 'Lucas 3/31/2019 16:54:37'!
initializeCollaboratorsFromFile
	"Auto generated method for loading purposes - Do not modify it"

	next := nil.
	previous := I.! !

I initializeAfterFileIn!
II initializeAfterFileIn!