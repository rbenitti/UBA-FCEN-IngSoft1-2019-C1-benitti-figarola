!classDefinition: #CartTest category: #TusLibros!
TestCase subclass: #CartTest
	instanceVariableNames: 'testObjectsFactory'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test01NewCartsAreCreatedEmpty

	self assert: testObjectsFactory createCart isEmpty! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test02CanNotAddItemsThatDoNotBelongToStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [ cart add: testObjectsFactory itemNotSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test03AfterAddingAnItemTheCartIsNotEmptyAnymore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self deny: cart isEmpty ! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test04CanNotAddNonPositiveNumberOfItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 0 of: testObjectsFactory itemSellByTheStore ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidQuantityErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:10'!
test05CanNotAddMoreThanOneItemNotSellByTheStore

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self 
		should: [cart add: 2 of: testObjectsFactory itemNotSellByTheStore  ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = cart invalidItemErrorMessage.
			self assert: cart isEmpty ]! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test06CartRemembersAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: testObjectsFactory itemSellByTheStore.
	self assert: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test07CartDoesNotHoldNotAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	self deny: (cart includes: testObjectsFactory itemSellByTheStore)! !

!CartTest methodsFor: 'tests' stamp: 'HernanWilkinson 6/17/2013 18:11'!
test08CartRemembersTheNumberOfAddedItems

	| cart |
	
	cart := testObjectsFactory createCart.
	
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	self assert: (cart occurrencesOf: testObjectsFactory itemSellByTheStore) = 2! !


!CartTest methodsFor: 'setup' stamp: 'HernanWilkinson 6/17/2013 18:09'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.! !


!classDefinition: #CashierTest category: #TusLibros!
TestCase subclass: #CashierTest
	instanceVariableNames: 'testObjectsFactory debitBehavior clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:05:45'!
test01CanNotCheckoutAnEmptyCart

	| salesBook |
	
	salesBook := OrderedCollection new.
	self 
		should: [ Cashier 
			toCheckout: testObjectsFactory createCart 
			charging: testObjectsFactory notExpiredCreditCard 
			throught: self
			on: testObjectsFactory today
			registeringOn:  salesBook forClient: clientId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier cartCanNotBeEmptyErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:06:25'!
test02CalculatedTotalIsCorrect

	| cart cashier |
	
	cart := testObjectsFactory createCart.
	cart add: 2 of: testObjectsFactory itemSellByTheStore.
	
	cashier :=  Cashier
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard 
		throught: self
		on: testObjectsFactory today 
		registeringOn: OrderedCollection new 
		forClient: clientId.
		
	self assert: cashier checkOut = (testObjectsFactory itemSellByTheStorePrice * 2)! !

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:05:45'!
test03CanNotCheckoutWithAnExpiredCreditCart

	| cart salesBook |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
	
	self
		should: [ Cashier 
				toCheckout: cart 
				charging: testObjectsFactory expiredCreditCard 
				throught: self
				on: testObjectsFactory today
				registeringOn: salesBook forClient: clientId ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError | 
			self assert: anError messageText = Cashier canNotChargeAnExpiredCreditCardErrorMessage.
			self assert: salesBook isEmpty ]! !

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:05:45'!
test04CheckoutRegistersASale

	| cart cashier salesBook total |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: testObjectsFactory notExpiredCreditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: clientId.
		
	total := cashier checkOut.
					
	self assert: salesBook size = 1.
	self assert: salesBook first total = total.! !

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:05:45'!
test05CashierChargesCreditCardUsingMerchantProcessor

	| cart cashier salesBook total creditCard debitedAmout debitedCreditCard  |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: clientId.
		
	debitBehavior := [ :anAmount :aCreditCard | 
		debitedAmout := anAmount.
		debitedCreditCard := aCreditCard ].
	total := cashier checkOut.
					
	self assert: debitedCreditCard = creditCard.
	self assert: debitedAmout = total.! !

!CashierTest methodsFor: 'tests' stamp: 'Lucas 6/24/2019 16:05:45'!
test06CashierDoesNotSaleWhenTheCreditCardHasNoCredit

	| cart cashier salesBook creditCard |

	cart := testObjectsFactory createCart.
	cart add: testObjectsFactory itemSellByTheStore.
	creditCard := testObjectsFactory notExpiredCreditCard.
	salesBook := OrderedCollection new.
 	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].
	
	cashier:= Cashier 
		toCheckout: cart 
		charging: creditCard
		throught: self
		on: testObjectsFactory today
		registeringOn: salesBook forClient: clientId.
		
	self 
		should: [cashier checkOut ]
		raise: Error - MessageNotUnderstood
		withExceptionDo: [ :anError |
			self assert: anError messageText = Cashier creditCardHasNoCreditErrorMessage.
			self assert: salesBook isEmpty ]! !


!CashierTest methodsFor: 'setup' stamp: 'Lucas 6/24/2019 16:06:03'!
setUp 

	testObjectsFactory := StoreTestObjectsFactory new.
	debitBehavior := [ :anAmount :aCreditCard | ].
	clientId := 1.! !


!CashierTest methodsFor: 'merchant processor protocol' stamp: 'HernanWilkinson 6/17/2013 19:02'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard ! !


!classDefinition: #RestInterfaceTest category: #TusLibros!
TestCase subclass: #RestInterfaceTest
	instanceVariableNames: 'debitBehavior testObjectsFactory interface id pass cartId validClientsData clock'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:54:29'!
test01_01CantCreateCartWithInvalidClientId

	self should: [ interface createCartUsingId: self invalidvalidClientId andPassword: self validPassword.]
	raise: self functionalException
	withExceptionDo: [ :anError | 
		self assert: anError messageText = interface invalidClientIdErrorMessage.
	].
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:06'!
test01_02CantCreateCartWithInvalidPassword

	self should: [ interface createCartUsingId: self validClientId andPassword: self invalidPassword.]
	raise: self functionalException
	withExceptionDo: [ :anError | 
		self assert: anError messageText = interface invalidPasswordErrorMessage.
	].
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:12'!
test02CanCreateCartWithValidData

	self assert: (interface listCartWithId: cartId) isEmpty.
	

	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:17'!
test03CantAddItemsUsingInvalidCartId

	
	self should: [interface addToCart: self invalidCartId theItem: testObjectsFactory itemSellByTheStore withQuantity: 5.] 
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidCartIdErrorMessage.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]

	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:16:40'!
test04CantAddItemsUsingInvalidQuantity


	self should: [ interface addToCart: cartId theItem: testObjectsFactory itemSellByTheStore withQuantity: 0] 
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidQuantityErrorMessage.
			self assert: (interface listCartWithId: cartId) isEmpty.
		].
	
	self should: [ interface addToCart: cartId theItem: testObjectsFactory itemSellByTheStore withQuantity: -1] 
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidQuantityErrorMessage.
			self assert: (interface listCartWithId: cartId) isEmpty.
		].


	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:30'!
test05CantAddInvalidItemToCart

	self should: [ interface addToCart: cartId theItem: testObjectsFactory itemNotSellByTheStore withQuantity: 1] 
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidItemErrorMessage.
			self assert: (interface listCartWithId: cartId) isEmpty.
		]

	


	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:35'!
test06ItemsCanBeAddedToCartUsingCorrectParameters

	| anotherValidCartId addedItems theItem |

	theItem := testObjectsFactory itemSellByTheStore.
	anotherValidCartId := interface createCartUsingId: self validClientId andPassword: self validPassword.
	
	interface addToCart: cartId theItem: theItem withQuantity: 2.
	addedItems := interface listCartWithId: cartId. 
	
	self assert: (addedItems includes: theItem).
	self assert: (addedItems occurrencesOf: theItem) equals: 2.
	self assert: (interface listCartWithId: anotherValidCartId) isEmpty.
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:40'!
test07CantListCartWithInvalidCartId

	self should: [interface listCartWithId: self invalidCartId.]
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidCartIdErrorMessage.
		]
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:51'!
test08ListCartCreatesListWithAllItemsPerCart

	| anotherCartId addedItems addedItemsToSecondCart theItem |
	
	anotherCartId := interface createCartUsingId: self anotherValidClientId andPassword: self anotherValidPassword. 
	theItem := testObjectsFactory itemSellByTheStore.

	interface addToCart: cartId theItem: theItem withQuantity: 2.
	interface addToCart: cartId theItem: theItem withQuantity: 1.
	interface addToCart: anotherCartId theItem: theItem withQuantity: 5.
	
	addedItems := interface listCartWithId: cartId. 
	addedItemsToSecondCart := interface listCartWithId: anotherCartId. 

	self assert: (addedItems includes: theItem).
	self assert: (addedItems occurrencesOf: theItem) equals: 3.
	self assert: (addedItemsToSecondCart includes: theItem).
	self assert: (addedItemsToSecondCart occurrencesOf: theItem) equals: 5.
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:55:58'!
test09CantCheckOutCartWithInvalidCartId

	| expirationDate |

	expirationDate := (Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1).

	self should: [interface checkoutCartIdentifiedBy: self invalidCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.]
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface invalidCartIdErrorMessage.
		]
	
	
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:56:27'!
test10_01CanCheckOutWithValidData

	| purchases |
	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 2.
	interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.
	
	purchases := interface listPurchasesOfClient: self validClientId.
	
	self assert: (purchases includes: self itemSellByTheStore ).
	self assert: (purchases occurrencesOf: self itemSellByTheStore) equals: 2.
	self 
		should: [interface listCartWithId: cartId] 
		raise: self functionalException 
		withExceptionDo: [ :anError | 
			self assert: (anError messageText = interface  invalidCartIdErrorMessage).
		].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:56:34'!
test10_02CantCheckOutCartAlreadyCheckedOut

	| purchases |
	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 2.
	interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.
	
	purchases := interface listPurchasesOfClient: self validClientId.
	
	self assert: (purchases includes: self itemSellByTheStore ).
	self assert: (purchases occurrencesOf: self itemSellByTheStore) equals: 2.
	self 
		should: [interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.] 
		raise: self functionalException 
		withExceptionDo: [ :anError | 
			self assert: (anError messageText = interface  invalidCartIdErrorMessage).
		].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:56:40'!
test11CheckingOutCartDoesNotAffectOtherCarts

	| purchases otherCartId |
	
	otherCartId := interface createCartUsingId: self anotherClientId andPassword: self anotherValidPassword.
	
	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 2.
	interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.
	
	purchases := interface listPurchasesOfClient: self validClientId .
	
	self assert: (purchases includes: self itemSellByTheStore ).
	self assert: (purchases occurrencesOf: self itemSellByTheStore) equals: 2.
	self 
		should: [interface listCartWithId: cartId] 
		raise: self functionalException 
		withExceptionDo: [ :anError | 
			self assert: (anError messageText = interface  invalidCartIdErrorMessage).
		].
	self assert: (interface listPurchasesOfClient: self anotherClientId) isEmpty.
	self assert: (interface listCartWithId: otherCartId ) isEmpty .
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:56:48'!
test12CantCheckoutWithExpiredCreditCard

	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.

	self should: [interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self expiredDate ownedBy: self validOwner.]
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface canNotChargeAnExpiredCreditCardErrorMessage.
		]
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:56:54'!
test13CantCheckoutUsingCreditCardWithNoCredit

	debitBehavior := [ :anAmount :aCreditCard | self error: Cashier creditCardHasNoCreditErrorMessage].

	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.

	self should: [interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.]
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface creditCardHasNoCreditErrorMessage.
		]
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:57:02'!
test14CantCheckoutEmptyCart

	self should: [interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.]
		raise: self functionalException 
		withExceptionDo: [ : anError |
			self assert: anError messageText  = interface cartIsEmptyErrorMessage.
		]
	
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:59:25'!
test15ListPurchasesShowsAllItemsForAllCheckouts

	| purchases |
	3 timesRepeat: 
	[
		| cartID |
		cartID := interface createCartUsingId: self validClientId andPassword: self validPassword.
		interface addToCart: cartID theItem: self itemSellByTheStore withQuantity: 1.
		interface checkoutCartIdentifiedBy: cartID withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.
	].

	purchases := interface listPurchasesOfClient: self validClientId .
	self assert: (purchases includes: self itemSellByTheStore ).
	self assert: (purchases occurrencesOf: self itemSellByTheStore ) equals: 3.
	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:59:45'!
test16ListPurchasesHasCorrectTotal

	| purchases |
	3 timesRepeat: 
	[
		| cartID |
		cartID := interface createCartUsingId: self validClientId andPassword: self validPassword .
		interface addToCart: cartID theItem: self itemSellByTheStore withQuantity: 1.
		interface checkoutCartIdentifiedBy: cartID withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.
	].

	purchases := interface listPurchasesOfClient: self validClientId .
	self assert: purchases total equals: (self itemSellByTheStorePrice) * 3	! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:59:52'!
test17CantListPurchasesOfInvalidClient

	validClientsData := Dictionary new.
	
	self should: [interface listPurchasesOfClient: 'anInvalidClientId'.]
	raise: self functionalException 
	withExceptionDo: [:anError | 
		self assert: anError messageText = interface invalidClientIdErrorMessage.
	].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 15:59:57'!
test18CantAddToCartAfter30Minutes

	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.
	self clock advanceInTime: (Duration minutes: 31).
	
	self should: [interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.] 
	raise: self functionalException 
	withExceptionDo: [ :anError |
		self assert: anError messageText = interface cartHasExpiredErrorMessage.
		self clock resetTime.
		self assert: ((interface listCartWithId: self validCartId) occurrencesOf: self itemSellByTheStore) equals: 1.
	].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:00:03'!
test19AddingItemsResetsExpirationTimeOfCart

	| itemsInCart |

	3 timesRepeat: [
		interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.
		self clock advanceInTime: (Duration minutes: 20).
	].

	itemsInCart := interface listCartWithId: self validCartId .
	self assert: (itemsInCart includes: self itemSellByTheStore).
	self assert: (itemsInCart occurrencesOf: self itemSellByTheStore) equals: 3.! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:00:08'!
test20CantCheckoutExpiredCart

	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.
	self clock advanceInTime: (Duration minutes: 40).
	
	self should: [interface checkoutCartIdentifiedBy: self validCartId withCardNumbered: self validCardNumber expiringOn: self validExpirationDate ownedBy: self validOwner.] 
	raise: self functionalException 
	withExceptionDo: [ :anError |
		self assert: anError messageText = interface cartHasExpiredErrorMessage.
		self clock resetTime.
		self assert: ((interface listCartWithId: self validCartId) occurrencesOf: self itemSellByTheStore) equals: 1. 
	].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:00:13'!
test21CantListExpiredCart

	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.
	self clock advanceInTime: (Duration minutes: 31).
	
	self should: [interface listCartWithId: self validCartId] 
	raise: self functionalException 
	withExceptionDo: [ :anError |
		self assert: anError messageText = interface cartHasExpiredErrorMessage.
	].! !

!RestInterfaceTest methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:00:22'!
test22ListingItemsResetsExpirationTimeOfCart

	| itemsList |
	interface addToCart: self validCartId theItem: self itemSellByTheStore withQuantity: 1.

	3 timesRepeat: [
		interface listCartWithId: self validCartId.
		self clock advanceInTime: (Duration minutes: 20).
	].

	itemsList := interface listCartWithId: self validCartId .
	self assert: (itemsList includes: self itemSellByTheStore ).
	self assert: (itemsList occurrencesOf: self itemSellByTheStore ) equals: 1.! !


!RestInterfaceTest methodsFor: 'setUp' stamp: 'Lucas 6/24/2019 15:54:54'!
setUp
	
	testObjectsFactory := StoreTestObjectsFactory new.
	
	validClientsData := Dictionary new.
	validClientsData 
		at: (self validClientId) put: (self validPassword);
		at: (self anotherValidClientId) put: (self anotherValidPassword).
	
	clock := ManualClock startingAt: testObjectsFactory today.
	debitBehavior := [ :anAmount :aCreditCard | true].
	
	
	interface _ self createInterface.
	cartId := interface createCartUsingId: self validClientId andPassword: self validPassword .! !


!RestInterfaceTest methodsFor: 'merchant processor protocol' stamp: 'Lucas 6/24/2019 16:01:11'!
debit: anAmount from: aCreditCard 

	^debitBehavior value: anAmount value: aCreditCard.

! !


!RestInterfaceTest methodsFor: 'authentication protocol' stamp: 'Lucas 6/24/2019 16:01:32'!
forClientIdentifiedBy: aClientId correctPasswordIs: aPassword

	^(validClientsData includesKey: aClientId) and:[(validClientsData at: aClientId) = aPassword ].

! !

!RestInterfaceTest methodsFor: 'authentication protocol' stamp: 'Lucas 6/24/2019 16:01:36'!
idExists: aClientId

	^validClientsData includesKey: aClientId.! !


!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:01:59'!
anotherClientId
	
	^2.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:04'!
anotherValidClientId
	
	^2! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:09'!
anotherValidPassword
	
	^'anotherValidPassword'! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:13'!
clock
	
	^clock.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:49'!
createInterface

	^RestInterface 
		withAuthenticator: self 
		withCatalog: testObjectsFactory defaultCatalog 
		withMerchantProcessor: self 
		withSalesBook: (OrderedCollection new)
		withClock: self clock.
	! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:29'!
expiredDate
	
	^(Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber - 1)! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:33'!
functionalException
	
	^Error - MessageNotUnderstood .! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:37'!
invalidCartId

	^nil! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:41'!
invalidPassword
	
	^'invalid password'! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:50'!
invalidvalidClientId
	
	^-1! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:02:58'!
itemSellByTheStore
	
	^testObjectsFactory itemSellByTheStore.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:04'!
itemSellByTheStorePrice
	
	^testObjectsFactory itemSellByTheStorePrice.! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:12'!
validCardNumber
	
	^'1234567800113344'! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:16'!
validCartId

	^cartId! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:21'!
validClientId
	
	^1! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:25'!
validExpirationDate
	
	^(Month month: testObjectsFactory today monthIndex year: testObjectsFactory today yearNumber + 1)! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:29'!
validOwner
	
	^'Juan Perez'! !

!RestInterfaceTest methodsFor: 'support' stamp: 'Lucas 6/24/2019 16:03:33'!
validPassword
	
	^'validPassword'! !


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


!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:06'!
assertIsValidItem: anItem

	(catalog includesKey: anItem) ifFalse: [ self error: self invalidItemErrorMessage ]! !

!Cart methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 17:51'!
assertIsValidQuantity: aQuantity

	aQuantity strictlyPositive ifFalse: [ self error: self invalidQuantityErrorMessage ]! !


!Cart methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 17:48'!
initializeAcceptingItemsOf: aCatalog

	catalog := aCatalog.
	items := OrderedCollection new.! !


!Cart methodsFor: 'queries' stamp: 'Lucas 6/24/2019 16:11:34'!
listItems

	^Bag new addAll: items .! !

!Cart methodsFor: 'queries' stamp: 'HernanWilkinson 6/17/2013 17:45'!
occurrencesOf: anItem

	^items occurrencesOf: anItem  ! !


!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
includes: anItem

	^items includes: anItem ! !

!Cart methodsFor: 'testing' stamp: 'HernanWilkinson 6/17/2013 17:44'!
isEmpty
	
	^items isEmpty ! !


!Cart methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 19:09'!
total

	^ items sum: [ :anItem | catalog at: anItem ]! !


!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:44'!
add: anItem

	^ self add: 1 of: anItem ! !

!Cart methodsFor: 'adding' stamp: 'HernanWilkinson 6/17/2013 17:51'!
add: aQuantity of: anItem

	self assertIsValidQuantity: aQuantity.
	self assertIsValidItem: anItem.

	1 to: aQuantity do: [ :aNumber | items add: anItem ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cart class' category: #TusLibros!
Cart class
	instanceVariableNames: ''!

!Cart class methodsFor: 'instance creation' stamp: 'HernanWilkinson 6/17/2013 17:48'!
acceptingItemsOf: aCatalog

	^self new initializeAcceptingItemsOf: aCatalog ! !


!Cart class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 16:12:36'!
invalidItemErrorMessage
	
	^'Item is not in catalog'! !

!Cart class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 16:12:41'!
invalidQuantityErrorMessage

	^'Invalid number of items'! !


!classDefinition: #CartSession category: #TusLibros!
Object subclass: #CartSession
	instanceVariableNames: 'clock lastUsedTime clientId cart'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CartSession methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 15:43:15'!
initializeForClient: aClientId usingCart: aCart WithClock: aClock 

	clientId := aClientId.
	cart := aCart.
	clock := aClock .
	lastUsedTime := clock now.! !


!CartSession methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:43:30'!
do: aBlock

	((clock now - lastUsedTime) minutes < 30) ifFalse: [self error: self class cartHasExpiredErrorMessage].
	lastUsedTime := clock now.
	aBlock value: clientId value: cart.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CartSession class' category: #TusLibros!
CartSession class
	instanceVariableNames: ''!

!CartSession class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 15:44:19'!
forClient: aClient usingCart: aCart withClock: aClock 

	^self new initializeForClient: aClient usingCart: aCart WithClock: aClock .! !


!CartSession class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:44:46'!
cartHasExpiredErrorMessage

	^'This cart has expired due to inactivity. Please create a new cart'.! !


!classDefinition: #Cashier category: #TusLibros!
Object subclass: #Cashier
	instanceVariableNames: 'cart salesBook merchantProcessor creditCard total clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:08'!
calculateTotal

	total := cart total.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'Lucas 6/24/2019 16:07:26'!
createSale

	^ Sale withItems: cart listItems of: total for: clientId ! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
debitTotal

	merchantProcessor debit: total from: creditCard.
	! !

!Cashier methodsFor: 'checkout - private' stamp: 'HernanWilkinson 6/17/2013 19:06'!
registerSale

	salesBook add: self createSale! !


!Cashier methodsFor: 'checkout' stamp: 'HernanWilkinson 6/17/2013 19:06'!
checkOut

	self calculateTotal.
	self debitTotal.
	self registerSale.

	^ total! !


!Cashier methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 16:08:04'!
initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook forClient: aClientId
	
	cart := aCart.
	creditCard := aCreditCard.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	clientId := aClientId.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Cashier class' category: #TusLibros!
Cashier class
	instanceVariableNames: ''!

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:22'!
assertIsNotEmpty: aCart 
	
	aCart isEmpty ifTrue: [self error: self cartCanNotBeEmptyErrorMessage ]! !

!Cashier class methodsFor: 'assertions' stamp: 'HernanWilkinson 6/17/2013 18:23'!
assertIsNotExpired: aCreditCard on: aDate
	
	(aCreditCard isExpiredOn: aDate) ifTrue: [ self error: self canNotChargeAnExpiredCreditCardErrorMessage ]! !


!Cashier class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 16:08:17'!
toCheckout: aCart charging: aCreditCard throught: aMerchantProcessor on: aDate registeringOn: aSalesBook forClient: aClientId 
	
	self assertIsNotEmpty: aCart.
	self assertIsNotExpired: aCreditCard on: aDate.
	
	^self new initializeToCheckout: aCart charging: aCreditCard throught: aMerchantProcessor registeringOn: aSalesBook forClient: aClientId! !


!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 18:21'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^'Can not charge an expired credit card'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 17:56'!
cartCanNotBeEmptyErrorMessage
	
	^'Can not check out an empty cart'! !

!Cashier class methodsFor: 'error messages' stamp: 'HernanWilkinson 6/17/2013 19:02'!
creditCardHasNoCreditErrorMessage
	
	^'Credit card has no credit'! !


!classDefinition: #CreditCard category: #TusLibros!
Object subclass: #CreditCard
	instanceVariableNames: 'expiration number ownerName'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!CreditCard methodsFor: 'testing' stamp: 'Lucas 6/24/2019 16:14:14'!
isExpiredOn: aDate 
	
	^expiration start < (Month month: aDate monthIndex year: aDate yearNumber) start ! !


!CreditCard methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 16:13:58'!
initializeNumbered: aCardNumber expiringOn: aMonth ownedBy: anOwnerName 
	
	expiration := aMonth.
	number := aCardNumber.
	ownerName := anOwnerName .! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CreditCard class' category: #TusLibros!
CreditCard class
	instanceVariableNames: ''!

!CreditCard class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 16:14:26'!
numbered: aCardNumber expiringOn: aMonth ownedBy: anOwnerName
	
	^self new initializeNumbered: aCardNumber expiringOn: aMonth ownedBy: anOwnerName ! !


!classDefinition: #RestInterface category: #TusLibros!
Object subclass: #RestInterface
	instanceVariableNames: 'loginDates cartIDs lastCartID catalog today merchantProcessor authenticator salesBook clock nextTransactionId nextCartId cartSessions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RestInterface methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 15:46:03'!
initialIzeWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesBook: aSalesBook withClock: aClock 

	authenticator := anAuthenticator.
	catalog := aCatalog.
	merchantProcessor := aMerchantProcessor.
	salesBook := aSalesBook.
	clock := aClock.
	
	nextTransactionId := 1.
	nextCartId := 1.
	cartSessions := Dictionary new.! !


!RestInterface methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:50:13'!
addToCart: aCartId theItem: anItem withQuantity: aQuantity
	
	self assertIsValidCartId: aCartId thenWithSessionDo:  [:clientId :cart | cart add:aQuantity of: anItem ].
! !

!RestInterface methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:50:20'!
checkoutCartIdentifiedBy: aCartId withCardNumbered: aCardNumber expiringOn: aDate ownedBy: aName 
	
	| currentTransactionId |
	self assertIsValidCartId: aCartId thenWithSessionDo: [ :clientId :cart | 
		| cashier |
		cashier := Cashier 
						toCheckout: cart
						charging: (CreditCard numbered: aCardNumber expiringOn: aDate ownedBy: aName)
						throught: merchantProcessor
						on: clock today month
						registeringOn:  salesBook 
						forClient: clientId.

		cashier checkOut.
	].

	cartSessions removeKey: aCartId. "finalize session".
	
	currentTransactionId := nextTransactionId.
	nextTransactionId _ nextTransactionId + 1.
	^currentTransactionId.! !

!RestInterface methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:51:35'!
createCartUsingId: aClientId andPassword: aPassword

	| cartId |
	self assertIsValidClientId: aClientId .
	self assertSessionCanStartWithClientId: aClientId andPassword: aPassword.

	cartSessions at: nextCartId put: (
		CartSession forClient: aClientId 
						usingCart: (Cart acceptingItemsOf: catalog) 
						withClock: self
	).
	
	cartId _ nextCartId.
	nextCartId _ nextCartId + 1.
	^cartId	! !

!RestInterface methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:51:41'!
listCartWithId: aCartId

	self assertIsValidCartId: aCartId thenWithSessionDo: [:clientId :cart | ^cart listItems.].
	
	! !

!RestInterface methodsFor: 'operations' stamp: 'Lucas 6/24/2019 15:51:49'!
listPurchasesOfClient: aClientId

	| items total sales |
	self assertIsValidClientId: aClientId .
	
	items := Bag new.
	total := 0.
	sales := salesBook select:[:sale | sale client = aClientId ].
	sales do: [:sale | sale client = aClientId ifTrue:[items addAll: sale items. total _ total + sale total]].
	
	^Ticket withItems: items summingTotal: total.! !


!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:40'!
canNotChargeAnExpiredCreditCardErrorMessage
	
	^self class canNotChargeAnExpiredCreditCardErrorMessage! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:45'!
cartHasExpiredErrorMessage
	
	^self class cartHasExpiredErrorMessage.! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:48'!
cartIsEmptyErrorMessage
	
	^self class cartIsEmptyErrorMessage! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:52'!
creditCardHasNoCreditErrorMessage
	
	^self class creditCardHasNoCreditErrorMessage! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:57'!
invalidCartIdErrorMessage
	
	^'Invalid cart id'! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:49:01'!
invalidClientIdErrorMessage
	
	^self class invalidClientIdErrorMessage.! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:49:05'!
invalidItemErrorMessage
	
	^self class invalidItemErrorMessage! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:49:08'!
invalidPasswordErrorMessage
	
	^'Invalid user or password'! !

!RestInterface methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:49:12'!
invalidQuantityErrorMessage
	
	^self class invalidQuantityErrorMessage! !


!RestInterface methodsFor: 'assertions - private' stamp: 'Lucas 6/24/2019 15:49:33'!
assertIsValidCartId: aCartId thenWithSessionDo: aBlock

	(cartSessions includesKey: aCartId) ifFalse: [self error: self invalidCartIdErrorMessage].
	(cartSessions at: aCartId) do: aBlock! !

!RestInterface methodsFor: 'assertions - private' stamp: 'Lucas 6/24/2019 15:49:37'!
assertIsValidClientId: aClientId

	(authenticator idExists: aClientId) ifFalse:[self error: self invalidClientIdErrorMessage].! !

!RestInterface methodsFor: 'assertions - private' stamp: 'Lucas 6/24/2019 15:49:45'!
assertSessionCanStartWithClientId: aClientId andPassword: aPassword
	
	(authenticator forClientIdentifiedBy: aClientId correctPasswordIs: aPassword) ifFalse: [self error: self invalidPasswordErrorMessage].! !


!RestInterface methodsFor: 'time' stamp: 'Lucas 6/24/2019 15:52:53'!
now

	^clock now.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'RestInterface class' category: #TusLibros!
RestInterface class
	instanceVariableNames: ''!

!RestInterface class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 15:47:12'!
withAuthenticator: anAuthenticator withCatalog: aCatalog withMerchantProcessor: aMerchantProcessor withSalesBook: aSalesBook withClock: aClock 

	^self new initialIzeWith: anAuthenticator andCatalog: aCatalog andMerchantProcessor: aMerchantProcessor andSalesBook: aSalesBook withClock: aClock.! !


!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:47:50'!
canNotChargeAnExpiredCreditCardErrorMessage

	^Cashier canNotChargeAnExpiredCreditCardErrorMessage.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:47:54'!
cartHasExpiredErrorMessage
	
	^CartSession cartHasExpiredErrorMessage.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:47:58'!
cartIsEmptyErrorMessage
	
	^Cashier cartCanNotBeEmptyErrorMessage.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:02'!
creditCardHasNoCreditErrorMessage
	
	^Cashier creditCardHasNoCreditErrorMessage.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:06'!
invalidClientIdErrorMessage
	
	^'this client id was not found'.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:09'!
invalidItemErrorMessage

	^Cart invalidItemErrorMessage.! !

!RestInterface class methodsFor: 'error message' stamp: 'Lucas 6/24/2019 15:48:13'!
invalidQuantityErrorMessage

	^Cart invalidQuantityErrorMessage.! !


!classDefinition: #Sale category: #TusLibros!
Object subclass: #Sale
	instanceVariableNames: 'total items clientId'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Sale methodsFor: 'total' stamp: 'Lucas 6/24/2019 15:42:22'!
client
	
	^ clientId! !

!Sale methodsFor: 'total' stamp: 'Lucas 6/24/2019 15:42:26'!
items
	
	^ items! !

!Sale methodsFor: 'total' stamp: 'HernanWilkinson 6/17/2013 18:48'!
total
	
	^ total! !


!Sale methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 15:42:11'!
initializeWithItems: anItemCollection ofTotal: aTotal forClient: aClientId

	items := anItemCollection.
	total := aTotal.
	clientId := aClientId.
	 ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Sale class' category: #TusLibros!
Sale class
	instanceVariableNames: ''!

!Sale class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 16:08:47'!
withItems: items of: aTotal for: aClientId 

	"should assert total is not negative or 0!!"
	^self new initializeWithItems: items ofTotal: aTotal forClient: aClientId ! !


!classDefinition: #StoreTestObjectsFactory category: #TusLibros!
Object subclass: #StoreTestObjectsFactory
	instanceVariableNames: 'today'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemNotSellByTheStore
	
	^'invalidBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStore
	
	^ 'validBook'! !

!StoreTestObjectsFactory methodsFor: 'items' stamp: 'HernanWilkinson 6/17/2013 18:08'!
itemSellByTheStorePrice
	
	^10! !


!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
createCart
	
	^Cart acceptingItemsOf: self defaultCatalog! !

!StoreTestObjectsFactory methodsFor: 'cart' stamp: 'HernanWilkinson 6/17/2013 18:08'!
defaultCatalog
	
	^ Dictionary new
		at: self itemSellByTheStore put: self itemSellByTheStorePrice;
		yourself ! !


!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Lucas 6/24/2019 16:14:52'!
expiredCreditCard
	
	^CreditCard numbered: '1122334455667788' expiringOn: (Month month: today monthIndex year: today yearNumber - 1) ownedBy: 'Juan Perez'! !

!StoreTestObjectsFactory methodsFor: 'credit card' stamp: 'Lucas 6/24/2019 16:15:00'!
notExpiredCreditCard
	
	^CreditCard numbered: '1122334455667788' expiringOn: (Month month: today monthIndex year: today yearNumber + 1) ownedBy: 'Juan Perez'! !


!StoreTestObjectsFactory methodsFor: 'initialization' stamp: 'HernanWilkinson 6/17/2013 18:37'!
initialize

	today := DateAndTime now! !


!StoreTestObjectsFactory methodsFor: 'date' stamp: 'HernanWilkinson 6/17/2013 18:37'!
today
	
	^ today! !


!classDefinition: #Ticket category: #TusLibros!
Object subclass: #Ticket
	instanceVariableNames: 'items total'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!Ticket methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 15:40:43'!
initializeWithItems: anItemCollection summingTotal: totalPrice

	items := anItemCollection.
	total := totalPrice.! !


!Ticket methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:40:52'!
includes: anItem

	^items includes: anItem.! !

!Ticket methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:40:57'!
isEmpty
	
	^items  isEmpty.! !

!Ticket methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:41:01'!
occurrencesOf: anItem

	^items occurrencesOf: anItem.! !

!Ticket methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:41:05'!
total

	^total copy.! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Ticket class' category: #TusLibros!
Ticket class
	instanceVariableNames: ''!

!Ticket class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 15:52:24'!
empty

	^self new initializeWithItems: Bag new summingTotal: 0.! !

!Ticket class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 15:52:15'!
withItems: anItemCollection summingTotal: total

	^self new initializeWithItems: anItemCollection summingTotal: total. ! !


!classDefinition: #TusLibrosClock category: #TusLibros!
Object subclass: #TusLibrosClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!TusLibrosClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:37:37'!
now

	^self subclassResponsibility.! !

!TusLibrosClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:37:42'!
today
	
	^self subclassResponsibility.! !


!classDefinition: #ManualClock category: #TusLibros!
TusLibrosClock subclass: #ManualClock
	instanceVariableNames: 'timeToAdvance startingDateAndTime'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!ManualClock methodsFor: 'initialization' stamp: 'Lucas 6/24/2019 15:38:47'!
initializeStartingAt: initialDateAndTime

	startingDateAndTime := initialDateAndTime .
	timeToAdvance := Duration zero.! !


!ManualClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:38:52'!
now

	^self currentDateAndTime.! !

!ManualClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:38:59'!
today
	
	^self currentDateAndTime date.! !


!ManualClock methodsFor: 'setting time' stamp: 'Lucas 6/24/2019 15:38:30'!
advanceInTime: aTimeDuration

	^timeToAdvance := timeToAdvance + aTimeDuration.! !

!ManualClock methodsFor: 'setting time' stamp: 'Lucas 6/24/2019 15:38:56'!
resetTime

	^timeToAdvance := Duration zero.! !


!ManualClock methodsFor: 'queries - private' stamp: 'Lucas 6/24/2019 15:38:41'!
currentDateAndTime

	^startingDateAndTime + timeToAdvance! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'ManualClock class' category: #TusLibros!
ManualClock class
	instanceVariableNames: ''!

!ManualClock class methodsFor: 'instance creation' stamp: 'Lucas 6/24/2019 15:39:53'!
startingAt: initialDateAndTime

	^self new initializeStartingAt: initialDateAndTime .! !


!classDefinition: #RealTimeClock category: #TusLibros!
TusLibrosClock subclass: #RealTimeClock
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'TusLibros'!

!RealTimeClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:39:28'!
now

	^DateAndTime now.! !

!RealTimeClock methodsFor: 'queries' stamp: 'Lucas 6/24/2019 15:39:33'!
today
	
	^DateAndTime today.! !
