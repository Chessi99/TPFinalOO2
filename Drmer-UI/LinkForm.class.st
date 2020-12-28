Class {
	#name : #LinkForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'factors',
		'listOrigin',
		'listDestination',
		'originLabel',
		'destinationLabel',
		'labelLevelDest',
		'labelLevelOri',
		'levelOrigin',
		'levelDestination',
		'levelItems',
		'labelSources',
		'sources',
		'submitButton',
		'addSourceButton'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
LinkForm class >> create: factors [

^(self new)factors: factors .
]

{ #category : #specs }
LinkForm class >> defaultSpec [
	
	^ SpecLayout  composed
		newColumn: [ :c |
			c
			newRow: [ :row |  
				row
				newColumn: [ :column | 
							column add: #originLabel height: self inputTextHeight.
							column add: #listOrigin height: 130.
							column add: #labelLevelOri height: self inputTextHeight.
							column add: #levelOrigin height: 50.
							
							
				].
				row		
					newColumn: [ :column | 
							column add: #destinationLabel height: self inputTextHeight.
							column add: #listDestination height: 130.
							column add: #labelLevelDest height: self inputTextHeight.
							column add: #levelDestination height: 50.
							
							];
						yourself.
					].
			c
			newRow: [:row |
				row add: #addSourceButton .
				row add: #submitButton 
				
				]
				height: 25				
							
		]
]

{ #category : #accessing }
LinkForm >> addSourceButton [
	^ addSourceButton
]

{ #category : #accessing }
LinkForm >> addSourceButton: anObject [
	addSourceButton := anObject
]

{ #category : #accessing }
LinkForm >> destinationLabel [
	^ destinationLabel
]

{ #category : #accessing }
LinkForm >> destinationLabel: anObject [
	destinationLabel := anObject
]

{ #category : #accessing }
LinkForm >> factors: allFactors [
	factors := allFactors collect: [ :factor | (factor attribute , ' of ' , factor element) ].
	listOrigin items: factors .
	listDestination items: factors .
	listOrigin refreshListItems .
	listDestination  refreshListItems  .
]

{ #category : #initialization }
LinkForm >> initialize [
	
	factors:=OrderedCollection new .
	levelItems:= OrderedCollection with:1 with:-1  with: 0.
	super initialize.
]

{ #category : #initialization }
LinkForm >> initializePresenter [
	
'	self submitButton action: [].	
	
	self addSourceButton action:[].'.
]

{ #category : #initialization }
LinkForm >> initializeWidgets [

	"podtia resolverse con un singleton, y a ese singleton que seria el controlador perirle los elementos q necesito"

	originLabel  := self newLabel  label: 'Select origin:'.
	destinationLabel  := self newLabel label: 'Select destination:'.
	labelLevelOri   := self newLabel label: 'Level at origin:'.
	labelLevelDest   := self newLabel label: 'Level at destination:'.
	
	levelDestination := self newList.	
	levelOrigin  := self newList.
	
	levelDestination  beMultipleSelection.
	levelOrigin beMultipleSelection .
	
	levelDestination items: levelItems. 
	levelOrigin items: levelItems.
	
	listOrigin := self newList.
	listDestination := self newList.
	listOrigin beMultipleSelection.
	listOrigin items: factors.
	listDestination beMultipleSelection .
	listOrigin items: factors.
	submitButton := self newButton label: 'Submit'.
	addSourceButton  := self newButton label: 'Add source'.	
	
	self focusOrder 
		add: originLabel ;
		add: listOrigin ; 
		add: destinationLabel ;
		add: listDestination ;
		add: labelLevelDest ;
		add: labelLevelOri ;
		add: listDestination ;
		add: listOrigin .
]

{ #category : #accessing }
LinkForm >> labelLevelDest [
	^ labelLevelDest
]

{ #category : #accessing }
LinkForm >> labelLevelDest: anObject [
	labelLevelDest := anObject
]

{ #category : #accessing }
LinkForm >> labelLevelOri [
	^ labelLevelOri
]

{ #category : #accessing }
LinkForm >> labelLevelOri: anObject [
	labelLevelOri := anObject
]

{ #category : #accessing }
LinkForm >> labelSources [
	^ labelSources
]

{ #category : #accessing }
LinkForm >> labelSources: anObject [
	labelSources := anObject
]

{ #category : #accessing }
LinkForm >> levelDestination [
	^ levelDestination
]

{ #category : #accessing }
LinkForm >> levelDestination: anObject [
	levelDestination := anObject
]

{ #category : #accessing }
LinkForm >> levelOrigin [
	^ levelOrigin
]

{ #category : #accessing }
LinkForm >> levelOrigin: anObject [
	levelOrigin := anObject
]

{ #category : #accessing }
LinkForm >> listDestination [
	^ listDestination
]

{ #category : #accessing }
LinkForm >> listOrigin [
	^ listOrigin
]

{ #category : #accessing }
LinkForm >> originLabel [
	^ originLabel
]

{ #category : #accessing }
LinkForm >> originLabel: anObject [
	originLabel := anObject
]

{ #category : #accessing }
LinkForm >> sources [
	^ sources
]

{ #category : #accessing }
LinkForm >> sources: anObject [
	sources := anObject
]

{ #category : #accessing }
LinkForm >> submitButton [
	^ submitButton
]

{ #category : #accessing }
LinkForm >> submitButton: anObject [
	submitButton := anObject
]

{ #category : #api }
LinkForm >> title [ 
	^'New link'
]
