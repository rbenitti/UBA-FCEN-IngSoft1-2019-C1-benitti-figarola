!classDefinition: #OOStackTest category: #'Stack-Exercise'!
TestCase subclass: #OOStackTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test01StackShouldBeEmptyWhenCreated

	| stack |
	
	stack := OOStack new.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:30'!
test02PushAddElementsToTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	
	self deny: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:31'!
test03PopRemovesElementsFromTheStack

	| stack |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self assert: stack isEmpty! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/8/2012 08:20'!
test04PopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	stack push: pushedObject.
	
	self assert: stack pop = pushedObject! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:33'!
test05StackBehavesLIFO

	| stack firstPushedObject secondPushedObject |
	
	stack := OOStack new.
	firstPushedObject := 'First'.
	secondPushedObject := 'Second'.
	
	stack push: firstPushedObject.
	stack push: secondPushedObject.
	
	self assert: stack pop = secondPushedObject.
	self assert: stack pop = firstPushedObject.
	self assert: stack isEmpty 
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:35'!
test06TopReturnsLastPushedObject

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack top = pushedObject.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HernanWilkinson 5/7/2012 11:36'!
test07TopDoesNotRemoveObjectFromStack

	| stack pushedObject |
	
	stack := OOStack new.
	pushedObject := 'Something'.
	
	stack push: pushedObject.
	
	self assert: stack size = 1.
	stack top.
	self assert: stack size = 1.
	! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:26'!
test08CanNotPopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:36'!
test09CanNotPopWhenThereAreNoObjectsInTheStackAndTheStackHadObjects

	| stack  |
	
	stack := OOStack new.
	stack push: 'Something'.
	stack pop.
	
	self
		should: [ stack pop ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !

!OOStackTest methodsFor: 'test' stamp: 'HAW 4/14/2017 22:48:44'!
test10CanNotTopWhenThereAreNoObjectsInTheStack

	| stack  |
	
	stack := OOStack new.
	self
		should: [ stack top ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = OOStack stackEmptyErrorDescription ]
		
! !


!classDefinition: #SentenceFinderByPrefixTest category: #'Stack-Exercise'!
TestCase subclass: #SentenceFinderByPrefixTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 10:01:41'!
test01FindShouldNotAcceptEmptyPrefix
	
	|aStackWithStrings aSenteceFinderByPrefix anEmptyString|
	
	aStackWithStrings := OOStack new.
	aSenteceFinderByPrefix := SentenceFinderByPrefix for: aStackWithStrings.
	anEmptyString := ''.
	
	self
		should: [ aSenteceFinderByPrefix find: anEmptyString ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixEmptyErrorDescription ]
		! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 10:10:08'!
test02FindShouldNotAcceptSpacesInPrefix
	
	|aStackWithStrings aSenteceFinderByPrefix anStringWithSpace|
	
	aStackWithStrings := OOStack new.
	aSenteceFinderByPrefix := SentenceFinderByPrefix for: aStackWithStrings.
	anStringWithSpace := 'hola '.
	
	self
		should: [ aSenteceFinderByPrefix find: anStringWithSpace ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: anError messageText = SentenceFinderByPrefix prefixWithSpacesErrorDescription ]! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 10:35:35'!
test03FindShouldBeCaseSensitive
	
	|aStackWithStrings aSenteceFinderByPrefix|
	
	aStackWithStrings := OOStack new.
	aStackWithStrings push: 'winter is coming'.
	aStackWithStrings push: 'Winter is here'.
	aStackWithStrings push: 'winning is everything'.
	
	aSenteceFinderByPrefix := SentenceFinderByPrefix for: aStackWithStrings.
	
	self assert: (aSenteceFinderByPrefix find: 'Win') = (Bag  with: 'Winter is here').
	self assert: (aSenteceFinderByPrefix find: 'win') = (Bag  with: 'winter is coming' with: 'winning is everything').
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 10:15:26'!
test04FindDoesNotModifyStackOrder
	
	|aStackWithStrings aSenteceFinderByPrefix firstStringPushed secondStringPushed thirdStringPush|
	
	firstStringPushed := 'winter is coming' .
	secondStringPushed := 'Winter is here' .
	thirdStringPush := 'winning is everything'.
	
	aStackWithStrings := OOStack new.
	aStackWithStrings push: firstStringPushed.
	aStackWithStrings push: secondStringPushed.
	aStackWithStrings push: thirdStringPush.
	
	aSenteceFinderByPrefix := SentenceFinderByPrefix for: aStackWithStrings.
	
	aSenteceFinderByPrefix find: 'win'.
	
	self assert: aStackWithStrings pop = thirdStringPush .	
	self assert: aStackWithStrings pop = secondStringPushed .
	self assert: aStackWithStrings pop = firstStringPushed.
	self assert: aStackWithStrings isEmpty.
! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 11:55:22'!
test05FindReturnsAllMatches
	
	|aStackWithStrings aSenteceFinderByPrefix
	bagWithStringBeginnigWith_Win bagWithStringBeginnigWith_win bagWithStringBeginnigWith_T matchesFor_T matchesFor_Win matchesFor_wi |
	
	bagWithStringBeginnigWith_Win := Bag with: 'Winter is here' .
	bagWithStringBeginnigWith_win := Bag with: 'winter is coming' 
										    with: 'winning is everything'.
	bagWithStringBeginnigWith_T := Bag  with: 'The winds of Winter'.
	
	aStackWithStrings := OOStack new.
	bagWithStringBeginnigWith_Win do: [:element | aStackWithStrings push: element].
	bagWithStringBeginnigWith_win do: [:element | aStackWithStrings push: element].
	bagWithStringBeginnigWith_T do: [:element | aStackWithStrings push: element].
	
	aSenteceFinderByPrefix := SentenceFinderByPrefix for: aStackWithStrings.
	
	matchesFor_Win := aSenteceFinderByPrefix find: 'Win'.
	matchesFor_wi := aSenteceFinderByPrefix find: 'wi'.
	matchesFor_T := aSenteceFinderByPrefix find: 'T'.
	
	self assert: ((matchesFor_Win size = 1) 
		and:  (matchesFor_Win includes:'Winter is here') ).
	
	self assert: ((matchesFor_wi size = 2) 
		and: (matchesFor_wi includes: 'winter is coming') 
		and: (matchesFor_wi includes: 'winning is everything')).
	
	self assert: ((matchesFor_T size = 1) 
		and: (matchesFor_T includes: 'The winds of Winter')).
	
	! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 14:18:18'!
test06FindWorksWithEmptyStack
	
	|aStackWithStrings|
	
	
	aStackWithStrings := OOStack new.
	
	self assert: ((SentenceFinderByPrefix for: aStackWithStrings) isMemberOf: SentenceFinderByPrefix).! !

!SentenceFinderByPrefixTest methodsFor: 'tests' stamp: 'rb 4/22/2019 11:49:58'!
test07SentenceFinderByPrefixAcceptsEmptyStack
	
	|aStackWithStrings aSentenceFinder|
	
	
	aStackWithStrings := OOStack new.
	aSentenceFinder := SentenceFinderByPrefix for: aStackWithStrings.
	
	self assert: (aSentenceFinder find: 'test') isEmpty .! !


!classDefinition: #OOStack category: #'Stack-Exercise'!
Object subclass: #OOStack
	instanceVariableNames: 'anOrderCollection'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStack methodsFor: 'state' stamp: 'rb 4/20/2019 16:18:05'!
isEmpty
	^self size isZero! !

!OOStack methodsFor: 'state' stamp: 'rb 4/20/2019 10:33:22'!
size
	^anOrderCollection size.! !

!OOStack methodsFor: 'state' stamp: 'rb 4/21/2019 16:02:24'!
top
	
	^(OOStackState for: self) top
	! !


!OOStack methodsFor: 'initialization' stamp: 'rb 4/20/2019 16:17:40'!
initialize
	anOrderCollection := OrderedCollection new.
	! !


!OOStack methodsFor: 'operations' stamp: 'rb 4/21/2019 11:42:20'!
pop
	|tope|
	tope := self top. 
	anOrderCollection removeLast.
	^tope! !

!OOStack methodsFor: 'operations' stamp: 'rb 4/20/2019 16:18:14'!
push: anObject
	anOrderCollection addLast: anObject .
	
	^self.! !


!OOStack methodsFor: 'state - private' stamp: 'rb 4/22/2019 08:09:12'!
topIfEmpty
	self error: (OOStack stackEmptyErrorDescription)
		
	! !

!OOStack methodsFor: 'state - private' stamp: 'rb 4/22/2019 08:09:29'!
topIfNotEmpty
	^anOrderCollection last.
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStack class' category: #'Stack-Exercise'!
OOStack class
	instanceVariableNames: ''!

!OOStack class methodsFor: 'error descriptions' stamp: 'HernanWilkinson 5/7/2012 11:51'!
stackEmptyErrorDescription
	
	^ 'Stack is empty'! !


!classDefinition: #OOStackState category: #'Stack-Exercise'!
Object subclass: #OOStackState
	instanceVariableNames: 'stack'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackState methodsFor: 'as yet unclassified' stamp: 'rb 4/21/2019 16:01:06'!
with: anOOStack
	stack := anOOStack.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackState class' category: #'Stack-Exercise'!
OOStackState class
	instanceVariableNames: ''!

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:14:20'!
for: anOOStack
	^(self subclasses detect: [ :aStackStateSubClass | aStackStateSubClass toHandle: anOOStack ]) new with: anOOStack! !

!OOStackState class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:14:19'!
toHandle: anOOStack
	^self subclassResponsibility ! !


!classDefinition: #OOStackStateEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStackStateEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStackStateEmpty methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:09:12'!
top
	^stack topIfEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStackStateEmpty class' category: #'Stack-Exercise'!
OOStackStateEmpty class
	instanceVariableNames: ''!

!OOStackStateEmpty class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:14:19'!
toHandle: anOOStack
	^anOOStack isEmpty! !


!classDefinition: #OOStakeStateNotEmpty category: #'Stack-Exercise'!
OOStackState subclass: #OOStakeStateNotEmpty
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!OOStakeStateNotEmpty methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:09:29'!
top
	^stack topIfNotEmpty! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'OOStakeStateNotEmpty class' category: #'Stack-Exercise'!
OOStakeStateNotEmpty class
	instanceVariableNames: ''!

!OOStakeStateNotEmpty class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 08:14:20'!
toHandle: anOOStack
	^anOOStack isEmpty not! !


!classDefinition: #SentenceFinderByPrefix category: #'Stack-Exercise'!
Object subclass: #SentenceFinderByPrefix
	instanceVariableNames: 'stackWithStrings'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderByPrefix methodsFor: 'initialization' stamp: 'rb 4/22/2019 08:32:38'!
initializeWith: aStackWithStrings.
	stackWithStrings := aStackWithStrings.! !


!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'rb 4/22/2019 10:49:28'!
findEmptyPrefix: aPrefix

	self error: self class prefixEmptyErrorDescription! !

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'rb 4/22/2019 10:57:13'!
findNotEmptyPrefixWithoutSpaces: aPrefix

	|aString reconstructionStack result|
	
	result := Bag new.
	reconstructionStack := OOStack new.
	
	"Recorremos el stack de trabajo buscando los string que comiencen con el prefijo"
	"Guardamos los strings que quitamos del stack en otro stack temporal, para poder reconstruirlo al finalizar"
	[stackWithStrings isEmpty] whileFalse: [
		aString := stackWithStrings pop.
		(aString beginsWith: aPrefix) ifTrue: [result add: aString copy].
		reconstructionStack push: aString.
		].
	
	"Regresamos los elementos al stack original"
	[reconstructionStack isEmpty] whileFalse: [stackWithStrings push: reconstructionStack pop].
	
	^result ! !

!SentenceFinderByPrefix methodsFor: 'operations - private' stamp: 'rb 4/22/2019 10:56:22'!
findPrefixWithSpaces: aPrefix
	
	self error: self class prefixWithSpacesErrorDescription! !


!SentenceFinderByPrefix methodsFor: 'operations' stamp: 'rb 4/22/2019 11:37:51'!
find: aPrefix

	^(SentenceFinderPrefixConditions for: self searching: aPrefix) find.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderByPrefix class' category: #'Stack-Exercise'!
SentenceFinderByPrefix class
	instanceVariableNames: ''!

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'rb 4/22/2019 08:34:32'!
prefixEmptyErrorDescription
	^'Prefix cannot be an empty string'! !

!SentenceFinderByPrefix class methodsFor: 'error descriptions' stamp: 'rb 4/22/2019 08:34:52'!
prefixWithSpacesErrorDescription
	^'Prefix cannot contain white spaces.'! !


!SentenceFinderByPrefix class methodsFor: 'creation' stamp: 'rb 4/22/2019 08:32:15'!
for: aStackWithStrings
	^self new initializeWith: aStackWithStrings.! !


!classDefinition: #SentenceFinderPrefixConditions category: #'Stack-Exercise'!
Object subclass: #SentenceFinderPrefixConditions
	instanceVariableNames: 'sentenceFinderByPrefix prefix'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!SentenceFinderPrefixConditions methodsFor: 'initialization' stamp: 'rb 4/22/2019 10:59:35'!
initializeWith: aSentenceFinderByPrefix searching: aPrefix
	sentenceFinderByPrefix := aSentenceFinderByPrefix.
	prefix := aPrefix.! !


!SentenceFinderPrefixConditions methodsFor: 'operations' stamp: 'rb 4/22/2019 11:00:10'!
find
	^self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SentenceFinderPrefixConditions class' category: #'Stack-Exercise'!
SentenceFinderPrefixConditions class
	instanceVariableNames: ''!

!SentenceFinderPrefixConditions class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 11:11:17'!
for: aSenteceFinderByPrefix searching: aPrefix
	^ (self subclasses detect: [:aConditionSubclass | aConditionSubclass toHandle: aPrefix ]) new initializeWith: aSenteceFinderByPrefix searching: aPrefix.
	! !

!SentenceFinderPrefixConditions class methodsFor: 'as yet unclassified' stamp: 'rb 4/22/2019 10:42:47'!
toHandle: aString
	^self subclassResponsibility.
	! !


!classDefinition: #EmptyPrefix category: #'Stack-Exercise'!
SentenceFinderPrefixConditions subclass: #EmptyPrefix
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!EmptyPrefix methodsFor: 'operations' stamp: 'rb 4/22/2019 11:00:26'!
find
	^sentenceFinderByPrefix findEmptyPrefix: prefix! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'EmptyPrefix class' category: #'Stack-Exercise'!
EmptyPrefix class
	instanceVariableNames: ''!

!EmptyPrefix class methodsFor: 'case handling' stamp: 'rb 4/22/2019 10:43:05'!
toHandle: aString
	^aString isEmpty.! !


!classDefinition: #PrefixNotEmptyWithoutSpaces category: #'Stack-Exercise'!
SentenceFinderPrefixConditions subclass: #PrefixNotEmptyWithoutSpaces
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixNotEmptyWithoutSpaces methodsFor: 'operations' stamp: 'rb 4/22/2019 11:04:11'!
find
	^sentenceFinderByPrefix findNotEmptyPrefixWithoutSpaces: prefix ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixNotEmptyWithoutSpaces class' category: #'Stack-Exercise'!
PrefixNotEmptyWithoutSpaces class
	instanceVariableNames: ''!

!PrefixNotEmptyWithoutSpaces class methodsFor: 'case handling' stamp: 'rb 4/22/2019 10:47:17'!
toHandle: aString
	^(aString isEmpty or: (aString includes: $ )) not.! !


!classDefinition: #PrefixWithSpaces category: #'Stack-Exercise'!
SentenceFinderPrefixConditions subclass: #PrefixWithSpaces
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Stack-Exercise'!

!PrefixWithSpaces methodsFor: 'operations' stamp: 'rb 4/22/2019 11:00:55'!
find 
	^sentenceFinderByPrefix findPrefixWithSpaces: prefix  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PrefixWithSpaces class' category: #'Stack-Exercise'!
PrefixWithSpaces class
	instanceVariableNames: ''!

!PrefixWithSpaces class methodsFor: 'case handling' stamp: 'rb 4/22/2019 10:47:09'!
toHandle: aString
	^aString isEmpty not and: (aString includes: $ ).! !
