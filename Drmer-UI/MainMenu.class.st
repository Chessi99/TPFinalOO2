Class {
	#name : #MainMenu,
	#superclass : #ComposableModel,
	#instVars : [
		'buttonAddFactor',
		'buttonAddLink',
		'buttonOpenGaph',
		'screen',
		'graphic',
		'buttonAddSupport',
		'factorsList',
		'supportsList',
		'linkList',
		'factorsLabel',
		'supportsLabel',
		'linksLabel',
		'formLabel'
	],
	#category : #'Drmer-UI'
}

{ #category : #specs }
MainMenu class >> defaultSpec [
	^ SpecLayout composed
		newColumn: [ :c | 
			c
				newRow: [ :row | 
					row
						newColumn: [ :column | 
							column add: #factorsLabel height: self inputTextHeight.
							column add: #factorsList height: 170.
							column add: #buttonAddFactor height: 25 ].
					row
						newColumn: [ :column | 
							column add: #supportsLabel height: self inputTextHeight.
							column add: #supportsList height: 170.
							column add: #buttonAddSupport height: 25 ].
					row
						newColumn: [ :column | 
							column add: #linksLabel height: self inputTextHeight.
							column add: #linkList height: 170.
							column add: #buttonAddLink height: 25 ] ].
			c newRow: [ :row | row add: #buttonOpenGaph ] height: 30.
			c newRow: [ :row | row add: #formLabel ] height: 30.
			c newRow: [ :row | row add: #screen ] height: 325 ]
]

{ #category : #accessing }
MainMenu >> buttonAddFactor [
	^ buttonAddFactor
]

{ #category : #accessing }
MainMenu >> buttonAddLink [
	^ buttonAddLink
]

{ #category : #accessing }
MainMenu >> buttonAddSupport [
 ^buttonAddSupport 
]

{ #category : #accessing }
MainMenu >> buttonOpenGaph [
	^ buttonOpenGaph
]

{ #category : #updating }
MainMenu >> changeForm: aForm formLabel:aText [ 
	screen := aForm.
	formLabel label: aText.
	self reloadForm
]

{ #category : #initialization }
MainMenu >> extent [ 
	^ 600@800
]

{ #category : #accessing }
MainMenu >> factorsLabel [
	^ factorsLabel
]

{ #category : #accessing }
MainMenu >> factorsList [
	^ factorsList
]

{ #category : #accessing }
MainMenu >> formLabel [
	^formLabel
]

{ #category : #initialization }
MainMenu >> initializeButtonAdd [
	buttonAddFactor
		action: [ 
			self changeForm: (FactorForm create: graphic) formLabel: 'New Form '.
		].
	buttonAddLink
		action: [
			self changeForm: (LinkForm create: graphic) formLabel: 'New Link '.
		].
	buttonAddSupport
		action: [
			self changeForm: (SupportForm  create: graphic) formLabel: 'New Support '. 
		]
]

{ #category : #initialization }
MainMenu >> initializeGraphic [
		graphic := GraphicDrm new.
		graphic addDependent:self.

]

{ #category : #initialization }
MainMenu >> initializeLabels [
	screen := self newLabel.
	buttonAddFactor := self newButton label: 'Add Factor'.
	buttonAddLink := self newButton label: 'Add Link'.
	buttonAddSupport  := self newButton label: 'Add Support'.
	buttonOpenGaph := self newButton label: 'Open Graph'.
	factorsLabel := self newLabel  label:'Factors:'.
	supportsLabel := self newLabel  label:'Supports:'.
	linksLabel := self newLabel  label:'Links:'.
	formLabel := self newLabel  label:'New Factor'.

]

{ #category : #initialization }
MainMenu >> initializeLists [ 
	supportsList  := self newList.
	factorsList  := self newList.
	linkList  := self newList.
	supportsList  beSingleSelection	.
	linkList  beSingleSelection .
	factorsList  beSingleSelection  .
	
]

{ #category : #initialization }
MainMenu >> initializePresenter [
	self initializeButtonAdd.
	self initializePresenterLists.
	buttonOpenGaph action: [ graphic open ]
]

{ #category : #initialization }
MainMenu >> initializePresenterLists [
	factorsList doubleClickAction:[
			(self changeForm: (ModifiedFactorForm createWithGraphic: graphic
						factor: factorsList selectedItem) 
						formLabel: 'Modified form ',factorsList selectedItem asString )].
	supportsList doubleClickAction:[
		(self changeForm: (ModifiedSupportForm createWithGraphic: graphic
				support: supportsList selectedItem) 
				formLabel: 'Modified Support ',supportsList selectedItem asString )].
	linkList doubleClickAction:[
	(self changeForm: (ModifiedLinkForm createWithGraphic: graphic
				link: linkList selectedItem) 
				formLabel: 'Modified Link ', linkList selectedItem asString)].
]

{ #category : #initialization }
MainMenu >> initializeWidgets [
	self initializeLists.
	self initializeLabels.
	self initializeGraphic.
	screen := FactorForm create: graphic.
	self setFocus
]

{ #category : #accessing }
MainMenu >> linkList [
	^ linkList
]

{ #category : #accessing }
MainMenu >> linksLabel [
	^ linksLabel
]

{ #category : #updating }
MainMenu >> reloadForm [
			self needRebuild: false.
			self buildWithSpec
]

{ #category : #accessing }
MainMenu >> screen [
	^ screen
]

{ #category : #initialization }
MainMenu >> setFocus [
	self focusOrder
		add: factorsLabel;
		add: supportsLabel;
		add: linksLabel;
		add: supportsList;
		add: linkList;
		add: factorsList;
		add: buttonAddFactor;
		add: buttonAddLink;
		add: buttonAddSupport;
		add: buttonOpenGaph
]

{ #category : #accessing }
MainMenu >> supportsLabel [
	^ supportsLabel
]

{ #category : #accessing }
MainMenu >> supportsList [
	^ supportsList
]

{ #category : #api }
MainMenu >> title [ 
	^ 'Main Menu'
]

{ #category : #updating }
MainMenu >> update:object [
	"actulizo los listados cuando cambia el grafico, utiliza observer".
	self updateItems:graphic factors keys  forList: factorsList.
	self updateItems:graphic links keys  forList: linkList .
	self updateItems:graphic supports keys  forList: supportsList  .

]

{ #category : #updating }
MainMenu >> updateItems:items forList:aList [
aList items: items; displayBlock:[:each | each asString ].
aList refreshListItems;resetSelection.

]
