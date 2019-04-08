!classDefinition: #CantSuspend category: #'CodigoRepetido-Ejercicio'!
Error subclass: #CantSuspend
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #NotFound category: #'CodigoRepetido-Ejercicio'!
Error subclass: #NotFound
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!


!classDefinition: #CustomerBookTest category: #'CodigoRepetido-Ejercicio'!
TestCase subclass: #CustomerBookTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:12:20'!
assertExecutionTimeOf: aMethodToBeMeaussured notGreaterThanMilliseconds: aTimeLimit

	| millisecondsBeforeRunning millisecondsAfterRunning |
	
	millisecondsBeforeRunning := Time millisecondClockValue * millisecond.
	aMethodToBeMeaussured value.
	millisecondsAfterRunning := Time millisecondClockValue * millisecond.
	
	self assert: (millisecondsAfterRunning-millisecondsBeforeRunning) < (aTimeLimit * millisecond)
	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:06:03'!
assertThat: aMethodThatFails failsWithErrorType: anTypeError andMustCheck: aMethodToExecuteOnError
	
	[ aMethodThatFails value.
	self fail ]
		on: anTypeError 
		do: [ :anError | aMethodToExecuteOnError value: anError]
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:11:54'!
givenACustomerBook: aCustomerBook mustCheckThatAmountActiveCustomersIs: aAmountActiveCustomers amountSuspended: aAmountSuspended andAmountCustomers: aAmountCustomers andMustCheck: anAssertionToValue
	
	self assert: aAmountActiveCustomers equals: aCustomerBook numberOfActiveCustomers.
	self assert: aAmountSuspended equals: aCustomerBook numberOfSuspendedCustomers.
	self assert: aAmountCustomers equals: aCustomerBook numberOfCustomers.
	anAssertionToValue value.
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:03:15'!
test01AddingCustomerShouldNotTakeMoreThan50Milliseconds

	| customerBook |
	
	customerBook := CustomerBook new.
	
	self assertExecutionTimeOf: [customerBook addCustomerNamed: 'John Lennon'.] notGreaterThanMilliseconds: 50.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:03:45'!
test02RemovingCustomerShouldNotTakeMoreThan100Milliseconds

	| customerBook paulMcCartney |
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
		
	self assertExecutionTimeOf: [customerBook removeCustomerNamed: paulMcCartney.] notGreaterThanMilliseconds: 100.

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:13:41'!
test03CanNotAddACustomerWithEmptyName 

	| customerBook |
			
	customerBook := CustomerBook new.
	
	self assertThat: [customerBook addCustomerNamed: ''.] 
		failsWithErrorType: Error 
		andMustCheck: [ :anError | 
						self assert: anError messageText = CustomerBook customerCanNotBeEmptyErrorMessage.
						self assert: customerBook isEmpty].
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:13:34'!
test04CanNotRemoveAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat: [customerBook removeCustomerNamed: 'Paul McCartney'.] 
		failsWithErrorType: NotFound 
		andMustCheck: [ :anError | 
						self assert: customerBook numberOfCustomers = 1.
						self assert: (customerBook includesCustomerNamed: johnLennon)].

! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/4/2019 20:25:35'!
test05SuspendingACustomerShouldNotRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	
	self givenACustomerBook: customerBook mustCheckThatAmountActiveCustomersIs: 0 amountSuspended: 1 andAmountCustomers: 1 andMustCheck: [self assert: (customerBook includesCustomerNamed: paulMcCartney).]

	
	

	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/4/2019 20:26:00'!
test06RemovingASuspendedCustomerShouldRemoveItFromCustomerBook

	| customerBook paulMcCartney|
	
	customerBook := CustomerBook new.
	paulMcCartney := 'Paul McCartney'.
	
	customerBook addCustomerNamed: paulMcCartney.
	customerBook suspendCustomerNamed: paulMcCartney.
	customerBook removeCustomerNamed: paulMcCartney.
	
	self givenACustomerBook: customerBook mustCheckThatAmountActiveCustomersIs: 0 amountSuspended: 0 andAmountCustomers: 0 andMustCheck: [self deny: (customerBook includesCustomerNamed: paulMcCartney).]



	
! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:13:52'!
test07CanNotSuspendAnInvalidCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	
	self assertThat: [customerBook suspendCustomerNamed: 'Paul McCartney'.] 
		failsWithErrorType: CantSuspend 
		andMustCheck: [ :anError | 
						self assert: customerBook numberOfCustomers = 1.
						self assert: (customerBook includesCustomerNamed: johnLennon)].


! !

!CustomerBookTest methodsFor: 'testing' stamp: 'Lucas 4/8/2019 15:14:00'!
test08CanNotSuspendAnAlreadySuspendedCustomer
	
	| customerBook johnLennon |
			
	customerBook := CustomerBook new.
	johnLennon := 'John Lennon'.
	customerBook addCustomerNamed: johnLennon.
	customerBook suspendCustomerNamed: johnLennon.
	
	self assertThat: [customerBook suspendCustomerNamed: johnLennon.] 
		failsWithErrorType: CantSuspend 
		andMustCheck: [ :anError | 
			self assert: customerBook numberOfCustomers = 1.
			self assert: (customerBook includesCustomerNamed: johnLennon)].
! !


!classDefinition: #CustomerBook category: #'CodigoRepetido-Ejercicio'!
Object subclass: #CustomerBook
	instanceVariableNames: 'suspended active'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'CodigoRepetido-Ejercicio'!

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
includesCustomerNamed: aName

	^(active includes: aName) or: [ suspended includes: aName ]! !

!CustomerBook methodsFor: 'testing' stamp: 'NR 4/3/2019 10:14:26'!
isEmpty
	
	^active isEmpty and: [ suspended isEmpty ]! !


!CustomerBook methodsFor: 'initialization' stamp: 'NR 4/3/2019 10:14:26'!
initialize

	super initialize.
	active := OrderedCollection new.
	suspended:= OrderedCollection new.! !


!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
addCustomerNamed: aName

	aName isEmpty ifTrue: [ self signalCustomerNameCannotBeEmpty ].
	((active includes: aName) or: [suspended includes: aName]) ifTrue: [ self signalCustomerAlreadyExists ].
	
	active add: aName ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfActiveCustomers
	
	^active size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
numberOfCustomers
	
	^active size + suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 9/19/2018 17:36:09'!
numberOfSuspendedCustomers
	
	^suspended size! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
removeCustomerNamed: aName 
 
	1 to: active size do: 
	[ :index |
		aName = (active at: index)
			ifTrue: [
				active removeAt: index.
				^ aName 
			] 
	].

	1 to: suspended size do: 	
	[ :index |
		aName = (suspended at: index)
			ifTrue: [
				suspended removeAt: index.
				^ aName 
			] 
	].
	
	^ NotFound signal.
! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:52'!
signalCustomerAlreadyExists 

	self error: self class customerAlreadyExistsErrorMessage! !

!CustomerBook methodsFor: 'customer management' stamp: 'HernanWilkinson 7/6/2011 17:51'!
signalCustomerNameCannotBeEmpty 

	self error: self class customerCanNotBeEmptyErrorMessage ! !

!CustomerBook methodsFor: 'customer management' stamp: 'NR 4/3/2019 10:14:26'!
suspendCustomerNamed: aName 
	
	(active includes: aName) ifFalse: [^CantSuspend signal].
	
	active remove: aName.
	
	suspended add: aName
! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'CustomerBook class' category: #'CodigoRepetido-Ejercicio'!
CustomerBook class
	instanceVariableNames: ''!

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:22'!
customerAlreadyExistsErrorMessage

	^'Customer Already Exists'! !

!CustomerBook class methodsFor: 'error messages' stamp: 'NR 4/3/2019 10:16:31'!
customerCanNotBeEmptyErrorMessage

	^'Customer Name Cannot Be Empty'! !
