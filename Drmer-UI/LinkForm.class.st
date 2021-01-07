Class {
	#name : #LinkForm,
	#superclass : #ComposablePresenter,
	#instVars : [
		'link',
		'action',
		'graphic',
		'listItems',
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
		'references',
		'submitButton',
		'addSourceButton',
		'buttonAssumption',
		'buttonExperience',
		'buttonOwn',
		'buttonUnknown',
		'buttonReference',
		'weight',
		'labelWeight',
		'groupRadio'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
LinkForm class >> create: graphic [

^(self new)graphic: graphic .
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
			newRow: [ :row | 
				row add: #buttonAssumption .
				row add: #buttonExperience .
				row add: #buttonOwn .
				row add: #buttonUnknown.
				row add: #buttonReference ]
			height: 40.
			c
			newRow: [:row |
				row add: #addSourceButton .
				row add: #submitButton 
				
				]
				height: 25				
							
		]
]

{ #category : #initialization }
LinkForm >> addReferenceWithCitation:citation label:label [ 
	references add: (DrmReference labeled: label citation:citation) 
]

{ #category : #accessing }
LinkForm >> addSourceButton [
	^ addSourceButton
]

{ #category : #'as yet unclassified' }
LinkForm >> assumption [
	graphic sourceAssumption: link
]

{ #category : #accessing }
LinkForm >> buttonAssumption [
	^ buttonAssumption
]

{ #category : #accessing }
LinkForm >> buttonExperience [
	^ buttonExperience
]

{ #category : #accessing }
LinkForm >> buttonOwn [
	^ buttonOwn
]

{ #category : #accessing }
LinkForm >> buttonReference [
	^ buttonReference
]

{ #category : #accessing }
LinkForm >> buttonUnknown [
	^ buttonUnknown
]

{ #category : #accessing }
LinkForm >> destinationLabel [
	^ destinationLabel
]

{ #category : #'as yet unclassified' }
LinkForm >> experience [
	graphic sourceExperience: link
]

{ #category : #accessing }
LinkForm >> graphic:aGraphic [
	graphic := aGraphic .
	"self factors: (graphic factorEllipses collect: [:factor | factor model])"
	self loadListItems.
]

{ #category : #initialization }
LinkForm >> initialize [
	action:= #assumption.
	references := OrderedCollection new.
	listItems :=OrderedCollection new .
	levelItems:= OrderedCollection with:1 with:-1  with: 0.
	super initialize.
]

{ #category : #initialization }
LinkForm >> initializePresenter [
	
	self initializeSubminButton.	
	self addSourceButton action:[(ReferenceForm withLinkForm: self )openWithSpec ].
	self buttonReference whenActivatedDo: [ self addSourceButton enable. action:= #reference].
	self buttonReference whenDeactivatedDo:  [ self addSourceButton disable  ].
	self buttonAssumption whenActivatedDo: [ action:= #assumption].
	self buttonExperience  whenActivatedDo: [ action:= #experience ].
	self buttonOwn whenActivatedDo: [ action:= #own ].
	self buttonUnknown whenActivatedDo: [ action:= #unknown ].
]

{ #category : #initialization }
LinkForm >> initializeRadio [
	buttonAssumption := self instantiate: RadioButtonPresenter.
	buttonExperience := self instantiate: RadioButtonPresenter.
	buttonOwn := self instantiate: RadioButtonPresenter.
	buttonUnknown := self instantiate: RadioButtonPresenter.
	buttonReference := self instantiate: RadioButtonPresenter.
	buttonAssumption label: 'Assumption'.
	buttonExperience label: 'Experience'.
	buttonOwn label: 'Own Investigation'.
	buttonUnknown label: 'Unkonwn'.
	buttonReference  label: 'Reference'.
	self setGroup .

]

{ #category : #initialization }
LinkForm >> initializeSelect [

	originLabel  := self newLabel  label: 'Select origin:'.
	destinationLabel  := self newLabel label: 'Select destination:'.
	labelLevelOri   := self newLabel label: 'Level at origin:'.
	labelLevelDest   := self newLabel label: 'Level at destination:'.
	
	levelDestination := self newList.	
	levelOrigin  := self newList.
	
	levelDestination  beSingleSelection .
	levelOrigin beSingleSelection  .
	
	levelDestination items: levelItems. 
	levelOrigin items: levelItems.
	
	listOrigin := self newList.
	listDestination := self newList.
	listOrigin beSingleSelection	.
	listOrigin items: listItems .
	listDestination beSingleSelection  .
	listOrigin items: listItems .
]

{ #category : #initialization }
LinkForm >> initializeSubminButton [
	self submitButton action: [ 
		link:= graphic addLink: (listOrigin selectedItem) 
					destination:(listDestination selectedItem) 
					levelOrigin:levelOrigin selectedItem 
					levelDestination:levelDestination selectedItem.
		self perform: action.
		graphic drawLink: link
		].	

]

{ #category : #initialization }
LinkForm >> initializeWidgets [
	"podtia resolverse con un singleton, y a ese singleton que seria el controlador perirle los elementos q necesito"

	self initializeRadio.
	self initializeSelect .
	submitButton := self newButton label: 'Submit'.
	addSourceButton := self newButton label: 'Add source'.
	
	self focusOrder
		add: originLabel;
		add: listOrigin;
		add: buttonAssumption;
		add: destinationLabel;
		add: listDestination;
		add: labelLevelDest;
		add: labelLevelOri;
		add: listDestination;
		add: listOrigin.
		
]

{ #category : #accessing }
LinkForm >> labelLevelDest [
	^ labelLevelDest
]

{ #category : #accessing }
LinkForm >> labelLevelOri [
	^ labelLevelOri
]

{ #category : #accessing }
LinkForm >> labelSources [
	^ labelSources
]

{ #category : #accessing }
LinkForm >> labelWeight [
	^labelWeight 
]

{ #category : #accessing }
LinkForm >> levelDestination [
	^ levelDestination
]

{ #category : #accessing }
LinkForm >> levelItems [
	^ levelItems
]

{ #category : #accessing }
LinkForm >> levelOrigin [
	^ levelOrigin
]

{ #category : #accessing }
LinkForm >> listDestination [
	^ listDestination
]

{ #category : #accessing }
LinkForm >> listItems [
	^ listItems
]

{ #category : #accessing }
LinkForm >> listOrigin [
	^ listOrigin
]

{ #category : #accessing }
LinkForm >> loadListItems [
	listOrigin items: graphic elements ; displayBlock:[:each | each  asString ] .
	listDestination items:  graphic elements; displayBlock:[:each | each  asString ].
	listOrigin refreshListItems .
	listDestination  refreshListItems  .
]

{ #category : #accessing }
LinkForm >> originLabel [
	^ originLabel
]

{ #category : #'as yet unclassified' }
LinkForm >> own [
	graphic sourceOwn: link
]

{ #category : #'as yet unclassified' }
LinkForm >> reference [
	graphic addReferences: references link: link. 
]

{ #category : #initialization }
LinkForm >> setFocus [
	
	self focusOrder
		add: buttonAssumption;
		add: buttonExperience;
		add: buttonOwn;
		add: buttonUnknown;
		add: buttonReference .
]

{ #category : #initialization }
LinkForm >> setGroup [
groupRadio:=RadioButtonGroupPresenter new
		addRadioButton: buttonAssumption;
		addRadioButton: buttonExperience;
		addRadioButton: buttonOwn;
		addRadioButton: buttonUnknown;
		addRadioButton: buttonReference ;
		default: buttonAssumption .
]

{ #category : #accessing }
LinkForm >> submitButton [
	^ submitButton
]

{ #category : #api }
LinkForm >> title [ 
	^'New link'
]

{ #category : #'as yet unclassified' }
LinkForm >> unknown [
	graphic sourceUnknown: link
]

{ #category : #accessing }
LinkForm >> weight [
	^ weight
]
