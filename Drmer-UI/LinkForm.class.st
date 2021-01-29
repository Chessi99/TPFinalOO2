Class {
	#name : #LinkForm,
	#superclass : #ComposableModel,
	#instVars : [
		'link',
		'action',
		'graphic',
		'listItems',
		'listOrigin',
		'listDestination',
		'originLabel',
		'destinationLabel',
		'levelDestinationLabel',
		'levelOriginLabel',
		'levelOrigin',
		'levelDestination',
		'levelItems',
		'sourcesLabel',
		'references',
		'submitButton',
		'addSourceButton',
		'buttonAssumption',
		'buttonExperience',
		'buttonOwn',
		'buttonUnknown',
		'buttonReference',
		'inputWeight',
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
	|labelsWidth fontWidth rowHeight|
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	labelsWidth := fontWidth * 5.
	rowHeight := self inputTextHeight.
	^ SpecLayout  composed
		newColumn: [ :c |
			c
			newRow: [ :row |  
				row
				newColumn: [ :column | 
							column add: #originLabel height: self inputTextHeight.
							column add: #listOrigin height: 110.
							column add: #levelOriginLabel height: self inputTextHeight.
							column add: #levelOrigin height: 55.
							
							
				].
				row		
					newColumn: [ :column | 
							column add: #destinationLabel height: self inputTextHeight.
							column add: #listDestination height: 110.
							column add: #labelLevelDest height: self inputTextHeight.
							column add: #levelDestination height: 55.
							
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
			c newRow: [ :row |
					row add: #labelWeight right: labelsWidth.
					row add: #inputWeight .
				]height: rowHeight .
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

{ #category : #sending }
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

{ #category : #sending }
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
	self initializeReferences.
	listItems :=OrderedCollection new .
	levelItems:= OrderedCollection with:1 with:-1  with: 0.
	super initialize.
]

{ #category : #initialization }
LinkForm >> initializeFocusOrder [
	self focusOrder
		add: originLabel;
		add: listOrigin;
		add: buttonAssumption;
		add: destinationLabel;
		add: listDestination;
		add: levelDestinationLabel;
		add: levelOriginLabel;
		add: listDestination;
		add: listOrigin;
		add: labelWeight
]

{ #category : #initialization }
LinkForm >> initializeLists [

	levelDestination := self newList.
	levelOrigin := self newList.
	levelDestination beSingleSelection;items: levelItems.
	levelOrigin beSingleSelection;items: levelItems.
	listOrigin := self newList.
	listDestination := self newList.
	listOrigin beSingleSelection; items: listItems.
	listDestination beSingleSelection;items: listItems
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
LinkForm >> initializeReferences [
	references := OrderedCollection new.
]

{ #category : #initialization }
LinkForm >> initializeSelect [
	self initializeLists.
	originLabel := self newLabel label: 'Select origin:'.
	destinationLabel := self newLabel label: 'Select destination:'.
	levelOriginLabel := self newLabel label: 'Level at origin:'.
	levelDestinationLabel := self newLabel label: 'Level at destination:'.
]

{ #category : #initialization }
LinkForm >> initializeSubminButton [
	self submitButton action: [ 
		self sendLinkToGraphic.
		self perform: action;initializeReferences .
		self sendDrawLink.
		].	

]

{ #category : #initialization }
LinkForm >> initializeWidgets [
	self initializeRadio.
	self initializeSelect.
	labelWeight := self newLabel label: 'Weight:'.
	inputWeight := self newTextInput autoAccept: true.
	inputWeight text: 1.
	submitButton := self newButton label: 'Submit'.
	addSourceButton := self newButton label: 'Add reference'.
	self initializeFocusOrder
]

{ #category : #accessing }
LinkForm >> inputWeight [
	^ inputWeight
]

{ #category : #accessing }
LinkForm >> labelLevelDest [
	^ levelDestinationLabel
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
LinkForm >> levelOriginLabel [
	^ levelOriginLabel 
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

{ #category : #sending }
LinkForm >> own [
	graphic sourceOwn: link
]

{ #category : #sending }
LinkForm >> reference [
	graphic references: references link: link. 
]

{ #category : #initialization }
LinkForm >> sendDrawLink [
graphic drawLink: link
]

{ #category : #sending }
LinkForm >> sendLink [
link:= graphic addLink: (listOrigin selectedItem) 
					destination:(listDestination selectedItem) 
					levelOrigin:levelOrigin selectedItem 
					levelDestination:levelDestination selectedItem
					weight: self weightInput .
]

{ #category : #sending }
LinkForm >> sendLinkToGraphic [
link:= graphic addLink: (listOrigin selectedItem) 
					destination:(listDestination selectedItem) 
					levelOrigin:levelOrigin selectedItem 
					levelDestination:levelDestination selectedItem
					weight: self weightInput .
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
LinkForm >> sourcesLabel [
	^ sourcesLabel 
]

{ #category : #accessing }
LinkForm >> submitButton [
	^ submitButton
]

{ #category : #api }
LinkForm >> title [ 
	^'New link'
]

{ #category : #sending }
LinkForm >> unknown [
	graphic sourceUnknown: link
]

{ #category : #initialization }
LinkForm >> weightInput [
	(inputWeight text == '') 
	ifTrue: [ ^1 ].
	^(inputWeight text)asInteger
]
