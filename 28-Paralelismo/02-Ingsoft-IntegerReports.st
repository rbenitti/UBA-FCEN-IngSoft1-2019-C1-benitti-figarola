!classDefinition: #IntegerReportTest category: #'Ingsoft-IntegerReports'!
TestCase subclass: #IntegerReportTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReportTest methodsFor: 'tests' stamp: 'rb 5/17/2019 07:49:51'!
test01

	| lines report  integerToAnalize |
	integerToAnalize := 100.
	report := BasicIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'rb 5/17/2019 07:50:10'!
test02

	| lines report integerToAnalize |
	
	integerToAnalize := 200.
	report := IntegerOnDifferentBasesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.

! !

!IntegerReportTest methodsFor: 'tests' stamp: 'rb 5/17/2019 07:50:35'!
test03

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := ComplexIntegerPropertiesReport for: integerToAnalize.
	lines := ReadStream on: report value.
	
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd. ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'rb 5/17/2019 07:47:46'!
test04

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CombinedIntegerPropertiesReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.
		
	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: lines atEnd.
	
 ! !

!IntegerReportTest methodsFor: 'tests' stamp: 'rb 5/17/2019 07:51:11'!
test05

	| lines report  integerToAnalize |
	
	integerToAnalize := 300.
	report := CompleteIntegerReport for: integerToAnalize.
	self 
		shouldnt: [ lines := ReadStream on: report value ]
		takeMoreThan: 1.5*second.

	self assert: 'Factorial: ', integerToAnalize factorial printString equals: lines next.
	self assert: 'Roman: ''', integerToAnalize printStringRoman, '''' equals: lines next.
	self assert: 'Ln: ', integerToAnalize ln printString equals: lines next.
	self assert: 'Prime?: ', integerToAnalize isPrime printString equals: lines next.
	self assert: 'Next Prime: ', integerToAnalize nextPrime printString equals: lines next.
	self assert: 'Sqrt: ', integerToAnalize sqrt printString equals: lines next.
	self assert: 'Binary: ', (integerToAnalize storeStringBase: 2) equals: lines next.
	self assert: 'Octal: ', (integerToAnalize storeStringBase: 8) equals: lines next.
	self assert: 'Hexadecimal: ', (integerToAnalize storeStringBase: 16) equals: lines next.
	self assert: lines atEnd.
	
 ! !


!IntegerReportTest methodsFor: 'assertions' stamp: 'rb 5/17/2019 07:49:23'!
shouldnt: aClosureToMeasure takeMoreThan: aTimeLimit

	| elapsedTime |
	
	elapsedTime :=  aClosureToMeasure timeToRun * millisecond.
	
	self assert: elapsedTime <= aTimeLimit 
	
! !


!classDefinition: #IntegerReport category: #'Ingsoft-IntegerReports'!
Object subclass: #IntegerReport
	instanceVariableNames: 'integerToAnalize'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerReport methodsFor: 'initialization' stamp: 'rb 5/17/2019 07:53:59'!
initializeFor: anIntegerToAnalize

	integerToAnalize := anIntegerToAnalize ! !


!IntegerReport methodsFor: 'reporting' stamp: 'rb 5/17/2019 07:54:14'!
value

	self subclassResponsibility ! !


!IntegerReport methodsFor: 'time consuption simulation' stamp: 'rb 5/17/2019 08:18:27'!
wait

	(Delay forSeconds: 1) wait.
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'IntegerReport class' category: #'Ingsoft-IntegerReports'!
IntegerReport class
	instanceVariableNames: ''!

!IntegerReport class methodsFor: 'instance creation' stamp: 'rb 5/17/2019 07:53:46'!
for: anIntegerToAnalize

	^self new initializeFor: anIntegerToAnalize ! !


!classDefinition: #CombinedIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #CombinedIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CombinedIntegerPropertiesReport methodsFor: 'reporting' stamp: 'rb 5/18/2019 16:20:55'!
value

	| basicPropertiesLines complexPropertiesLines lines sincronizador |
	
	sincronizador := Sincronizador new.
	lines := OrderedCollection new.
	
	sincronizador addParallelTask: [basicPropertiesLines := (BasicIntegerPropertiesReport for: integerToAnalize) value ] .
	sincronizador addParallelTask: [complexPropertiesLines := (ComplexIntegerPropertiesReport for: integerToAnalize) value ] .

	^sincronizador runAndAfterWaintingDo: [	
	lines 
		addAll: basicPropertiesLines;
		addAll: complexPropertiesLines.
		
	^lines.]
	
	! !


!classDefinition: #CompleteIntegerReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #CompleteIntegerReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!CompleteIntegerReport methodsFor: 'reporting' stamp: 'rb 5/18/2019 16:21:33'!
value

	| combinedPropertiesLines differentBasesLines lines sincronizador |
	
	sincronizador := Sincronizador new.
	lines := OrderedCollection new.	
	sincronizador addParallelTask: [combinedPropertiesLines := (CombinedIntegerPropertiesReport for: integerToAnalize) value ] .
	sincronizador addParallelTask: [differentBasesLines := (IntegerOnDifferentBasesReport for: integerToAnalize) value ] .
	^sincronizador runAndAfterWaintingDo: [
	lines
		addAll: combinedPropertiesLines;
		addAll: differentBasesLines.
		
	^lines].! !


!classDefinition: #IntegerOnDifferentBasesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #IntegerOnDifferentBasesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerOnDifferentBasesReport methodsFor: 'reporting - private' stamp: 'rb 5/17/2019 07:55:53'!
addNumberInBase: aBase to: lines title: aTitle

	lines add: aTitle, ': ', (integerToAnalize storeStringBase: aBase).
	
	! !


!IntegerOnDifferentBasesReport methodsFor: 'reporting' stamp: 'rb 5/17/2019 09:08:04'!
value

	| lines |

	self wait.
	
	lines := OrderedCollection new.
	
	self 
		addNumberInBase: 2 to: lines title: 'Binary';
		addNumberInBase: 8 to: lines title: 'Octal';
		addNumberInBase: 16 to: lines title: 'Hexadecimal'.
		
	^lines! !


!classDefinition: #IntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerReport subclass: #IntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!IntegerPropertiesReport methodsFor: 'reporting - private' stamp: 'rb 5/17/2019 07:56:00'!
addLineTo: lines title: aTitle with: anIntegerClosure

	lines add: aTitle, ': ', anIntegerClosure value printString
! !


!classDefinition: #BasicIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #BasicIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!BasicIntegerPropertiesReport methodsFor: 'reporting' stamp: 'rb 5/17/2019 09:08:13'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addLineTo: lines title: 'Factorial' with: [ integerToAnalize factorial ];
		addLineTo: lines title: 'Roman' with: [ integerToAnalize printStringRoman ];
		addLineTo: lines title: 'Ln' with: [ integerToAnalize ln ].
		
	^lines! !


!classDefinition: #ComplexIntegerPropertiesReport category: #'Ingsoft-IntegerReports'!
IntegerPropertiesReport subclass: #ComplexIntegerPropertiesReport
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!ComplexIntegerPropertiesReport methodsFor: 'reporting' stamp: 'rb 5/17/2019 09:08:20'!
value

	| lines |
	
	self wait.
	lines := OrderedCollection new.
	self 
		addLineTo: lines title: 'Prime?' with: [ integerToAnalize isPrime ];
		addLineTo: lines title: 'Next Prime' with: [ integerToAnalize nextPrime ];
		addLineTo: lines title: 'Sqrt' with: [ integerToAnalize sqrt ].
		
	^lines! !


!classDefinition: #Sincronizador category: #'Ingsoft-IntegerReports'!
Object subclass: #Sincronizador
	instanceVariableNames: 'tasks semaforo'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Ingsoft-IntegerReports'!

!Sincronizador methodsFor: 'actions' stamp: 'rb 5/18/2019 16:20:32'!
addParallelTask: aBlock
	tasks add: [aBlock value. semaforo signal].! !

!Sincronizador methodsFor: 'actions' stamp: 'rb 5/18/2019 16:18:12'!
runAndAfterWaintingDo: aBlock
	
	tasks do: [ :t | t fork].
	
	semaforo wait.
	^aBlock value.
	! !


!Sincronizador methodsFor: 'initialization' stamp: 'rb 5/18/2019 16:14:47'!
initialize
	semaforo := Semaphore new.
	tasks  := OrderedCollection  new.
	Transcript show: 'Se inicializo el sincronizador'.! !
