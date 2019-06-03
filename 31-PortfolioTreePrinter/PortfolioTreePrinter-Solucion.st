!classDefinition: #PortfolioTest category: #'Portfolio-Solucion'!
TestCase subclass: #PortfolioTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:16:26'!
test01BalanceOfPortfolioWithoutAccountsIsZero

	self assert: 0 equals: Portfolio new balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:17:51'!
test02BalanceOfPortfolioWithOneAccountIsAccountBalance

	| account portfolio |
	
	account := ReceptiveAccount new.
	Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: account balance equals: portfolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:23:25'!
test03BalanceOfPortfolioIsCalculatedRecursivelyOnPortfolios

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortofolio |
	
	simplePortfolioAccount := ReceptiveAccount new.
	Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	Withdraw register: 50 on: composedPortfolioAccount.
	composedPortofolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolioAccount balance + simplePortfolio balance) equals: composedPortofolio balance! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:15'!
test04PortfolioWithoutAccountsHasNoRegisteredTransaction

	self deny: (Portfolio new hasRegistered: (Deposit for: 100))! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:43:11'!
test05PortfolioHasRegisteredItsAccountsTransactions

	| account portfolio deposit |
	
	account := ReceptiveAccount new.
	deposit := Deposit register: 100 on: account.
	portfolio := Portfolio with: account.
	
	self assert: (portfolio hasRegistered: deposit)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:06'!
test06PortfolioLooksForRegisteredTransactionsRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	self assert: (composedPortfolio hasRegistered: simplePortfolioAccountDeposit).
	self assert: (composedPortfolio hasRegistered: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:10'!
test07PortfolioHasNoTransactionWhenHasNoAccounts

	self assert: Portfolio new transactions isEmpty! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:15'!
test08PortfolioTransasctionsIncludesAllItsAccountsTransactions

	| account portfolio accountDeposit anotherAccount portfolioTransactions anotherAccountWithdraw |
	
	account := ReceptiveAccount new.
	accountDeposit := Deposit register: 100 on: account.
	anotherAccount := ReceptiveAccount new.
	anotherAccountWithdraw := Withdraw register: 100 on: account.
	portfolio := Portfolio with: account.
	
	portfolioTransactions := portfolio transactions.
	
	self assert: 2 equals: portfolioTransactions size.
	self assert: (portfolioTransactions includes: accountDeposit).
	self assert: (portfolioTransactions includes: anotherAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:20'!
test09PortfolioTransactionsAreCalculatedRecursively

	| simplePortfolioAccount simplePortfolio composedPortfolioAccount composedPortfolio composedPortfolioAccountWithdraw simplePortfolioAccountDeposit composedPortfolioTransactions |
	
	simplePortfolioAccount := ReceptiveAccount new.
	simplePortfolioAccountDeposit := Deposit register: 100 on: simplePortfolioAccount.
	simplePortfolio := Portfolio with: simplePortfolioAccount.
	
	composedPortfolioAccount := ReceptiveAccount new.
	composedPortfolioAccountWithdraw := Withdraw register: 50 on: composedPortfolioAccount.
	composedPortfolio := Portfolio with: simplePortfolio with: composedPortfolioAccount.
	
	composedPortfolioTransactions := composedPortfolio transactions.
	self assert: 2 equals: composedPortfolioTransactions size.
	self assert: (composedPortfolioTransactions includes: simplePortfolioAccountDeposit).
	self assert: (composedPortfolioTransactions includes: composedPortfolioAccountWithdraw)! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:24'!
test10PortfolioCanNotIncludeTheSameAccountMoreThanOnce

	| account portfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio with: account.
	
	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: portfolio accountsSize.
			self assert: (portfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:28'!
test11PortfolioCanNotIncludeAccountOfItsPortfolios

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	composedPortfolio := Portfolio with: simplePortfolio.
	
	self 
		should: [ composedPortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: composedPortfolio accountsSize.
			self assert: (composedPortfolio accountsIncludes: simplePortfolio) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 11:58:32'!
test12PortfolioCanNotIncludeItself

	| account simplePortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio with: account.
	
	self 
		should: [ simplePortfolio add: simplePortfolio ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: 1 equals: simplePortfolio accountsSize.
			self assert: (simplePortfolio accountsIncludes: account) ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:01:51'!
test13ComposedPortfolioCanNotHaveParentPortfolioAccount

	| account simplePortfolio composedPortfolio |
	
	account := ReceptiveAccount new.
	simplePortfolio := Portfolio new.
	composedPortfolio := Portfolio with: simplePortfolio.
	composedPortfolio add: account.
	
	self 
		should: [ simplePortfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: simplePortfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/25/2019 12:12:16'!
test14ComposedPortfolioCanNotHaveAccountOfAnyRootParentRecursively

	| account leftParentPortfolio leftRootParentPortfolio portfolio rightParentPortfolio rightRootParentPortfolio |
	
	account := ReceptiveAccount new.
	portfolio := Portfolio new.
	leftParentPortfolio := Portfolio with: portfolio .
	leftRootParentPortfolio := Portfolio with: leftParentPortfolio.
	leftRootParentPortfolio add: account.
	
	rightParentPortfolio := Portfolio with: portfolio .
	rightRootParentPortfolio := Portfolio with: rightParentPortfolio.
	rightRootParentPortfolio add: account.

	self 
		should: [ portfolio add: account ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError |
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolio accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'HAW 5/29/2019 16:31:18'!
test15PortfolioCanNotIncludeAnyOfTheComposedAccountOfPortfolioToAdd

	| portfolioToAdd portfolioToModify rootPortfolio sharedAccount |
	
	sharedAccount := ReceptiveAccount new.
	portfolioToModify := Portfolio new.
	rootPortfolio := Portfolio with: sharedAccount with: portfolioToModify.
	portfolioToAdd := Portfolio with: sharedAccount.
	
	self 
		should: [ portfolioToModify add: portfolioToAdd ]
		raise: Error - MessageNotUnderstood 
		withExceptionDo: [ :anError | 
			self assert: Portfolio canNotAddAccountErrorMessage equals: anError messageText.
			self assert: portfolioToModify accountsIsEmpty ]! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:36:08'!
test16TransferShouldWithdrawFromAccount1AndDepositIntoAccount2

	| account1 account2 |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 100 on: account1.
	
	Transfer register: 50 from: account1 to: account2.
	
	self assert: 50 equals: account1 balance.
	self assert:  50 equals: account2 balance.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:38:54'!
test17TransferShouldRegisterATransferDepositOnToAccount

	| account1 account2 transfer |
	
	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	
	transfer := Transfer register: 50 from: account1 to: account2.
	
	self assert: (account2 hasRegistered: transfer depositLeg).
	self assert: transfer value equals: transfer depositLeg value! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:39:49'!
test18TransferShouldRegistersATransferWithdrawOnFromAccount

	| account1 account2 transfer |

	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new.

	transfer := Transfer register: 50 from: account1 to: account2.
		
	self assert: (account1 hasRegistered: transfer withdrawLeg).
	self assert: transfer value equals: transfer withdrawLeg value! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:56:16'!
test19TransferLegCanTransfer

	| account1 account2 transfer |

	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new.

	transfer := Transfer register: 50 from: account1 to: account2.
		
	self assert: transfer depositLeg transfer equals: transfer withdrawLeg transfer.
	self assert: transfer equals: transfer depositLeg transfer.
	self assert: transfer equals: transfer withdrawLeg transfer.! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:49:46'!
test20AccountSummaryShouldProvideHumanReadableTransactionsDetail

	| account1 account2 account1Lines account2Lines |

	account1 := ReceptiveAccount new.
	account2 := ReceptiveAccount new.
	Deposit register: 200 on: account1.
	Withdraw register: 100 on: account1.
	
	Transfer register: 100 from: account1 to: account2.
	
	account1Lines := self accountSummaryLinesOf: account1.
	account2Lines := self accountSummaryLinesOf: account2.
	
	self assert: 3 equals: account1Lines size.
	self assert: 'Deposito por 200' equals: (account1Lines at: 1).
	self assert: 'Extraccion por 100' equals: (account1Lines at: 2).
	self assert: 'Transferencia por -100' equals: (account1Lines at: 3).
	
	self assert: 1 equals: account2Lines size.
	self assert: 'Transferencia por 100' equals: (account2Lines at: 1).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 15:53:34'!
test21ShouldBeAbleToBeQueryTransferNet

	| account1 account2 |
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 

	Deposit register: 100 on: account1.
	Withdraw register: 50 on: account1.
	Transfer register: 50 from: account1 to: account2.
	Transfer register: 100 from: account2 to: account1.

		
	self assert: 50 equals: (self accountTransferNetOf: account1).
	self assert: -50 equals: (self accountTransferNetOf: account2).! !

!PortfolioTest methodsFor: 'tests' stamp: 'Lucas 6/3/2019 16:06:56'!
test22PortfolioTreePrinterPrintsTheFamilyPortfolioInDepthFirstOrder

	| account1 account2 account3 childrenPortfolio familyPortfolio accountNames lines |
	
	account1 := ReceptiveAccount new. 
	account2 := ReceptiveAccount new. 
	account3 := ReceptiveAccount new. 
	
	childrenPortfolio := Portfolio with: account1 with: account2.
	familyPortfolio := Portfolio with: childrenPortfolio with: account3.

	accountNames := Dictionary new.
	accountNames at: familyPortfolio put: 'familyPortfolio'.
	accountNames at: childrenPortfolio put: 'childrenPortfolio'.
	accountNames at: account1 put: 'account1'.
	accountNames at: account2 put: 'account2'.
	accountNames at: account3 put: 'account3'.
		
	lines := self portofolioTreeOf: familyPortfolio namingAccountWith: accountNames.
		
	self assert: 5 equals: lines size.
	self assert: 'familyPortfolio' equals: (lines at: 1).
	self assert: ' childrenPortfolio' equals: (lines at: 2).
	self assert: '  account1' equals: (lines at: 3).
	self assert: '  account2' equals: (lines at: 4).
	self assert: ' account3' equals: (lines at: 5).! !


!PortfolioTest methodsFor: 'test support' stamp: 'Lucas 6/3/2019 15:45:18'!
accountSummaryLinesOf: aReceptiveAccount 
	
	| summary |
	
	summary := AccountSummary for: aReceptiveAccount.
	^ summary lines
! !

!PortfolioTest methodsFor: 'test support' stamp: 'Lucas 6/3/2019 15:52:32'!
accountTransferNetOf: aReceptiveAccount 
	
	^ (AccountTransferNetVisitor for: aReceptiveAccount) value! !

!PortfolioTest methodsFor: 'test support' stamp: 'Lucas 6/3/2019 15:54:38'!
portofolioTreeOf: aPortfolio namingAccountWith: aDictionary 
	
	^ (PortfolioTreePrinter of: aPortfolio namingAccountsWith: aDictionary) lines! !


!classDefinition: #ReceptiveAccountTest category: #'Portfolio-Solucion'!
TestCase subclass: #ReceptiveAccountTest
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

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


!classDefinition: #Account category: #'Portfolio-Solucion'!
Object subclass: #Account
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:23:47'!
hasRegistered: aTransaction

	self subclassResponsibility ! !

!Account methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:24:25'!
isComposedBy: anAccount

	self subclassResponsibility ! !


!Account methodsFor: 'balance' stamp: 'HAW 5/25/2019 12:23:40'!
balance

	self subclassResponsibility ! !


!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:27'!
addTransactionsTo: aCollectionOfTransactions

	self subclassResponsibility ! !

!Account methodsFor: 'transactions' stamp: 'HAW 5/25/2019 12:23:15'!
transactions

	self subclassResponsibility ! !


!Account methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:24:04'!
addedTo: aPortfolio

	self subclassResponsibility ! !


!classDefinition: #Portfolio category: #'Portfolio-Solucion'!
Account subclass: #Portfolio
	instanceVariableNames: 'accounts parents'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:20'!
accountsIncludes: anAccount

	^accounts includes: anAccount ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:05:04'!
accountsIsEmpty
	
	^accounts isEmpty ! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 11:49:06'!
accountsSize
	
	^accounts size! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:19:20'!
add: accountToAdd

	self assertCanAdd: accountToAdd.
		
	accounts add: accountToAdd.
	accountToAdd addedTo: self 
	! !

!Portfolio methodsFor: 'accounts management' stamp: 'HAW 5/25/2019 12:17:31'!
rootParents
	
	| rootParents |
	
	rootParents := Set new.
	self addRootParentsTo: rootParents.
	
	^ rootParents! !


!Portfolio methodsFor: 'initialization' stamp: 'HAW 5/25/2019 12:03:18'!
initialize

	accounts := OrderedCollection new.
	parents := OrderedCollection new.! !


!Portfolio methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:19:36'!
balance
	
	^accounts sum: [ :anAccount | anAccount balance ] ifEmpty: [ 0 ]! !


!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:42:55'!
addTransactionsTo: aCollectionOfTransactions

	accounts do: [ :anAccount | anAccount addTransactionsTo: aCollectionOfTransactions ]! !

!Portfolio methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:32'!
transactions
	
	| transactions |
	
	transactions := OrderedCollection new.
	accounts do: [ :anAccount | anAccount addTransactionsTo: transactions ].
	
	^transactions ! !


!Portfolio methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:02:59'!
addedTo: aPortfolio 
	
	parents add: aPortfolio ! !


!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 12:20:56'!
anyRootParentIsComposedBy: accountToAdd

	^self rootParents anySatisfy: [ :aParent | aParent isComposedBy: accountToAdd]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:28:29'!
hasRegistered: aTransaction

	^accounts anySatisfy: [ :anAccount | anAccount hasRegistered: aTransaction ]! !

!Portfolio methodsFor: 'testing' stamp: 'HAW 5/29/2019 16:24:54'!
isComposedBy: anAccount

	^ self = anAccount or: [ accounts anySatisfy: [ :composedAccount | (composedAccount isComposedBy: anAccount) or: [ anAccount isComposedBy: composedAccount ]]]! !


!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:17:31'!
addRootParentsTo: rootParents

	parents 
		ifEmpty: [ rootParents add: self ] 
		ifNotEmpty: [ parents do: [ :aParent | aParent addRootParentsTo: rootParents ]]! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 12:20:36'!
assertCanAdd: accountToAdd

	(self anyRootParentIsComposedBy: accountToAdd) ifTrue: [ self signalCanNotAddAccount ].
! !

!Portfolio methodsFor: 'account management - private' stamp: 'HAW 5/25/2019 11:48:34'!
signalCanNotAddAccount
	
	self error: self class canNotAddAccountErrorMessage! !


!Portfolio methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:33:16'!
accept: aSummarizingAccountVisitor

	^ aSummarizingAccountVisitor visitPortfolio: self ! !

!Portfolio methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:33:10'!
visitAccountsWith: aPortfolioTreePrinter 
	
	accounts do: [ :anAccount | anAccount accept: aPortfolioTreePrinter ]! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Portfolio class' category: #'Portfolio-Solucion'!
Portfolio class
	instanceVariableNames: ''!

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:48:55'!
canNotAddAccountErrorMessage
	
	^'Can not add repeated account to a portfolio'! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:18:21'!
with: anAccount

	^self new 
		add: anAccount;
		yourself! !

!Portfolio class methodsFor: 'as yet unclassified' stamp: 'HAW 5/25/2019 11:23:59'!
with: anAccount with: anotherAccount

	^self new 
		add: anAccount;
		add: anotherAccount;
		yourself! !


!classDefinition: #ReceptiveAccount category: #'Portfolio-Solucion'!
Account subclass: #ReceptiveAccount
	instanceVariableNames: 'transactions'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!ReceptiveAccount methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:35'!
initialize

	super initialize.
	transactions := OrderedCollection new.! !


!ReceptiveAccount methodsFor: 'transactions' stamp: 'HAW 5/25/2019 11:38:52'!
addTransactionsTo: aCollectionOfTransactions

	aCollectionOfTransactions addAll: transactions ! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
register: aTransaction

	transactions add: aTransaction 
! !

!ReceptiveAccount methodsFor: 'transactions' stamp: 'HernanWilkinson 7/13/2011 18:37'!
transactions 

	^ transactions copy! !


!ReceptiveAccount methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:24:46'!
balance

	^transactions 
		inject: 0
		into: [ :currentBalance :transaction | transaction affectBalance: currentBalance ]! !


!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 10/11/2018 16:53:54'!
hasRegistered: aTtransaction

	^ transactions includes: aTtransaction 
! !

!ReceptiveAccount methodsFor: 'testing' stamp: 'HAW 5/25/2019 11:54:51'!
isComposedBy: anAccount

	^self = anAccount ! !


!ReceptiveAccount methodsFor: 'composition' stamp: 'HAW 5/25/2019 12:03:32'!
addedTo: aPortfolio 
	
	! !


!ReceptiveAccount methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:33:38'!
accept: aSummarizingAccountVisitor

	^ aSummarizingAccountVisitor visitReceptiveAccount: self! !

!ReceptiveAccount methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:33:44'!
visitTransactionsWith: aTransactionVisitor

	transactions do: [ :aTransaction | aTransaction accept: aTransactionVisitor ]! !


!classDefinition: #AccountTransaction category: #'Portfolio-Solucion'!
Object subclass: #AccountTransaction
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransaction methodsFor: 'value' stamp: 'HernanWilkinson 9/12/2011 12:25'!
value 

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:39'!
affectBalance: aBalance

	self subclassResponsibility ! !


!AccountTransaction methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:47:27'!
accept: anAccountTransactionVisitor

	self subclassResponsibility ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransaction class' category: #'Portfolio-Solucion'!
AccountTransaction class
	instanceVariableNames: ''!

!AccountTransaction class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
register: aValue on: account

	| withdraw |
	
	withdraw := self for: aValue.
	account register: withdraw.
		
	^ withdraw! !


!classDefinition: #Deposit category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Deposit
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Deposit methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:45'!
initializeFor: aValue

	value := aValue ! !


!Deposit methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:38'!
value

	^ value! !


!Deposit methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:02'!
affectBalance: aBalance

	^aBalance + value ! !


!Deposit methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:47:45'!
accept: aTransactionVisitor

	^ aTransactionVisitor visitDeposit: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Deposit class' category: #'Portfolio-Solucion'!
Deposit class
	instanceVariableNames: ''!

!Deposit class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:38'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #TransferLeg category: #'Portfolio-Solucion'!
AccountTransaction subclass: #TransferLeg
	instanceVariableNames: 'transfer'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferLeg methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:09:48'!
initializeRelatedTo: aTransfer 
	
	transfer := aTransfer ! !


!TransferLeg methodsFor: 'transfer' stamp: 'Lucas 6/3/2019 15:09:36'!
transfer

	^transfer ! !


!TransferLeg methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:10:04'!
value

	^transfer value! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'TransferLeg class' category: #'Portfolio-Solucion'!
TransferLeg class
	instanceVariableNames: ''!

!TransferLeg class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:10:21'!
relatedTo: aTransfer 
	
	^self new initializeRelatedTo: aTransfer ! !


!classDefinition: #TransferDeposit category: #'Portfolio-Solucion'!
TransferLeg subclass: #TransferDeposit
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferDeposit methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:11:22'!
accept: aTransactionVisitor

	 ^ aTransactionVisitor visitTransferDeposit: self! !


!TransferDeposit methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:11:16'!
affectBalance: currentBalance

	^currentBalance + self value! !


!classDefinition: #TransferWithdraw category: #'Portfolio-Solucion'!
TransferLeg subclass: #TransferWithdraw
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!TransferWithdraw methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:12:00'!
accept: aTransactionVisitor

	 ^ aTransactionVisitor visitTransferWithdraw: self! !


!TransferWithdraw methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:12:09'!
affectBalance: currentBalance

	^currentBalance - self value! !


!classDefinition: #Withdraw category: #'Portfolio-Solucion'!
AccountTransaction subclass: #Withdraw
	instanceVariableNames: 'value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Withdraw methodsFor: 'initialization' stamp: 'HernanWilkinson 7/13/2011 18:46'!
initializeFor: aValue

	value := aValue ! !


!Withdraw methodsFor: 'value' stamp: 'HernanWilkinson 7/13/2011 18:33'!
value

	^ value! !


!Withdraw methodsFor: 'balance' stamp: 'HAW 5/25/2019 11:25:15'!
affectBalance: aBalance

	^aBalance - value! !


!Withdraw methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:48:12'!
accept: anAccountTransactionVisitor

	anAccountTransactionVisitor visitWithdraw: self! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Withdraw class' category: #'Portfolio-Solucion'!
Withdraw class
	instanceVariableNames: ''!

!Withdraw class methodsFor: 'instance creation' stamp: 'HernanWilkinson 7/13/2011 18:33'!
for: aValue

	^ self new initializeFor: aValue ! !


!classDefinition: #AccountTransactionVisitor category: #'Portfolio-Solucion'!
Object subclass: #AccountTransactionVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:22:38'!
visitDeposit: aDeposit  
	
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:22:43'!
visitTransferDeposit: aTransferDeposit  
	
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:22:49'!
visitTransferWithdraw: aTransferWithdraw 
	
	self subclassResponsibility ! !

!AccountTransactionVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:22:55'!
visitWithdraw: aWithdraw 
	
	self subclassResponsibility ! !


!classDefinition: #AccountSummary category: #'Portfolio-Solucion'!
AccountTransactionVisitor subclass: #AccountSummary
	instanceVariableNames: 'account lines'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountSummary methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:24:34'!
visitDeposit: aDeposit 
	
	lines add: 'Deposito por ', aDeposit value printString ! !

!AccountSummary methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:25:05'!
visitTransferDeposit: aTransferDeposit 
	
	^ lines add: 'Transferencia por ', aTransferDeposit value  printString ! !

!AccountSummary methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:25:10'!
visitTransferWithdraw: aTransferWithdraw 
	
	^ lines add: 'Transferencia por ', aTransferWithdraw value negated printString ! !

!AccountSummary methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:25:16'!
visitWithdraw: aWithdraw 

	lines add: 'Extraccion por ', aWithdraw value printString ! !


!AccountSummary methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:27:21'!
lines
	
	lines := OrderedCollection new.
	
	account visitTransactionsWith: self.
	
	^ lines! !


!AccountSummary methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:27:35'!
initializeFor: aReceptiveAccount 
	
	account := aReceptiveAccount 
	! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountSummary class' category: #'Portfolio-Solucion'!
AccountSummary class
	instanceVariableNames: ''!

!AccountSummary class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:27:50'!
for: aReceptiveAccount 

	^ self new initializeFor: aReceptiveAccount ! !


!classDefinition: #AccountTransferNetVisitor category: #'Portfolio-Solucion'!
AccountTransactionVisitor subclass: #AccountTransferNetVisitor
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:26:22'!
visitDeposit: aDeposit  ! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:26:38'!
visitTransferDeposit: aTransferDeposit  
	
	value := value + aTransferDeposit value! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:26:51'!
visitTransferWithdraw: aTransferWithdraw 
	
	value := value - aTransferWithdraw value! !

!AccountTransferNetVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:26:58'!
visitWithdraw: aWithdraw 
! !


!AccountTransferNetVisitor methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:28:17'!
initializeFor: aReceptiveAccount 
	
	account := aReceptiveAccount ! !


!AccountTransferNetVisitor methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:28:30'!
value 

	value := 0.
	
	account visitTransactionsWith: self.
	
	^ value  ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'AccountTransferNetVisitor class' category: #'Portfolio-Solucion'!
AccountTransferNetVisitor class
	instanceVariableNames: ''!

!AccountTransferNetVisitor class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:28:45'!
for: aReceptiveAccount 
	
	^self new initializeFor: aReceptiveAccount   ! !


!classDefinition: #BalanceVisitor category: #'Portfolio-Solucion'!
AccountTransactionVisitor subclass: #BalanceVisitor
	instanceVariableNames: 'account value'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!BalanceVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:29:31'!
visitDeposit: aDeposit 
	
	^ value := value + aDeposit value! !

!BalanceVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:29:37'!
visitTransferDeposit: aTransferDeposit 
	
	value := value + aTransferDeposit value! !

!BalanceVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:29:43'!
visitTransferWithdraw: aTransferWithdraw 
	
	value := value - aTransferWithdraw value! !

!BalanceVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:29:49'!
visitWithdraw: aWithdraw 
	
	value := value - aWithdraw value! !


!BalanceVisitor methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:30:01'!
value 

	value := 0.
	
	account visitTransactionsWith: self.
	
	^ value! !


!BalanceVisitor methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:29:04'!
initializeFor: aReceptiveAccount 
	
	account := aReceptiveAccount 
	! !

!BalanceVisitor methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:30:12'!
initializeOf: aReceptiveAccount 
	
	account := aReceptiveAccount ! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'BalanceVisitor class' category: #'Portfolio-Solucion'!
BalanceVisitor class
	instanceVariableNames: ''!

!BalanceVisitor class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:30:25'!
of: aReceptiveAccount 

	^ self new initializeOf: aReceptiveAccount ! !


!classDefinition: #AccountVisitor category: #'Portfolio-Solucion'!
Object subclass: #AccountVisitor
	instanceVariableNames: ''
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!AccountVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:19:26'!
visitPortfolio: aPortfolio
	
	self subclassResponsibility ! !

!AccountVisitor methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:19:33'!
visitReceptiveAccount: aReceptiveAccount 
	
	self subclassResponsibility ! !


!classDefinition: #PortfolioTreePrinter category: #'Portfolio-Solucion'!
AccountVisitor subclass: #PortfolioTreePrinter
	instanceVariableNames: 'portfolio accountNames lines spaces'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:20:51'!
visitPortfolio: aPortfolio
	
	lines add: (self lineFor: aPortfolio).
	spaces := spaces + 1.
	aPortfolio visitAccountsWith: self.
	spaces := spaces - 1! !

!PortfolioTreePrinter methodsFor: 'visiting' stamp: 'Lucas 6/3/2019 15:21:02'!
visitReceptiveAccount: aReceptiveAccount 
	
	lines add: (self lineFor: aReceptiveAccount)! !


!PortfolioTreePrinter methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:21:11'!
initializeOf: aPortfolio namingAccountsWith: aDictionary 
	
	portfolio := aPortfolio.
	accountNames := aDictionary ! !


!PortfolioTreePrinter methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:21:20'!
lines
	
	lines := OrderedCollection new.
	spaces := 0.
	
	portfolio accept: self.
	
	^ lines ! !


!PortfolioTreePrinter methodsFor: 'evaluating - private' stamp: 'Lucas 6/3/2019 15:21:27'!
lineFor: aSummarizingAccount

	| stream |
	
	stream := WriteStream on: String new.
	spaces timesRepeat: [ stream nextPut: $ .].
	stream nextPutAll: (accountNames at: aSummarizingAccount).
	
	^ stream contents! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'PortfolioTreePrinter class' category: #'Portfolio-Solucion'!
PortfolioTreePrinter class
	instanceVariableNames: ''!

!PortfolioTreePrinter class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:21:42'!
of: aPortfolio namingAccountsWith: aDictionary 
	
	^ self new initializeOf: aPortfolio namingAccountsWith: aDictionary 
	! !


!classDefinition: #Transfer category: #'Portfolio-Solucion'!
Object subclass: #Transfer
	instanceVariableNames: 'value depositLeg withdrawLeg'
	classVariableNames: ''
	poolDictionaries: ''
	category: 'Portfolio-Solucion'!

!Transfer methodsFor: 'initialization' stamp: 'Lucas 6/3/2019 15:35:28'!
initializeOf: anAmount 
	
	value := anAmount.
	depositLeg := TransferDeposit relatedTo: self .
	withdrawLeg := TransferWithdraw relatedTo: self 
	! !


!Transfer methodsFor: 'evaluating' stamp: 'Lucas 6/3/2019 15:07:35'!
value

	^value ! !


!Transfer methodsFor: 'legs' stamp: 'Lucas 6/3/2019 15:07:57'!
depositLeg
	
	^depositLeg! !

!Transfer methodsFor: 'legs' stamp: 'Lucas 6/3/2019 15:08:04'!
withdrawLeg
	
	^withdrawLeg! !

"-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- "!

!classDefinition: 'Transfer class' category: #'Portfolio-Solucion'!
Transfer class
	instanceVariableNames: ''!

!Transfer class methodsFor: 'instance creation' stamp: 'Lucas 6/3/2019 15:06:58'!
of: anAmount 

	^self new initializeOf: anAmount ! !


!Transfer class methodsFor: 'registering' stamp: 'Lucas 6/3/2019 15:06:46'!
register: anAmount from: fromAccount to: toAccount 

	|transfer |
	
	transfer := self of: anAmount.
	fromAccount register: transfer withdrawLeg.
	toAccount register: transfer depositLeg.
	
	^transfer! !
