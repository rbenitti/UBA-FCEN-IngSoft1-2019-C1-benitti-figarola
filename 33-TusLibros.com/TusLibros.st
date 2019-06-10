!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test01NewCartsAreCreatedEmpty

	self assert: self createCartWithDefaultCatalog isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'Lucas 6/10/2019 13:11:07'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCartWithDefaultCatalog.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 13:11:07'!
createCartWithDefaultCatalog
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:07:44'!
defaultCatalog

	| aDefaultCatalog |
	
	aDefaultCatalog := Dictionary new.
	aDefaultCatalog at: self itemSellByTheStore put: 5. 
	
	^ aDefaultCatalog! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:44'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:43'!
itemSellByTheStore
	
	^ 'validBook'! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'today invalidCreditCard'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:48:14'!
setUp

	today := GregorianMonthOfYear current.! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:55:28'!
test01CashierCanNotCheckOutAnEmptyCart

	| emptyCart salesBook |
	
	emptyCart := self createCartWithDefaultCatalog.
	salesBook := OrderedCollection new.
	
	self 
		should: [Cashier for: emptyCart payingWith: (self createValidCreditCard ) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier canNotCheckOutOfCartEmptyErrorMessage.
			self assert: salesBook isEmpty.]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:53:25'!
test02CheckOutOfACartWithOneItemReturnTicketWithCorrectPrice

	| cart cashier price salesBook |
	
	cart := self createCartWithDefaultCatalog.
	cart add: self validBook1.
	salesBook := OrderedCollection new.
	
	cashier := Cashier for: cart payingWith: (self createValidCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.
	
	price := cashier checkOut.
	self assert: price equals: 5.
	self assert: cashier totalSold equals: 5.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:52:52'!
test03CheckOutOfACartWithMoreThanOneItemReturnTicketWithCorrectPrice

	| cart cashier price salesBook |
	
	cart := self createCartWithDefaultCatalog.
	cart add: 2 of: self validBook1.
	salesBook := OrderedCollection new.
	cashier := Cashier for: cart payingWith: (self createValidCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.
	
	price := cashier checkOut.
	self assert: price equals: 10.
	self assert: cashier totalSold equals: 10.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:53:46'!
test04CheckOutOfACartWithDifferentItemsReturnTicketWithCorrectPrice

	| cart cashier price salesBook |
	
	cart := self createCartWithDefaultCatalog.	
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	salesBook := OrderedCollection new.
	
	cashier := Cashier for: cart payingWith: (self createValidCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.
	
	price := cashier checkOut.
	self assert: price equals: 40.
	self assert: cashier totalSold equals: 40.

	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:55:35'!
test05CanNotCheckOutACartWithAnExpiredCreditCard

	| cart salesBook |
	
	cart := self createCartWithDefaultCatalog.	
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	salesBook := OrderedCollection new.
	
	self 
		should: [Cashier for: cart payingWith: (self createExpiredCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCreditCardErrorDescription. 
			self assert: salesBook isEmpty.]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:55:41'!
test06CanNotCheckOutACartWithAnExceededNameLengthOfCreditCardOwner

	| cart salesBook |
	
	cart := self createCartWithDefaultCatalog.
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	salesBook := OrderedCollection new.
	
	self 
		should: [Cashier for: cart payingWith: (self createInvalidCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier exceededNameLengthOfCreditCardOwnerErrorDescription.
			self assert: salesBook isEmpty.]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/10/2019 15:55:46'!
test07CanNotCheckOutWithACreditCardInvalidForMerchantProcessor

	| cart cashier salesBook |
	
	cart := self createCartWithDefaultCatalog.
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	salesBook := OrderedCollection new.
	
	cashier := Cashier for: cart payingWith: (self invalidCreditCard) processedBy: (self defaultMerchandProcessor) on: today registeringOn: salesBook.
	
	self 
		should: [cashier checkOut ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier couldNotProcessPaymentErrorDescription.
			self assert: salesBook isEmpty.]
	
	! !


!CashierTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 13:11:07'!
createCartWithDefaultCatalog
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:49:07'!
createCashierWith: aCart

	^Cashier with: aCart and: today.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 15:22:42'!
createExpiredCreditCard
	^ CreditCard ofNumber: 1234567890123456 andExpiryDateOf: (GregorianMonthOfYear current previous) belongingTo: 'nombre'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:54:52'!
createInvalidCreditCard
	^ CreditCard ofNumber: '1234' andExpiryDateOf: (GregorianMonthOfYear current next) belongingTo: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 13:19:31'!
createValidCreditCard
	^ CreditCard ofNumber: 1234567890123456 andExpiryDateOf: (GregorianMonthOfYear current next) belongingTo: 'someone'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:16:25'!
defaultCatalog
	
	| catalogPrice |
	catalogPrice := Dictionary new.
	catalogPrice at: self validBook1 put: 5. 
	catalogPrice at: self validBook2 put: 10. 
	
	^ catalogPrice! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 13:22:52'!
defaultMerchandProcessor 

	^MerchantProcessorStub raisingErrorForCards: (Bag with: self invalidCreditCard).! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/10/2019 15:40:33'!
invalidCreditCard
	 
	(invalidCreditCard isNil) ifTrue:[invalidCreditCard:= CreditCard ofNumber: 3124567890123456 andExpiryDateOf: today belongingTo: 'someone'.].
	
	^ invalidCreditCard.
	! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/6/2019 18:47:26'!
validBook1
	
	^ 'validBook1'! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/6/2019 19:10:08'!
validBook2
	
	^ 'validBook2'! !


!classDefinition: #Cart category: #TusLibros!
Object subclass: #Cart
	instanceVariableNames: 'catalog items'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:45'!
invalidQuantityErrorMessage
	
	^'Invalid number of items'! !


!Cart methodsFor: 'assertions' stamp: 'Lucas 6/9/2019 08:15:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !


!Cart methodsFor: 'operations' stamp: 'Lucas 6/9/2019 19:50:50'!
addedItems
	
	| addedItems |
	addedItems := Bag new.
	addedItems addAll: items.
	^addedItems! !

!Cart methodsFor: 'operations' stamp: 'Lucas 6/9/2019 08:23:55'!
total 

	| totalAccumulator |
	totalAccumulator := 0.
	catalog keysAndValuesDo: [:anItem :price | (self includes: anItem) ifTrue: [totalAccumulator := totalAccumulator + ((self occurrencesOf: anItem) * price)]].
	^totalAccumulator! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook totalSold creditCard merchantProcessor processingDate'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'Lucas 6/10/2019 15:51:52'!
checkOut

	| amountToCharge|

	amountToCharge := cart total.
	
	[merchantProcessor charge: amountToCharge to: creditCard] on: Error do: [self error: Cashier couldNotProcessPaymentErrorDescription].
	
	salesBook add: amountToCharge.
	totalSold := amountToCharge.
	
	^amountToCharge
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'Lucas 6/10/2019 15:48:30'!
initializeFor: aCart  payWith: aCreditCard processedBy: aMerchantProcessor on: aProcessingDate registeringOn: aSalesBook

	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	processingDate := aProcessingDate.
	salesBook := aSalesBook.! !


!Cashier methodsFor: 'testing' stamp: 'Lucas 6/9/2019 20:07:29'!
totalSold

	^totalSold ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/6/2019 18:36:12'!
canNotCheckOutOfCartEmptyErrorMessage

	^'Can not check out of cart empty'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/10/2019 15:32:15'!
couldNotProcessPaymentErrorDescription

	^ 'couldNotProcessPaymentErrorDescription'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/9/2019 08:34:40'!
exceededNameLengthOfCreditCardOwnerErrorDescription

	^'Can not check out with exceeded name length of credit card owner'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/9/2019 08:43:30'!
expiredCreditCardErrorDescription

	^ 'expiredCreditCardErrorDescription'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/10/2019 12:55:13'!
invalidCreditCardNumberErrorDescription

	^ 'Credit Card Number must be a number of length 16 '! !


!Cashier class methodsFor: 'instance creation' stamp: 'Lucas 6/10/2019 15:48:50'!
for: aCart payingWith: aCreditCard processedBy: aMerchantProcessor on: aDate registeringOn: aSalesBook

	self assertIsNotEmptyCart: aCart.
	self assertCreditCard: aCreditCard on: aDate.
	
	^self new initializeFor: aCart  payWith: aCreditCard processedBy: aMerchantProcessor on: aDate registeringOn: aSalesBook
! !


!Cashier class methodsFor: 'assertions' stamp: 'Lucas 6/10/2019 13:20:33'!
assertCreditCard: aCard on: aDate

	(aCard owner size) > 30 ifTrue: [^self error: Cashier exceededNameLengthOfCreditCardOwnerErrorDescription].
	(aCard number asString size = 16)  ifFalse: [^self error: Cashier invalidCreditCardNumberErrorDescription].
	(aCard isExpiredWith: aDate) ifTrue: [^self error: Cashier expiredCreditCardErrorDescription].! !

!Cashier class methodsFor: 'assertions' stamp: 'Lucas 6/10/2019 13:06:44'!
assertIsNotEmptyCart: aCart
	
	(aCart isEmpty) ifTrue: [^self error: Cashier canNotCheckOutOfCartEmptyErrorMessage].! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiryDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 09:59:24'!
initializeWithaNumber: aCreditCardNumber andExpiryDateOf: anExpiryDate andOwnerName: aName
	number := aCreditCardNumber.
	expiryDate := anExpiryDate.
	owner := aName.
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'Lucas 6/9/2019 20:13:42'!
isExpiredWith: today
	^today > expiryDate  .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 10:00:01'!
number
	^ number.
	
	! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 10:00:24'!
owner
	^ owner.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 09:58:40'!
ofNumber: aCreditCardNumber andExpiryDateOf: aExpiryDate belongingTo: aName
	^ self new initializeWithaNumber: aCreditCardNumber andExpiryDateOf: aExpiryDate andOwnerName: aName! !


!classDefinition: #MerchantProcessor category: #TusLibros!
Object subclass: #MerchantProcessor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessor methodsFor: 'operations' stamp: 'Lucas 6/10/2019 12:52:33'!
charge: anAmount to: aCreditCard
	self subclassResponsibility 
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'rb 6/8/2019 10:02:43'!
expiredCreditCardErrorDescription
	^ 'expiredCreditCardErrorDescription'! !


!classDefinition: #MerchantProcessorStub category: #TusLibros!
MerchantProcessor subclass: #MerchantProcessorStub
	instanceVariableNames: 'creditCards'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!MerchantProcessorStub methodsFor: 'operations' stamp: 'Lucas 6/10/2019 12:53:22'!
charge: anAmount to: aCreditCard

	(creditCards includes: aCreditCard) ifTrue: [self error: '1|Cannot process payment'].! !

!MerchantProcessorStub methodsFor: 'operations' stamp: 'Lucas 6/10/2019 12:53:39'!
initializeWithRaisingErrorCards: aCollectionOfCreditCards
	
	creditCards := aCollectionOfCreditCards.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessorStub class' category: #TusLibros!
MerchantProcessorStub class
	instanceVariableNames: ''!

!MerchantProcessorStub class methodsFor: 'instance creation' stamp: 'Lucas 6/10/2019 12:54:00'!
raisingErrorForCards: aCollectionOfCreditCards
	
	^self new initializeWithRaisingErrorCards: aCollectionOfCreditCards! !
