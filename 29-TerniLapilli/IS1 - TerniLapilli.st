!classDefinition: #TerniLapilliTest category: #'IS1 - TerniLapilli'!
TestCase subclass: #TerniLapilliTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 11:59:40'!
test01TableIsEmptyWhenCreated

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	self assert: tableTerniLapilli xCount equals: 0.
	self assert: tableTerniLapilli oCount equals: 0.! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:00:02'!
test02XIsAddedInCorrectPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).
	self deny: (tableTerniLapilli hasXIn: (2@2)).
	self assert: (tableTerniLapilli hasXIn: (1@1)) ! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:33:44'!
test03OIsAddedInCorrectPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (1@1).
	self assert: (tableTerniLapilli hasOIn: (1@1)).
	self deny: (tableTerniLapilli hasOIn: (2@2))! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:33:49'!
test04OCantStartGame

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	self should: [tableTerniLapilli addOAt: (1@1).]
	raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli notOTurnErrorMessage! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:33:53'!
test05XCantBeAddedTwoConsecutiveTimes

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@2).
	self should: [tableTerniLapilli addXAt: (1@1).]
	raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli notXTurnErrorMessage! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:33:58'!
test06OCantBeAddedTwoConsecutiveTimes

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (2@2).
	self should: [tableTerniLapilli addOAt: (1@1).]
	raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli notOTurnErrorMessage! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:05'!
test07XCantBeAddedAtInvalidPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	
	self should: [tableTerniLapilli addXAt: (5@5).] raise: Error withMessageText: (TerniLapilli invalidPositionErrorMessage).! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:10'!
test08OCantBeAddedAtInvalidPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).
	self should: [tableTerniLapilli addOAt: (5@5).] raise: Error withMessageText: (TerniLapilli invalidPositionErrorMessage).

	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:15'!
test09XCantBeAddedInTakenPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	
	self should: [tableTerniLapilli addXAt: (2@2).] raise: Error withMessageText: (TerniLapilli positionAlreadyTakenErrorMessage).
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:21'!
test10OCantBeAddedInTakenPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).
	

	self should: [tableTerniLapilli addOAt: (1@1).] raise: Error withMessageText: (TerniLapilli positionAlreadyTakenErrorMessage).

	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:30'!
test11CantAddMoreThanThreeXTokens

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).
	tableTerniLapilli addOAt: (1@2).	
	
	tableTerniLapilli addXAt: (1@3).
	tableTerniLapilli addOAt: (2@1).
	
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (2@3).
	
	
	self should: [tableTerniLapilli addXAt: (3@1).] raise: Error withMessageText: (TerniLapilli cantAddedWhenAllTokensArePositionedErrorMessage).
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:36'!
test12XHasWonDiagonal

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (1@3).
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (2@1).	
	tableTerniLapilli addXAt: (3@3).
	
	self assert: (tableTerniLapilli xHasWon).
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:42'!
test13OHasWonDiagonal

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@2).	
	tableTerniLapilli addOAt: (1@1).
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (2@2).	
	tableTerniLapilli addXAt: (3@2).
	tableTerniLapilli addOAt: (3@3).	

	
	self assert: (tableTerniLapilli oHasWon).
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:47'!
test14XHasWonInvertedDiagonal

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (3@1).	
	tableTerniLapilli addOAt: (1@1).
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (3@3).	
	tableTerniLapilli addXAt: (1@3).
	
	self assert: (tableTerniLapilli xHasWon).
	self deny: (tableTerniLapilli oHasWon).
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:54'!
test15OHasWonInvertedDiagonal

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@1).	
	tableTerniLapilli addOAt: (3@1).
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (2@2).	
	tableTerniLapilli addXAt: (1@1).
	tableTerniLapilli addOAt: (1@3).
	
	self assert: (tableTerniLapilli oHasWon).
	self deny: (tableTerniLapilli xHasWon).
! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:34:59'!
test16XHasWonByRow

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@1).	
	tableTerniLapilli addOAt: (1@1).
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (1@3).	
	tableTerniLapilli addXAt: (2@3).
	
	self assert: (tableTerniLapilli xHasWon).
	self deny: (tableTerniLapilli oHasWon).
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:35:06'!
test17OHasWonByRow

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@1).	
	tableTerniLapilli addOAt: (1@1).
	tableTerniLapilli addXAt: (3@2).
	tableTerniLapilli addOAt: (1@2).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (1@3).
	
	self assert: (tableTerniLapilli oHasWon).
	self deny: (tableTerniLapilli xHasWon).
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:35:12'!
test18OHasWonByColumn

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (2@1).	
	tableTerniLapilli addOAt: (1@2).
	tableTerniLapilli addXAt: (1@3).
	tableTerniLapilli addOAt: (2@2).	
	tableTerniLapilli addXAt: (3@1).
	tableTerniLapilli addOAt: (3@2).
	
	self assert: (tableTerniLapilli oHasWon).
	self deny: (tableTerniLapilli xHasWon).
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:35:18'!
test18XHasWonByColumn

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (3@2).
	tableTerniLapilli addXAt: (2@1).
	tableTerniLapilli addOAt: (1@3).	
	tableTerniLapilli addXAt: (3@1).
	
	self assert: (tableTerniLapilli xHasWon).
	self deny: (tableTerniLapilli oHasWon).
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:35:23'!
test19OcantAddedWhenGameIsOver

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (1@3).
	tableTerniLapilli addXAt: (2@2).
	tableTerniLapilli addOAt: (2@1).	
	tableTerniLapilli addXAt: (3@3).
	
	self should: [tableTerniLapilli addOAt: (3@2).]
	raise: Error - MessageNotUnderstood 
	withMessageText: TerniLapilli gameIsOverErrorMessage
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:35:29'!
test20XCanBeMoved

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (1@3).
	tableTerniLapilli addXAt: (2@1).
	tableTerniLapilli addOAt: (2@2).	
	tableTerniLapilli addXAt: (3@3).
	tableTerniLapilli addOAt: (3@2).
	
	tableTerniLapilli moveXFrom: (1@1) to: (1@2).

	self assert: (tableTerniLapilli hasXIn: (1@2)).
	self deny: (tableTerniLapilli 	hasXIn: (1@1)).
	self deny: (tableTerniLapilli hasOIn: (1@1)).
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:26'!
test21OCanBeMoved

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@3).	
	tableTerniLapilli addOAt: (1@1).
	tableTerniLapilli addXAt: (2@1).
	tableTerniLapilli addOAt: (2@2).	
	tableTerniLapilli addXAt: (3@3).
	tableTerniLapilli addOAt: (3@2).
	tableTerniLapilli moveXFrom: (2@1) to: (3@1).
	
	tableTerniLapilli moveOFrom: (1@1) to: (1@2).

	self assert: (tableTerniLapilli hasOIn: (1@2)).
	self deny: (tableTerniLapilli 	hasXIn: (1@1)).
	self deny: (tableTerniLapilli hasOIn: (1@1)).
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:31'!
test22cantMoveXMoreThanOneSegment

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	self should: [tableTerniLapilli moveXFrom: (1@1) to: (3@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantMoveMoreThanOneSegmentsErrorMessage.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:38'!
test23cantMoveXMoreThanOneSegment

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	tableTerniLapilli moveXFrom: (2@3) to: (3@3). 
	
	self should: [tableTerniLapilli moveOFrom: (3@1) to: (1@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantMoveMoreThanOneSegmentsErrorMessage.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:44'!
test24cantMoveXToTakenPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	self should: [tableTerniLapilli moveXFrom: (1@1) to: (1@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli positionAlreadyTakenErrorMessage.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:49'!
test25cantMoveOToTakenPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	tableTerniLapilli moveXFrom: (1@2) to: (2@2).
	
	self should: [tableTerniLapilli moveOFrom: (2@1) to: (1@1).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli positionAlreadyTakenErrorMessage.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:56'!
test26cantMoveXWithInvalidPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	self should: [tableTerniLapilli moveXFrom: (3@3) to: (2@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli noTokenToMoveErrorMessage.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:01'!
test27cantMoveOWithInvalidPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).
	
	tableTerniLapilli moveXFrom: (1@2) to: (1@3).
	
	self should: [tableTerniLapilli moveOFrom: (3@3) to: (2@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli noTokenToMoveErrorMessage.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:08'!
test28cantMoveXWithInexistantInitialPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	
	self should: [tableTerniLapilli moveXFrom: (5@5) to: (2@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli invalidPositionErrorMessage .
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:13'!
test29cantMoveXWithInexistantEndPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	
	self should: [tableTerniLapilli moveXFrom: (1@1) to: (5@5).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli invalidPositionErrorMessage .
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:18'!
test30cantMoveOWithInexistantInitialPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (1@1) to: (2@2).
	
	self should: [tableTerniLapilli moveOFrom: (5@5) to: (3@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli invalidPositionErrorMessage .
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:24'!
test31cantMoveOWithInexistantEndPosition

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (1@1) to: (2@2).
	
	self should: [tableTerniLapilli moveOFrom: (2@1) to: (5@5).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli invalidPositionErrorMessage .
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:29'!
test33XhasWonWithAfterMove

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (2@3) to: (1@3).

	self assert: (tableTerniLapilli xHasWon).
	self deny: (tableTerniLapilli oHasWon).
	
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:35'!
test34OhasWonWithAfterMove

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (3@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (3@3) to: (2@3).
	tableTerniLapilli moveOFrom: (2@2) to: (3@3).

	self assert: (tableTerniLapilli oHasWon).
	self deny: (tableTerniLapilli xHasWon).
	
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:40'!
test35XCantMoveAfterGameIsOver

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (3@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (3@3) to: (2@3).
	tableTerniLapilli moveOFrom: (2@2) to: (3@3).

	self should: [tableTerniLapilli moveXFrom: (2@3) to: (1@3)] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli gameIsOverErrorMessage .
	
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:49'!
test36OCantMoveAfterGameIsOver

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (2@3) to: (1@3).
	

	self should: [tableTerniLapilli moveOFrom: (2@2) to: (3@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli gameIsOverErrorMessage .
	
	
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:55'!
test37XCantMoveIfNotAllTokensWherePlayed

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	tableTerniLapilli addXAt: (1@3).
	tableTerniLapilli addOAt: (3@1).	
	

	self should: [tableTerniLapilli moveXFrom: (1@1) to: (1@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantMoveTillAllTokensArePositionedErrorMessage.
	
	
	
	
	
	
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:37:59'!
test38OCantMoveIfNotAllTokensWherePlayed

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@2).
	tableTerniLapilli addXAt: (1@3).
	

	self should: [tableTerniLapilli moveXFrom: (2@2) to: (1@2).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantMoveTillAllTokensArePositionedErrorMessage.
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:38:04'!
test39OCantAddedIfAllTokensWherePlayed

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (1@1) to: (2@2).
	
	self should: [tableTerniLapilli addOAt: (3@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantAddedWhenAllTokensArePositionedErrorMessage.
	
	! !

!TerniLapilliTest methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:38:11'!
test40XCantAddedIfAllTokensWherePlayed

	| tableTerniLapilli |
	
	tableTerniLapilli := TerniLapilli new.
	tableTerniLapilli addXAt: (1@1).	
	tableTerniLapilli addOAt: (2@1).
	tableTerniLapilli addXAt: (1@2).
	tableTerniLapilli addOAt: (3@1).	
	tableTerniLapilli addXAt: (2@3).
	tableTerniLapilli addOAt: (3@2).

	tableTerniLapilli moveXFrom: (2@3) to: (3@3).
	tableTerniLapilli moveOFrom: (2@1) to: (2@2).
	
	self should: [tableTerniLapilli addXAt: (2@3).] raise: Error - MessageNotUnderstood withMessageText: TerniLapilli cantAddedWhenAllTokensArePositionedErrorMessage.
	
	! !


!classDefinition: #TerniLapilli category: #'IS1 - TerniLapilli'!
Object subclass: #TerniLapilli
	instanceVariableNames: 'tokenPositionsForO tokenPositionsForX state'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!TerniLapilli methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:33:29'!
initialize
	
	tokenPositionsForO := OrderedCollection new.
	tokenPositionsForX := OrderedCollection new.
	state := PlacingX with: self.
! !


!TerniLapilli methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:02:34'!
addOAt: aPosition 

	state addOAt: aPosition.
	self transitionateTo: state transitionate.
! !

!TerniLapilli methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:02:45'!
addXAt: aPosition 
	
	state addXAt: aPosition.
	self transitionateTo: state transitionate.
	
! !

!TerniLapilli methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:02:52'!
moveOFrom: fromPosition to: toPosition 
	
	state moveOFrom: fromPosition to: toPosition.
	self transitionateTo: state transitionate.! !

!TerniLapilli methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:02:59'!
moveXFrom: fromPosition to: toPosition 
	
	state moveXFrom: fromPosition to: toPosition.
	self transitionateTo: state transitionate.! !


!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:10:32'!
add: aPosition in: aTokenPositionCollection
	
	(self isInvalidPosition: aPosition) ifTrue: [self error: self class invalidPositionErrorMessage].
	((self hasOIn: aPosition) or:[self hasXIn: aPosition]) ifTrue: [self error: self class positionAlreadyTakenErrorMessage ].
	
	aTokenPositionCollection add: aPosition.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:10:40'!
addO: aPosition 
	
	self add: aPosition in: tokenPositionsForO.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:10:47'!
addX: aPosition 
	
	self add: aPosition in: tokenPositionsForX.

	! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:10:54'!
moveFrom: fromPosition to: toPosition using: aTokenPositionCollection
	
	((self isInvalidPosition: fromPosition) or: [self isInvalidPosition: toPosition]) ifTrue: [self error: self class invalidPositionErrorMessage ].
	((tokenPositionsForX includes: toPosition) or: [tokenPositionsForO includes: toPosition]) ifTrue: [self error: self class positionAlreadyTakenErrorMessage].
	((self isValidMoveFrom: fromPosition to: toPosition) not) ifTrue: [self error: self class cantMoveMoreThanOneSegmentsErrorMessage ].
	((aTokenPositionCollection includes: fromPosition) not) ifTrue: [self error: self class noTokenToMoveErrorMessage].
	
	aTokenPositionCollection remove: fromPosition.
	self add: toPosition in: aTokenPositionCollection .
! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:05'!
slideOFrom: fromPosition to: toPosition
	
	self moveFrom: fromPosition to: toPosition using: tokenPositionsForO.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:12'!
slideXFrom: fromPosition to: toPosition
	
	self moveFrom: fromPosition to: toPosition using: tokenPositionsForX.! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:18'!
transitionateTo: aTerniLapilliState

	state := aTerniLapilliState ! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:23'!
verifyHasWonByColumnUsing: aTokenPositionCollection
	
	| column | 

	"Winning by completing a column"
	column := (aTokenPositionCollection at:1) y. 
	^aTokenPositionCollection allSatisfy: [:aPosition | aPosition y = column]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:28'!
verifyHasWonByDiagonalUsing: aTokenPositionCollection
	
	"Winning by completing a diagonal"
	^(aTokenPositionCollection allSatisfy: [:aPosition | (aPosition x = aPosition y)]) 
		or: [aTokenPositionCollection allSatisfy: [:aPosition | (aPosition = (2@2)) or: [aPosition = (1@3) or: [aPosition = (3@1)]] ]
			
			]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:34'!
verifyHasWonByRowUsing: aTokenPositionCollection
	
	| row | 
	
	row := (aTokenPositionCollection at:1) x. 
	^aTokenPositionCollection allSatisfy: [:aPosition| aPosition x = row]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:40'!
verifyHasWonUsing: aTokenPositionCollection

	((aTokenPositionCollection size = 3) not ) ifTrue: [^false]. "cant win if there are tokens to be placed. "
		
	^(self verifyHasWonByDiagonalUsing: aTokenPositionCollection) or:[(self verifyHasWonByRowUsing: aTokenPositionCollection) or: [self verifyHasWonByColumnUsing: aTokenPositionCollection ]]! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:46'!
verifyOHasWon


	^self verifyHasWonUsing: tokenPositionsForO! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:51'!
verifySomeoneHasWon


	^(self verifyXHasWon ) or:[self verifyOHasWon ].! !

!TerniLapilli methodsFor: 'operations - private' stamp: 'Lucas 5/27/2019 12:11:57'!
verifyXHasWon


	^self verifyHasWonUsing: tokenPositionsForX! !


!TerniLapilli methodsFor: 'information' stamp: 'Lucas 5/27/2019 12:03:55'!
oCount

	^tokenPositionsForO size! !

!TerniLapilli methodsFor: 'information' stamp: 'Lucas 5/27/2019 12:04:00'!
xCount

	^tokenPositionsForX size! !


!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:07'!
hasOIn: aPosition 
	
	^tokenPositionsForO includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:12'!
hasXIn: aPosition 

	^tokenPositionsForX includes: aPosition.! !

!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:26'!
isInvalidPosition: aPosition

	| rowIsInvalid columnIsInvalid |
	
	rowIsInvalid := (aPosition x < 1) or: [aPosition x > 3].
	columnIsInvalid := (aPosition y < 1) or: [aPosition y > 3].
	^rowIsInvalid or:[columnIsInvalid].! !

!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:33'!
isValidMoveFrom: fromPosition to: toPosition 
	
	| center |
	center := (2@2).
	^(fromPosition = center) or:[ toPosition = center or: [ | rest |rest := ((fromPosition - toPosition) abs). (rest x + rest y) = 1]]! !

!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:39'!
oHasWon
	^state oHasWon! !

!TerniLapilli methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:03:45'!
xHasWon
	^state xHasWon! !


!TerniLapilli methodsFor: 'errors - private' stamp: 'Lucas 5/27/2019 12:12:10'!
cantAddedWhenAllTokensArePositionedError

		self error: self class cantAddedWhenAllTokensArePositionedErrorMessage! !

!TerniLapilli methodsFor: 'errors - private' stamp: 'Lucas 5/27/2019 12:12:16'!
cantMoveTillAllTokensArePositionedError

		self error: self class cantMoveTillAllTokensArePositionedErrorMessage.	! !

!TerniLapilli methodsFor: 'errors - private' stamp: 'Lucas 5/27/2019 12:12:23'!
gameIsOverError
	
	self error: self class gameIsOverErrorMessage! !

!TerniLapilli methodsFor: 'errors - private' stamp: 'Lucas 5/27/2019 12:12:28'!
notOTurnError

		self error: self class notOTurnErrorMessage.
	! !

!TerniLapilli methodsFor: 'errors - private' stamp: 'Lucas 5/27/2019 12:12:34'!
notXTurnError

		self error: self class notXTurnErrorMessage.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilli class' category: #'IS1 - TerniLapilli'!
TerniLapilli class
	instanceVariableNames: ''!

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:08'!
allTokensWhereAddedErrorMessage
	
	^'Cant add more than 3 tokens of same type'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:13'!
cantAddedWhenAllTokensArePositionedErrorMessage
	
	^'Cant add token when all tokens are positioned'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:19'!
cantMoveMoreThanOneSegmentsErrorMessage
	
	^'Cant move more than 1 segment'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:24'!
cantMoveTillAllTokensArePositionedErrorMessage

	^'Cant make a move if there are still tokens to be positioned'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:29'!
gameIsOverErrorMessage
	^'Game is over'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:33'!
invalidPositionErrorMessage
	^'Not a valid position'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:38'!
noTokenToMoveErrorMessage
	^'No token to move'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:43'!
notOTurnErrorMessage
	^'Its not O turn'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:47'!
notXTurnErrorMessage
	^'Its not X turn'! !

!TerniLapilli class methodsFor: 'Error message' stamp: 'Lucas 5/27/2019 12:13:53'!
positionAlreadyTakenErrorMessage
	
	^'Cant add token in cell that already has a token'! !


!classDefinition: #TerniLapilliState category: #'IS1 - TerniLapilli'!
Object subclass: #TerniLapilliState
	instanceVariableNames: 'terniLapilli'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!TerniLapilliState methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:19:00'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!TerniLapilliState methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:19:23'!
addOAt: aPosition

	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:19:28'!
addXAt: aPosition

	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:19:33'!
moveOFrom: fromPosition to: toPosition 

	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:19:37'!
moveXFrom: fromPosition to: toPosition 

	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:19:41'!
transitionate

	^self subclassResponsibility.! !


!TerniLapilliState methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:19:53'!
oHasWon

	^self subclassResponsibility.! !

!TerniLapilliState methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:19:59'!
xHasWon

	^self subclassResponsibility.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TerniLapilliState class' category: #'IS1 - TerniLapilli'!
TerniLapilliState class
	instanceVariableNames: ''!

!TerniLapilliState class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:20:29'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!TerniLapilliState class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:20:37'!
isFor: aTablero

	"turns and winners will be handled implicity by state transitions, this method just checks if current state is posible from token counts"
	^self subclassResponsibility.! !


!classDefinition: #PlacingO category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #PlacingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!PlacingO methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:22:31'!
inicializeWith: aTerniLapilli

	terniLapilli := aTerniLapilli.! !


!PlacingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:22:07'!
addOAt: aPosition

	terniLapilli addO: aPosition.! !

!PlacingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:22:13'!
addXAt: aPosition

	terniLapilli notXTurnError! !

!PlacingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:22:41'!
moveOFrom: fromPosition to: toPosition 

	terniLapilli cantMoveTillAllTokensArePositionedError! !

!PlacingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:22:46'!
moveXFrom: fromPosition to: toPosition 

	terniLapilli cantMoveTillAllTokensArePositionedError! !

!PlacingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:26:11'!
transitionate

	| posibleNextStates nextState |
	
	terniLapilli verifyOHasWon ifTrue: [^WinnerO with: terniLapilli ].
	posibleNextStates := OrderedCollection  with: PlacingX with: SlidingX.
	
	nextState := posibleNextStates detect: [:aTerniLapilliState | aTerniLapilliState isFor: terniLapilli ].
	^nextState with: terniLapilli .! !


!PlacingO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:23:19'!
oHasWon
	^false! !

!PlacingO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:23:25'!
xHasWon
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingO class' category: #'IS1 - TerniLapilli'!
PlacingO class
	instanceVariableNames: ''!

!PlacingO class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:21:07'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!PlacingO class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:26:27'!
isFor: aTerniLapilli

	^aTerniLapilli oCount < 3! !


!classDefinition: #PlacingX category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #PlacingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!PlacingX methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:25:51'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!PlacingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:27:10'!
addOAt: aPosition

	terniLapilli notOTurnError.! !

!PlacingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:27:16'!
addXAt: aPosition

	terniLapilli addX: aPosition.! !

!PlacingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:27:22'!
moveOFrom: aPosition to: aPosition2

	terniLapilli cantMoveTillAllTokensArePositionedError! !

!PlacingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:27:27'!
moveXFrom: aPosition to: aPosition2

	terniLapilli cantMoveTillAllTokensArePositionedError! !

!PlacingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:27:32'!
transitionate

	| posibleNextStates nextState |
	
	terniLapilli verifyXHasWon ifTrue: [^WinnerX with: terniLapilli ].
	posibleNextStates := OrderedCollection  with: PlacingO with: SlidingO.
	
	nextState := posibleNextStates detect: [:aTerniLapilliState | aTerniLapilliState isFor: terniLapilli ].
	^nextState with: terniLapilli.! !


!PlacingX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:27:41'!
oHasWon
	^false! !

!PlacingX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:27:46'!
xHasWon
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PlacingX class' category: #'IS1 - TerniLapilli'!
PlacingX class
	instanceVariableNames: ''!

!PlacingX class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:25:51'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!PlacingX class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:27:59'!
isFor: aTerniLapilli

	^aTerniLapilli xCount < 3! !


!classDefinition: #SlidingO category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #SlidingO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!SlidingO methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:23:53'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!SlidingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:28:15'!
addOAt: aPosition

	terniLapilli cantAddedWhenAllTokensArePositionedError! !

!SlidingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:28:23'!
addXAt: aPosition

	terniLapilli cantAddedWhenAllTokensArePositionedError! !

!SlidingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:28:29'!
moveOFrom: aPosition to: aPosition2

	terniLapilli slideOFrom: aPosition to: aPosition2! !

!SlidingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:28:35'!
moveXFrom: aPosition to: aPosition2

	terniLapilli notXTurnError! !

!SlidingO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:28:40'!
transitionate

	terniLapilli verifyOHasWon ifTrue: [^WinnerO with: terniLapilli ].	
	^SlidingX with: terniLapilli ! !


!SlidingO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:29:27'!
oHasWon
	^false! !

!SlidingO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:29:32'!
xHasWon
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingO class' category: #'IS1 - TerniLapilli'!
SlidingO class
	instanceVariableNames: ''!

!SlidingO class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:23:53'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!SlidingO class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:29:12'!
isFor: aTerniLapilli

	^aTerniLapilli oCount = 3! !


!classDefinition: #SlidingX category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #SlidingX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!SlidingX methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:24:13'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!SlidingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:29:47'!
addOAt: aPosition

	terniLapilli cantAddedWhenAllTokensArePositionedError! !

!SlidingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:29:52'!
addXAt: aPosition

	terniLapilli cantAddedWhenAllTokensArePositionedError! !

!SlidingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:29:58'!
moveOFrom: aPosition to: aPosition2

	terniLapilli notOTurnError! !

!SlidingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:30:05'!
moveXFrom: aPosition to: aPosition2

	terniLapilli slideXFrom: aPosition to: aPosition2! !

!SlidingX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:30:11'!
transitionate

	terniLapilli verifyXHasWon ifTrue: [^WinnerX with: terniLapilli ].	
	^SlidingO with: terniLapilli ! !


!SlidingX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:30:19'!
oHasWon
	^false! !

!SlidingX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:30:27'!
xHasWon
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'SlidingX class' category: #'IS1 - TerniLapilli'!
SlidingX class
	instanceVariableNames: ''!

!SlidingX class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:24:13'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!SlidingX class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:30:38'!
isFor: aTerniLapilli

	^aTerniLapilli xCount = 3! !


!classDefinition: #WinnerO category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #WinnerO
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!WinnerO methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:24:34'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!WinnerO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:24:34'!
addOAt: aPosition

	^self subclassResponsibility.! !

!WinnerO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:31:36'!
addXAt: aPosition

	terniLapilli gameIsOverError! !

!WinnerO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:31:47'!
moveOFrom: aPosition to: aPosition2

	terniLapilli gameIsOverError! !

!WinnerO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:31:54'!
moveXFrom: aPosition to: aPosition2

	terniLapilli gameIsOverError! !

!WinnerO methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:31:59'!
transitionate

	self error: 'Cant transitionate from and end state.' ! !


!WinnerO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:32:07'!
oHasWon
	^true! !

!WinnerO methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:32:12'!
xHasWon
	^false! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WinnerO class' category: #'IS1 - TerniLapilli'!
WinnerO class
	instanceVariableNames: ''!

!WinnerO class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:24:34'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!WinnerO class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:32:28'!
isFor: aTerniLapilli

	^aTerniLapilli oCount = 3! !


!classDefinition: #WinnerX category: #'IS1 - TerniLapilli'!
TerniLapilliState subclass: #WinnerX
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'IS1 - TerniLapilli'!

!WinnerX methodsFor: 'initialization' stamp: 'Lucas 5/27/2019 12:24:47'!
inicializeWith: aTablero

	terniLapilli := aTablero.! !


!WinnerX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:32:41'!
addOAt: aPosition

	self error: terniLapilli class gameIsOverErrorMessage! !

!WinnerX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:32:47'!
addXAt: aPosition

	self error: terniLapilli class gameIsOverErrorMessage! !

!WinnerX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:32:52'!
moveOFrom: aPosition to: aPosition2

	self error: terniLapilli class gameIsOverErrorMessage! !

!WinnerX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:32:58'!
moveXFrom: aPosition to: aPosition2

	self error: terniLapilli class gameIsOverErrorMessage! !

!WinnerX methodsFor: 'operations' stamp: 'Lucas 5/27/2019 12:33:06'!
transitionate

	self error: 'Cant transitionate from and end state.' ! !


!WinnerX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:06'!
oHasWon
	^false! !

!WinnerX methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:36:11'!
xHasWon
	^true! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'WinnerX class' category: #'IS1 - TerniLapilli'!
WinnerX class
	instanceVariableNames: ''!

!WinnerX class methodsFor: 'instance creation' stamp: 'Lucas 5/27/2019 12:24:47'!
with: aTablero

	^self new inicializeWith: aTablero.! !


!WinnerX class methodsFor: 'testing' stamp: 'Lucas 5/27/2019 12:33:15'!
isFor: aTerniLapilli

	^aTerniLapilli xCount = 3! !
