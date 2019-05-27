!classDefinition: #PorfolioTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #PorfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:10:28'!
test01PorfolioHaveZeroAsBalanceWhenCreatedByAnAccountWithZeroOfBalance

	| aPorfolio account |
	
	account := ReceptiveAccount  new.
	aPorfolio := Porfolio with: account.
	
	self assert: (aPorfolio doesManage: account).
	self assert: 0 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 19:21:46'!
test02DepositInTheAccountIncreasesBalanceOfPorfolioWhenCreatedByAnAccount

	| aPorfolio account |
	
	account := ReceptiveAccount  new.
	aPorfolio := Porfolio with: account.
	
	Deposit register: 100 on: account.
	
	self assert: (aPorfolio includeAccount: account).
	self assert: 100 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 19:22:14'!
test03WithdrawInTheAccountDecreasesBalanceOfPorfolioWhenCreatedByAnAccount

	| aPorfolio account |
	
	account := ReceptiveAccount  new.
	aPorfolio := Porfolio with: account.
	
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	
	self assert: (aPorfolio includeAccount: account).
	self assert: 50 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:22:43'!
test04PorfolioHaveIncluidaTheAccountsWithWhichWasCreated

	| aPorfolio account account2 accounts |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	
	self assert: (aPorfolio doesManage: account).
	self assert: (aPorfolio doesManage: account2).
	self assert: 0 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:12:48'!
test05PorfolioShouldNotIncludeAccountsWithWhichItWasNotCreated

	| aPorfolio account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	
	aPorfolio := Porfolio withAll: accounts.
	
	self assert: (aPorfolio doesManage: account).
	self deny: (aPorfolio doesManage: account2).
	self assert: 0 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:12:57'!
test06DepositInAnAccountIncreasesBalanceOfPorfolioWhenCreatedByAccounts

	| aPorfolio account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	
	aPorfolio := Porfolio withAll: accounts.
	Deposit register: 100 on: account.
	
	self assert: (aPorfolio doesManage: account).
	self deny: (aPorfolio doesManage: account2).
	self assert: 100 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:13:04'!
test07DepositInAccountsIncreasesBalanceOfPorfolioWhenCreatedByAccounts

	| aPorfolio account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	Deposit register: 100 on: account.
	Deposit register: 50 on: account2.
	
	self assert: (aPorfolio doesManage: account).
	self assert: (aPorfolio doesManage: account2).
	self assert: 150 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:13:13'!
test08WithdrawInAccountsDecreasesBalanceOfPorfolioWhenCreatedByAccounts

	| aPorfolio account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
	Deposit register: 200 on: account2.
	Withdraw register: 100 on: account2.
	
	self assert: (aPorfolio doesManage: account).
	self assert: (aPorfolio doesManage: account2).
	self assert: 150 equals: aPorfolio balance.! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 19:35:51'!
test09PorfolioKnowsRegisteredTransactionsWhenCreatedByAnAccount

	| aPorfolio account  deposit withdraw |
	
	account := ReceptiveAccount  new.
	
	aPorfolio := Porfolio with: account.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (aPorfolio hasRegistered: deposit).
	self assert: (aPorfolio hasRegistered: withdraw).
! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 19:44:24'!
test10PorfolioKnowsRegisteredTransactionsWhenCreatedByAccounts

	| aPorfolio account accounts account2 deposit deposit2 withdraw withdraw2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	deposit2 := Deposit register: 200 on: account2.
	withdraw2 := Withdraw register: 100 on: account2.
	
		
	self assert: (aPorfolio hasRegistered: deposit).
	self assert: (aPorfolio hasRegistered: withdraw).
	self assert: (aPorfolio hasRegistered: deposit2).
	self assert: (aPorfolio hasRegistered: withdraw2).! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:13:28'!
test11PorfolioHaveIncludeAnPorfolioWhenCreated

	| aPorfolio aPorfolio2 account accounts porfolios account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	
	porfolios := OrderedCollection new.
	porfolios add: aPorfolio.
	
	aPorfolio2 := Porfolio withAll: porfolios.
	
	self assert: (aPorfolio2 doesManage: account).
	self assert: (aPorfolio2 doesManage: account2).
	self assert: (aPorfolio2 doesManage: aPorfolio).
	self assert: 0 equals: aPorfolio balance.
	
! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:54:36'!
test12PorfolioKnowsRegisteredTransactionsWhenCreatedWithSeveralPorfolio

	| aPorfolio account accounts account2 account3 deposit deposit2 withdraw withdraw2 aPorfolio2 aPorfolio3 porfolios porfolios2 deposit3 withdraw3 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	account3 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	accounts add: account3.
	aPorfolio := Porfolio withAll: accounts.
	
	porfolios := OrderedCollection new.
	porfolios add: aPorfolio.
	aPorfolio2 := Porfolio withAll: porfolios.
	
	porfolios2 := OrderedCollection new.
	porfolios2 add: aPorfolio2.
	aPorfolio3 := Porfolio withAll: porfolios.
	
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
	deposit2 := Deposit register: 200 on: account2.
	withdraw2 := Withdraw register: 100 on: account2.
	deposit3 := Deposit register: 150 on: account3.
	withdraw3 := Withdraw register: 100 on: account3.
		
	self assert: (aPorfolio3 hasRegistered: deposit).
	self assert: (aPorfolio3 hasRegistered: withdraw).
	self assert: (aPorfolio3 hasRegistered: deposit2).
	self assert: (aPorfolio3 hasRegistered: withdraw2).
	self assert: (aPorfolio3 hasRegistered: deposit3).
	self assert: (aPorfolio3 hasRegistered: withdraw3).
	
! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 21:05:37'!
test13PorfolioKnowsRegisteredTransactionsWhenCreatedByAccounts

	| account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	accounts add: account2.
	
	self should: [Porfolio withAll: accounts] raise: Error withExceptionDo: [:anError | anError messageText = Porfolio accountAlreadyManagedErrorMessage]
	
	
	
! !

!PorfolioTest methodsFor: 'testing' stamp: 'Lucas 5/26/2019 21:08:45'!
test14PorfolioKnowsRegisteredTransactionsWhenCreatedByAccounts

	| porfolios aPorfolio aPorfolio2 account accounts account2 |
	
	account := ReceptiveAccount  new.
	account2 := ReceptiveAccount  new.
	accounts := OrderedCollection new.
	accounts add: account.
	accounts add: account2.
	
	aPorfolio := Porfolio withAll: accounts.
	aPorfolio2 := Porfolio withAll: accounts.
	porfolios := OrderedCollection new.
	porfolios add: aPorfolio.
	porfolios add: aPorfolio2.
	
	self should: [Porfolio withAll: porfolios] raise: Error withExceptionDo: [:anError | anError messageText = Porfolio accountNotManagedMessageDescription ]
	
	
	
! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Ejercicio'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:48'!
test01ReceptiveAccountHaveZeroAsBalanceWhenCreated 

	| account |
	
	account := ReceptiveAccount new.

	self assert: 0 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:19:54'!
test02DepositIncreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount  new.
	Deposit register: 100 on: account.
		
	self assert: 100 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:02'!
test03WithdrawDecreasesBalanceOnTransactionValue 

	| account |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	Withdraw register: 50 on: account.
		
	self assert: 50 equals: account balance .
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:32'!
test04WithdrawValueMustBePositive 

	| account withdrawValue |
	
	account := ReceptiveAccount new.
	withdrawValue := 50.
	
	self assert: withdrawValue equals: (Withdraw register: withdrawValue on: account) value
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:46'!
test05ReceptiveAccountKnowsRegisteredTransactions 

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	withdraw := Withdraw register: 50 on: account.
		
	self assert: (account hasRegistered: deposit).
	self assert: (account hasRegistered: withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:20:54'!
test06ReceptiveAccountDoNotKnowNotRegisteredTransactions

	| account deposit withdraw |
	
	account := ReceptiveAccount new.
	deposit :=  Deposit for: 100.
	withdraw := Withdraw for: 50.
		
	self deny: (account hasRegistered: deposit).
	self deny: (account hasRegistered:withdraw).
! !

!ReceptiveAccountTest methodsFor: 'tests' stamp: 'HAW 5/23/2019 15:21:24'!
test07AccountKnowsItsTransactions 

	| account1 deposit1 |
	
	account1 := ReceptiveAccount new.
	
	deposit1 := Deposit register: 100 on: account1.
		
	self assert: 1 equals: account1 transactions size .
	self assert: (account1 transactions includes: deposit1).
! !


!classDefinition: #AccountTransaction category: #'Portfolio-Ejercicio'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'value - private' stamp: 'Lucas 5/26/2019 20:08:07'!
affectBalance: currentBalance

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Ejercicio'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'value - private' stamp: 'Lucas 5/23/2019 20:46:51'!
affectBalance: currentBalance

	^currentBalance + value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Ejercicio'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #Withdraw category: #'Portfolio-Ejercicio'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'Lucas 5/23/2019 20:40:41'!
value

	^value! !


!Withdraw methodsFor: 'value - private' stamp: 'Lucas 5/23/2019 20:47:03'!
affectBalance: currentBalance

	^currentBalance - value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Ejercicio'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #SummarizingAccount category: #'Portfolio-Ejercicio'!
Object subclass: #SummarizingAccount
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!SummarizingAccount methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:06:18'!
doesManage: anAccount

	self subclassResponsibility ! !

!SummarizingAccount methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:06:26'!
hasRegistered: aTransaction

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'transaction' stamp: 'Lucas 5/26/2019 20:06:33'!
transactions

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'balance' stamp: 'Lucas 5/26/2019 20:06:40'!
balance

	self subclassResponsibility ! !


!SummarizingAccount methodsFor: 'testing - private' stamp: 'Lucas 5/26/2019 20:06:46'!
accounts

	self subclassResponsibility ! !


!classDefinition: #Porfolio category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #Porfolio
	instanceVariableNames: 'accounts'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!Porfolio methodsFor: 'operation' stamp: 'Lucas 5/26/2019 20:23:58'!
balance

	(self transactions isEmpty) ifTrue: [^0].
	
	^self transactions sum:[:aTrx | (aTrx isKindOf:Deposit) ifTrue: [aTrx value]
																	ifFalse: [aTrx value negated]].! !

!Porfolio methodsFor: 'operation' stamp: 'Lucas 5/23/2019 20:59:15'!
includeAccount: anAccount

	^accounts includes: anAccount.! !

!Porfolio methodsFor: 'operation' stamp: 'Lucas 5/26/2019 19:53:33'!
includePorfolio: anPorfolio

	^accounts includes: anPorfolio.! !


!Porfolio methodsFor: 'initialization' stamp: 'Lucas 5/26/2019 19:11:17'!
initalizeWith: anAccount

	accounts := OrderedCollection new.
	accounts add: anAccount! !

!Porfolio methodsFor: 'initialization' stamp: 'Lucas 5/26/2019 19:10:47'!
initalizeWithAll: anAccountsSet

	accounts := anAccountsSet ! !


!Porfolio methodsFor: 'transactions' stamp: 'Lucas 5/26/2019 19:59:24'!
transactions 


	| xx |
	xx := OrderedCollection new.
	accounts do: [:xAccount | xx addAll: (xAccount  transactions) ; yourself.] .
	^xx! !

!Porfolio methodsFor: 'transactions' stamp: 'Lucas 5/26/2019 19:59:35'!
transactionsOf: anAccount 

	| summarizingAccount |
	summarizingAccount := accounts detect:[ :aSummarizingAccount | aSummarizingAccount doesManage: anAccount] ifNone:[self error: self class accountNotManagedMessageDescription ].
	^summarizingAccount transactions ! !


!Porfolio methodsFor: 'testing' stamp: 'Lucas 5/26/2019 19:59:59'!
doesManage: anAccount

	accounts detect: [:aSummarizingAccount | aSummarizingAccount  doesManage: anAccount] ifNone:[^self = anAccount].
	^true. ! !

!Porfolio methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:02:24'!
hasRegistered: aTransaction

	^self transactions includes: aTransaction ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Porfolio class' category: #'Portfolio-Ejercicio'!
Porfolio class
	instanceVariableNames: ''!

!Porfolio class methodsFor: 'class initialization' stamp: 'Lucas 5/26/2019 19:10:28'!
with: anAccount

	^self new initalizeWith: anAccount! !

!Porfolio class methodsFor: 'class initialization' stamp: 'Lucas 5/26/2019 20:11:51'!
withAll: aCollectionOfAccounts

	| aSetOfAccounts |
	
	"No puede haber cuentas repetidas"
	aSetOfAccounts := Set withAll: aCollectionOfAccounts .
	(aCollectionOfAccounts size = aSetOfAccounts size) ifFalse:[self error: self accountAlreadyManagedErrorMessage ].

	"ninguna cuenta es manejada por otra"
	(aCollectionOfAccounts allSatisfy: 
		[ :anAccount | aCollectionOfAccounts allSatisfy: 
			[:anotherAccount | (anAccount = anotherAccount) 
				or:[anotherAccount  accounts allSatisfy: [:anotherAccountManagedAccount | (anAccount doesManage: anotherAccountManagedAccount) not ]] 
			]
		]
	 )
	ifFalse: [self error: self accountAlreadyManagedErrorMessage ].
	

	^self new initalizeWithAll: aCollectionOfAccounts ! !


!Porfolio class methodsFor: 'error message' stamp: 'Lucas 5/26/2019 20:01:48'!
accountAlreadyManagedErrorMessage

	^ 'Account already managed'! !

!Porfolio class methodsFor: 'error message' stamp: 'Lucas 5/26/2019 20:01:55'!
accountNotManagedMessageDescription
	
	^ 'Account not managed'! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Ejercicio'!
SummarizingAccount subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Ejercicio'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'Lucas 5/23/2019 20:47:16'!
balance

	^transactions inject: 0 into: [:balance :aTransaction | aTransaction affectBalance: balance]. ! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'Lucas 5/26/2019 20:03:54'!
doesManage: anAccount

	^ self = anAccount 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !


!ReceptiveAccount methodsFor: 'testing - private' stamp: 'Lucas 5/26/2019 20:03:31'!
accounts

	^OrderedCollection  with: self.! !
