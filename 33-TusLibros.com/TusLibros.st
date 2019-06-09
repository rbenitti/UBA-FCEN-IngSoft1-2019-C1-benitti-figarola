!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:08'!
test01NewCartsAreCreatedEmpty

	self assert: self createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [ cart add: self itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 0 of: self itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := self createCart.
	
	self 
		should: [cart add: 2 of: self itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test06CartRemembersAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: self itemSellByTheStore.
	self assert: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:43'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := self createCart.
	
	self deny: (cart includes: self itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 17:45'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := self createCart.
	
	cart add: 2 of: self itemSellByTheStore.
	self assert: (cart occurrencesOf: self itemSellByTheStore) = 2! !


!CartTest methodsFor: 'support' stamp: 'HernanWilkinson 6/17/2013 17:48'!
createCart
	
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
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:48:14'!
setUp

	today := GregorianMonthOfYear current.! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:49:31'!
test01CashierCanNotCheckOutAnEmptyCart

	| cart cashier card |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := CreditCard new.
	
	self 
		should: [cashier checkOutWith: card. ]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = cashier class canNotCheckOutOfCartEmptyErrorMessage. ]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:51:12'!
test02CheckOutOfACartWithOneItemReturnTicketWithCorrectPrice

	| cart cashier card price |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := self createValidCreditCard.
	cart add: self validBook1.
	
	price := cashier checkOutWith: card.
	self assert: price equals: 5.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:51:18'!
test03CheckOutOfACartWithMoreThanOneItemReturnTicketWithCorrectPrice

	| cart cashier card price |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := self createValidCreditCard.

	cart add: 2 of: self validBook1.
	
	price := cashier checkOutWith: card.
	self assert: price equals: 10.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:51:24'!
test04CheckOutOfACartWithDifferentItemsReturnTicketWithCorrectPrice

	| cart cashier card price |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := self createValidCreditCard.
	
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	
	price := cashier checkOutWith: card.
	self assert: price equals: 40.
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:55:24'!
test05CanNotCheckOutACartWithAnExpiredCreditCard

	| cart cashier card |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := self createExpiredCreditCard.
	
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	
	self 
		should: [cashier checkOutWith: card.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier expiredCreditCardErrorDescription. ]
	
	! !

!CashierTest methodsFor: 'testing' stamp: 'Lucas 6/9/2019 08:51:39'!
test06CanNotCheckOutACartWithAnExceededNameLengthOfCreditCardOwner

	| cart cashier card |
	
	cart := self createCart.
	cashier := self createCashierWith: cart.
	card := self createInvalidCreditCard.
	
	cart add: 2 of: self validBook1.
	cart add: 3 of: self validBook2.
	
	self 
		should: [cashier checkOutWith: card.]
		raise: Error
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier exceededNameLengthOfCreditCardOwnerErrorDescription. ]
	
	! !


!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:16:33'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:49:07'!
createCashierWith: aCart

	^Cashier with: aCart and: today.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:54:41'!
createExpiredCreditCard
	^ CreditCard ofNumber: '123' andExpiryDateOf: (GregorianMonthOfYear current previous) belongingTo: 'nombre'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:54:52'!
createInvalidCreditCard
	^ CreditCard ofNumber: '1234' andExpiryDateOf: (GregorianMonthOfYear current next) belongingTo: 'aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:54:12'!
createValidCreditCard
	^ CreditCard ofNumber: '1234' andExpiryDateOf: (GregorianMonthOfYear current next) belongingTo: 'someone'.! !

!CashierTest methodsFor: 'support' stamp: 'Lucas 6/9/2019 08:16:25'!
defaultCatalog
	
	| catalogPrice |
	catalogPrice := Dictionary new.
	catalogPrice at: self validBook1 put: 5. 
	catalogPrice at: self validBook2 put: 10. 
	
	^ catalogPrice! !

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
	instanceVariableNames: 'cart today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'operations' stamp: 'Lucas 6/9/2019 08:57:31'!
checkOutWith: aCard

	| ticket merchantProcessor|
	
	merchantProcessor := MerchantProcessor new.
	
	(cart isEmpty) ifTrue: [^self error: self class canNotCheckOutOfCartEmptyErrorMessage].
	(aCard owner size) > 30 ifTrue: [^self error: self class exceededNameLengthOfCreditCardOwnerErrorDescription].
	(aCard expiryDate < today) ifTrue: [self error: self class expiredCreditCardErrorDescription].
	ticket := cart total.
	
	 merchantProcessor charge: ticket to: aCard.
	
	^ticket
	
	! !


!Cashier methodsFor: 'initialization' stamp: 'Lucas 6/9/2019 08:50:39'!
initializeWith: aCart and: aDate

	cart := aCart.
	today := aDate.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/6/2019 18:36:12'!
canNotCheckOutOfCartEmptyErrorMessage

	^'Can not check out of cart empty'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/9/2019 08:34:40'!
exceededNameLengthOfCreditCardOwnerErrorDescription

	^'Can not check out with exceeded name length of credit card owner'! !

!Cashier class methodsFor: 'error message' stamp: 'Lucas 6/9/2019 08:43:30'!
expiredCreditCardErrorDescription

	^ 'expiredCreditCardErrorDescription'! !


!Cashier class methodsFor: 'instance creation' stamp: 'Lucas 6/9/2019 08:50:19'!
with: aCart and: aDate

	^self new initializeWith: aCart and: aDate! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'number expiryDate owner'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 10:00:14'!
expiryDate
	^expiryDate .! !

!CreditCard methodsFor: 'as yet unclassified' stamp: 'rb 6/8/2019 09:59:24'!
initializeWithaNumber: aCreditCardNumber andExpiryDateOf: anExpiryDate andOwnerName: aName
	number := aCreditCardNumber.
	expiryDate := anExpiryDate.
	owner := aName.
	! !

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

!MerchantProcessor methodsFor: 'as yet unclassified' stamp: 'Lucas 6/9/2019 08:58:03'!
charge: anAmount to: aCreditCard
	
	"(aCreditCard expiryDate < Date today) ifTrue: [self error: MerchantProcessor expiredCreditCardErrorDescription ]."! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'MerchantProcessor class' category: #TusLibros!
MerchantProcessor class
	instanceVariableNames: ''!

!MerchantProcessor class methodsFor: 'error descriptions' stamp: 'rb 6/8/2019 10:02:43'!
expiredCreditCardErrorDescription
	^ 'expiredCreditCardErrorDescription'! !
