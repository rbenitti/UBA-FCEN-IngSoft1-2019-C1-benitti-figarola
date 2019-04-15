!classDefinition: #NumeroTest category: #'Numero-Exercise'!
TestCase subclass: #NumeroTest
	instanceVariableNames: 'zero one two four oneFifth oneHalf five twoFifth twoTwentyfifth fiveHalfs three eight negativeOne negativeTwo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:11'!
test01isCeroReturnsTrueWhenAskToZero

	self assert: zero isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:12'!
test02isCeroReturnsFalseWhenAskToOthersButZero

	self deny: one isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test03isOneReturnsTrueWhenAskToOne

	self assert: one isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:13'!
test04isOneReturnsFalseWhenAskToOtherThanOne

	self deny: zero isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:14'!
test05EnteroAddsWithEnteroCorrectly

	self assert: one + one equals: two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:18'!
test06EnteroMultipliesWithEnteroCorrectly

	self assert: two * two equals: four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:20'!
test07EnteroDividesEnteroCorrectly

	self assert: two / two equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:38'!
test08FraccionAddsWithFraccionCorrectly
"
    La suma de fracciones es:
	 
	a/b + c/d = (a.d + c.b) / (b.d)
	 
	SI ESTAN PENSANDO EN LA REDUCCION DE FRACCIONES NO SE PREOCUPEN!!
	TODAVIA NO SE ESTA TESTEANDO ESE CASO
"
	| sevenTenths |

	sevenTenths := (Entero with: 7) / (Entero with: 10).

	self assert: oneFifth + oneHalf equals: sevenTenths! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:52'!
test09FraccionMultipliesWithFraccionCorrectly
"
    La multiplicacion de fracciones es:
	 
	(a/b) * (c/d) = (a.c) / (b.d)
"

	self assert: oneFifth * twoFifth equals: twoTwentyfifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 20:56'!
test10FraccionDividesFraccionCorrectly
"
    La division de fracciones es:
	 
	(a/b) / (c/d) = (a.d) / (b.c)
"

	self assert: oneHalf / oneFifth equals: fiveHalfs! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test11EnteroAddsFraccionCorrectly
"
	Ahora empieza la diversion!!
"

	self assert: one + oneFifth equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:07'!
test12FraccionAddsEnteroCorrectly

	self assert: oneFifth + one equals: (Entero with: 6) / (Entero with: 5)! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:50'!
test13EnteroMultipliesFraccionCorrectly

	self assert: two * oneFifth equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:52'!
test14FraccionMultipliesEnteroCorrectly

	self assert: oneFifth * two equals: twoFifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:57'!
test15EnteroDividesFraccionCorrectly

	self assert: one / twoFifth equals: fiveHalfs  ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 21:59'!
test16FraccionDividesEnteroCorrectly

	self assert: twoFifth / five equals: twoTwentyfifth ! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:38'!
test17AFraccionCanBeEqualToAnEntero

	self assert: two equals: four / two! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:39'!
test18AparentFraccionesAreEqual

	self assert: oneHalf equals: two / four! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:40'!
test19AddingFraccionesCanReturnAnEntero

	self assert: oneHalf + oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test20MultiplyingFraccionesCanReturnAnEntero

	self assert: (two/five) * (five/two) equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:42'!
test21DividingFraccionesCanReturnAnEntero

	self assert: oneHalf / oneHalf equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:43'!
test22DividingEnterosCanReturnAFraccion

	self assert: two / four equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test23CanNotDivideEnteroByZero

	self 
		should: [ one / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:46'!
test24CanNotDivideFraccionByZero

	self 
		should: [ oneHalf / zero ]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Numero canNotDivideByZeroErrorDescription ]
	! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test25AFraccionCanNotBeZero

	self deny: oneHalf isZero! !

!NumeroTest methodsFor: 'tests' stamp: 'HernanWilkinson 5/7/2016 22:50'!
test26AFraccionCanNotBeOne

	self deny: oneHalf isOne! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:26'!
test27EnteroSubstractsEnteroCorrectly

	self assert: two - one equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:47:41'!
test28FraccionSubstractsFraccionCorrectly
	
	self assert: twoFifth - oneFifth equals: oneFifth.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:00'!
test29EnteroSubstractsFraccionCorrectly

	self assert: one - oneHalf equals: oneHalf! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:05'!
test30FraccionSubstractsEnteroCorrectly

	| sixFifth |
	
	sixFifth := (Entero with: 6) / (Entero with: 5).
	
	self assert: sixFifth - one equals: oneFifth! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:08'!
test31SubstractingFraccionesCanReturnAnEntero

	| threeHalfs |
	
	threeHalfs := (Entero with: 3) / (Entero with: 2).
	
	self assert: threeHalfs - oneHalf equals: one.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:48:48'!
test32SubstractingSameEnterosReturnsZero

	self assert: one - one equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:01'!
test33SubstractingSameFraccionesReturnsZero

	self assert: oneHalf - oneHalf equals: zero.! !

!NumeroTest methodsFor: 'tests' stamp: 'HAW 9/24/2018 08:48:14'!
test34SubstractingAHigherValueToANumberReturnsANegativeNumber

	| negativeThreeHalfs |
	
	negativeThreeHalfs := (Entero with: -3) / (Entero with: 2).	

	self assert: one - fiveHalfs equals: negativeThreeHalfs.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:23'!
test35FibonacciZeroIsOne

	self assert: zero fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:32'!
test36FibonacciOneIsOne

	self assert: one fibonacci equals: one! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:39'!
test37FibonacciEnteroReturnsAddingPreviousTwoFibonacciEnteros

	self assert: four fibonacci equals: five.
	self assert: three fibonacci equals: three. 
	self assert: five fibonacci equals: four fibonacci + three fibonacci.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:47'!
test38FibonacciNotDefinedForNegativeNumbers

	self 
		should: [negativeOne fibonacci]
		raise: Error
		withExceptionDo: [ :anError | self assert: anError messageText equals: Entero negativeFibonacciErrorDescription ].! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:49:55'!
test39NegationOfEnteroIsCorrect

	self assert: two negated equals: negativeTwo.
		! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:03'!
test40NegationOfFraccionIsCorrect

	self assert: oneHalf negated equals: negativeOne / two.! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:11'!
test41SignIsCorrectlyAssignedToFractionWithTwoNegatives

	self assert: oneHalf equals: (negativeOne / negativeTwo)! !

!NumeroTest methodsFor: 'tests' stamp: 'NR 9/23/2018 23:50:17'!
test42SignIsCorrectlyAssignedToFractionWithNegativeDivisor

	self assert: oneHalf negated equals: (one / negativeTwo)! !


!NumeroTest methodsFor: 'setup' stamp: 'NR 9/23/2018 23:46:28'!
setUp

	zero := Entero with: 0.
	one := Entero with: 1.
	two := Entero with: 2.
	three:= Entero with: 3.
	four := Entero with: 4.
	five := Entero with: 5.
	eight := Entero with: 8.
	negativeOne := Entero with: -1.
	negativeTwo := Entero with: -2.
	
	oneHalf := one / two.
	oneFifth := one / five.
	twoFifth := two / five.
	twoTwentyfifth := two / (Entero with: 25).
	fiveHalfs := five / two.
	! !


!classDefinition: #Numero category: #'Numero-Exercise'!
Object subclass: #Numero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
* aMultiplier

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
+ anAdder

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 22:21:28'!
- aSubtrahend

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:49'!
/ aDivisor

	self subclassResponsibility ! !

!Numero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 22:48'!
invalidNumberType

	self error: self class invalidNumberTypeErrorDescription! !

!Numero methodsFor: 'arithmetic operations' stamp: 'NR 9/23/2018 23:37:13'!
negated
	
	^self * (Entero with: -1)! !


!Numero methodsFor: 'testing' stamp: 'NR 9/23/2018 23:36:49'!
isNegative

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isOne

	self subclassResponsibility ! !

!Numero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:49'!
isZero

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Numero class' category: #'Numero-Exercise'!
Numero class
	instanceVariableNames: ''!

!Numero class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2016 22:45'!
canNotDivideByZeroErrorDescription

	^'No se puede dividir por cero'! !

!Numero class methodsFor: 'error descriptions' stamp: 'NR 4/8/2019 02:58:13'!
invalidNumberTypeErrorDescription
	^ 'Tipo de número inválido'! !


!classDefinition: #Entero category: #'Numero-Exercise'!
Numero subclass: #Entero
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Entero methodsFor: 'arithmetic operations - private' stamp: 'Lucas 4/15/2019 14:45:38'!
dividirALaFraccion: aFraccionDividend

	^Fraccion with: aFraccionDividend numerator over: aFraccionDividend denominator * self value! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:45:17'!
dividirAlEntero: aEnteroDividend
	
	^Fraccion with: aEnteroDividend over: self! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:52:28'!
multiplicarConElEntero: anEnteroMultiplier 
	
	^self class with: value * anEnteroMultiplier integerValue! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:51:48'!
multiplicarConLaFraccion:  aFraccionMultiplier 
	
	^self * aFraccionMultiplier.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'Lucas 4/15/2019 14:44:50'!
restarALaFraccion: aFraccionMinuend 

	^Fraccion with: aFraccionMinuend numerator - (aFraccionMinuend denominator * self ) over: aFraccionMinuend denominator
	! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:52:14'!
restarAlEntero: aEnteroMinuend
	
	^ self class with: aEnteroMinuend integerValue - value! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:53:29'!
sumarALaFraccion: aFraccionAdder 
	
	^self + aFraccionAdder.! !

!Entero methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:53:18'!
sumarAlEntero: anEnteroAdder
	
	^self class with: (value + anEnteroAdder integerValue)
! !


!Entero methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:51:33'!
* aMultiplier 
	
	^aMultiplier multiplicarConElEntero: self
	! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:53:55'!
+ anAdder 
	
	^anAdder sumarAlEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:47:43'!
- aSubtrahend 
	
	^aSubtrahend  restarAlEntero: self.! !

!Entero methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:46:17'!
/ aDivisor 

	^aDivisor dividirAlEntero: self.
! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:55'!
// aDivisor 
	
	^self class with: value // aDivisor integerValue! !

!Entero methodsFor: 'arithmetic operations' stamp: 'Lucas 4/14/2019 17:15:48'!
fibonacci

	self subclassResponsibility 

		! !

!Entero methodsFor: 'arithmetic operations' stamp: 'HernanWilkinson 5/7/2016 21:00'!
greatestCommonDivisorWith: anEntero 
	
	^self class with: (value gcd: anEntero integerValue)! !


!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 21:01'!
= anObject

	^(anObject isKindOf: self class) and: [ value = anObject integerValue ]! !

!Entero methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:17'!
hash

	^value hash! !


!Entero methodsFor: 'initialization' stamp: 'HernanWilkinson 5/7/2016 20:09'!
initalizeWith: aValue 
	
	value := aValue! !


!Entero methodsFor: 'value' stamp: 'HernanWilkinson 5/7/2016 21:02'!
integerValue

	"Usamos integerValue en vez de value para que no haya problemas con el mensaje value implementado en Object - Hernan"
	
	^value! !


!Entero methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:53:19'!
printOn: aStream

	aStream print: value ! !


!Entero methodsFor: 'testing' stamp: 'Lucas 4/11/2019 20:26:57'!
isEntero

	^true ! !

!Entero methodsFor: 'testing' stamp: 'NR 9/23/2018 22:17:55'!
isNegative
	
	^value < 0! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:14'!
isOne
	
	^value = 1! !

!Entero methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 20:12'!
isZero
	
	^value = 0! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Entero class' category: #'Numero-Exercise'!
Entero class
	instanceVariableNames: ''!

!Entero class methodsFor: 'instance creation' stamp: 'Lucas 4/14/2019 17:09:25'!
isFor: aValue

	^self subclassResponsibility ! !

!Entero class methodsFor: 'instance creation' stamp: 'NR 4/8/2019 02:57:57'!
negativeFibonacciErrorDescription
	^ ' Fibonacci no está definido aquí para Enteros Negativos'! !

!Entero class methodsFor: 'instance creation' stamp: 'Lucas 4/14/2019 17:18:26'!
with: aValue 

	| enteroClass |
	
	enteroClass := Entero subclasses detect: [:anEnteroClass | anEnteroClass isFor: aValue] ifNone: [self error: 'aValue debe ser anInteger'].
	
	^enteroClass new initalizeWith: aValue! !


!classDefinition: #Negative category: #'Numero-Exercise'!
Entero subclass: #Negative
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Negative methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:13:33'!
fibonacci

	self error: Entero negativeFibonacciErrorDescription	
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Negative class' category: #'Numero-Exercise'!
Negative class
	instanceVariableNames: ''!

!Negative class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:17:55'!
isFor: aValue

	^aValue isInteger and: [aValue < 0]! !


!classDefinition: #One category: #'Numero-Exercise'!
Entero subclass: #One
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!One methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:14:47'!
fibonacci

	| one |
	
	one := Entero with: 1.
	
	^one! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'One class' category: #'Numero-Exercise'!
One class
	instanceVariableNames: ''!

!One class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:17:45'!
isFor: aValue

	^aValue isInteger and: [aValue = 1]! !


!classDefinition: #PostiveLargerThanOne category: #'Numero-Exercise'!
Entero subclass: #PostiveLargerThanOne
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PostiveLargerThanOne methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:15:15'!
fibonacci

	| one two |
	
	one := Entero with: 1.
	two := Entero with: 2.
	
	^ (self - one) fibonacci + (self - two) fibonacci
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PostiveLargerThanOne class' category: #'Numero-Exercise'!
PostiveLargerThanOne class
	instanceVariableNames: ''!

!PostiveLargerThanOne class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:18:04'!
isFor: aValue

	^aValue isInteger and: [aValue > 1]! !


!classDefinition: #Zero category: #'Numero-Exercise'!
Entero subclass: #Zero
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Zero methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:14:23'!
fibonacci

	| one |
	
	one := Entero with: 1.
	
	^one

	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Zero class' category: #'Numero-Exercise'!
Zero class
	instanceVariableNames: ''!

!Zero class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/14/2019 17:17:22'!
isFor: aValue

	^aValue isInteger and: [aValue = 0]! !


!classDefinition: #Fraccion category: #'Numero-Exercise'!
Numero subclass: #Fraccion
	instanceVariableNames: 'numerator denominator'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:46:33'!
dividirALaFraccion: aFraccionDividend

	^ (denominator * aFraccionDividend numerator) / (numerator * aFraccionDividend denominator)
! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'Lucas 4/15/2019 14:48:27'!
dividirAlEntero: aEnteroDividend

	^Fraccion with: aEnteroDividend * denominator over: numerator
! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:50:41'!
multiplicarConElEntero: anEnteroMultiplier 
	
	^anEnteroMultiplier * numerator / denominator
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'Lucas 4/15/2019 14:46:24'!
multiplicarConLaFraccion:  aFraccionMultiplier 
	
	^(numerator * aFraccionMultiplier numerator) / (denominator * aFraccionMultiplier denominator)! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:48:54'!
restarALaFraccion: aFraccionMinuend
	
	| newNumerator newDenominator |
	
	newNumerator := (denominator * aFraccionMinuend numerator) - (numerator * aFraccionMinuend denominator).
	newDenominator := denominator * aFraccionMinuend denominator.
	
	^newNumerator / newDenominator ! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'Lucas 4/15/2019 14:47:40'!
restarAlEntero: aEnteroMinuend 

	^self denominator * aEnteroMinuend - self numerator / self denominator
! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:49:33'!
sumarALaFraccion: aFraccionAdder
	
	
	| newNumerator newDenominator |
		
	newNumerator := (aFraccionAdder denominator * numerator) + (aFraccionAdder numerator * denominator).
	newDenominator := aFraccionAdder denominator * denominator.
	
	^newNumerator / newDenominator
							
					
	! !

!Fraccion methodsFor: 'arithmetic operations - private' stamp: 'rb 4/13/2019 11:49:21'!
sumarAlEntero: anNumeroEntero
	
	^((anNumeroEntero * denominator) + numerator) / denominator.
	
					
	! !


!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:51:48'!
* aMultiplier 
	
	^aMultiplier multiplicarConLaFraccion: self.
! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:54:12'!
+ anAdder 
	
	^anAdder sumarALaFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:53:00'!
- aSubtrahend 
	
	^aSubtrahend  restarALaFraccion: self.! !

!Fraccion methodsFor: 'arithmetic operations' stamp: 'rb 4/13/2019 11:54:17'!
/ aDivisor 
	
	^aDivisor dividirALaFraccion: self.! !


!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:42'!
= anObject

	^(anObject isKindOf: self class) and: [ (numerator * anObject denominator) = (denominator * anObject numerator) ]! !

!Fraccion methodsFor: 'comparing' stamp: 'HernanWilkinson 5/7/2016 20:50'!
hash

	^(numerator hash / denominator hash) hash! !


!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
denominator

	^ denominator! !

!Fraccion methodsFor: 'accessing' stamp: 'HernanWilkinson 5/7/2016 21:56'!
numerator

	^ numerator! !


!Fraccion methodsFor: 'initialization' stamp: 'Lucas 4/15/2019 14:24:48'!
initializeWith: aDividend and: aDivisor
	
	^self subclassResponsibility ! !


!Fraccion methodsFor: 'testing' stamp: 'Lucas 4/11/2019 20:27:23'!
isEntero

	^false! !

!Fraccion methodsFor: 'testing' stamp: 'NR 9/23/2018 23:41:38'!
isNegative
	
	^numerator < 0! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isOne
	
	^false! !

!Fraccion methodsFor: 'testing' stamp: 'HernanWilkinson 5/7/2016 22:51'!
isZero
	
	^false! !


!Fraccion methodsFor: 'printing' stamp: 'HAW 9/24/2018 08:54:46'!
printOn: aStream

	aStream 
		print: numerator;
		nextPut: $/;
		print: denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Fraccion class' category: #'Numero-Exercise'!
Fraccion class
	instanceVariableNames: ''!

!Fraccion class methodsFor: 'intance creation' stamp: 'Lucas 4/15/2019 14:12:35'!
isFor: aDividend and: aDivisor

	^self subclassResponsibility 
	! !

!Fraccion class methodsFor: 'intance creation' stamp: 'Lucas 4/15/2019 14:22:41'!
with: aDividend over: aDivisor

	| greatestCommonDivisor numerator denominator fraccionClass |

	
	fraccionClass := Fraccion subclasses detect: [:anFraccionClass | anFraccionClass isFor: aDividend and: aDivisor].
	
	^fraccionClass new initializeWith: aDividend and: aDivisor

	
	"
	aDivisor isZero ifTrue: [ self error: self canNotDivideByZeroErrorDescription ].
	aDividend isZero ifTrue: [ ^aDividend ].
	
	aDivisor isNegative ifTrue:[ ^aDividend negated / aDivisor negated].
	
	
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].
	"

	
	! !


!classDefinition: #NegativeDivisor category: #'Numero-Exercise'!
Fraccion subclass: #NegativeDivisor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!NegativeDivisor methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:26:52'!
initializeWith: aDividend and: aDivisor

	^aDividend negated / aDivisor negated! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'NegativeDivisor class' category: #'Numero-Exercise'!
NegativeDivisor class
	instanceVariableNames: ''!

!NegativeDivisor class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:31:41'!
isFor: aDividend and: aDivisor

	^aDivisor isNegative! !


!classDefinition: #PositiveDivisorNonZeroDividend category: #'Numero-Exercise'!
Fraccion subclass: #PositiveDivisorNonZeroDividend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!PositiveDivisorNonZeroDividend methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:28:16'!
initializeWith: aDividend and: aDivisor

	| greatestCommonDivisor |
	greatestCommonDivisor := aDividend greatestCommonDivisorWith: aDivisor. 
	numerator := aDividend // greatestCommonDivisor.
	denominator := aDivisor // greatestCommonDivisor.
	
	denominator isOne ifTrue: [ ^numerator ].
	
	numerator := numerator.
	denominator := denominator ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PositiveDivisorNonZeroDividend class' category: #'Numero-Exercise'!
PositiveDivisorNonZeroDividend class
	instanceVariableNames: ''!

!PositiveDivisorNonZeroDividend class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:32:57'!
isFor: aDividend and: aDivisor

	^(aDivisor isNegative not) and: [aDivisor isZero not]! !


!classDefinition: #ZeroDividend category: #'Numero-Exercise'!
Fraccion subclass: #ZeroDividend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!ZeroDividend methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:26:23'!
initializeWith: aDividend and: aDivisor

	^aDividend
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZeroDividend class' category: #'Numero-Exercise'!
ZeroDividend class
	instanceVariableNames: ''!

!ZeroDividend class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:31:17'!
isFor: aDividend and: aDivisor

	^aDividend isZero and: [aDivisor isZero not].! !


!classDefinition: #ZeroDivisor category: #'Numero-Exercise'!
Fraccion subclass: #ZeroDivisor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Numero-Exercise'!

!ZeroDivisor methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:38:46'!
initializeWith: aDividend and: aDivisor

	^self error: self class canNotDivideByZeroErrorDescription! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ZeroDivisor class' category: #'Numero-Exercise'!
ZeroDivisor class
	instanceVariableNames: ''!

!ZeroDivisor class methodsFor: 'as yet unclassified' stamp: 'Lucas 4/15/2019 14:30:51'!
isFor: aDividend and: aDivisor

	^aDivisor isZero.! !
