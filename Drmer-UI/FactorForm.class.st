Class {
	#name : #FactorForm,
	#superclass : #ComposableModel,
	#instVars : [
		'graphic',
		'attributeLabel',
		'attributeTextInput',
		'elementLabel',
		'elementTextInput',
		'isExternaLabel',
		'isExternalInput',
		'submitButton',
		'screen'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
FactorForm class >> create: aGraphic [
	^ (self new) graphic: aGraphic. 
]

{ #category : #specs }
FactorForm class >> defaultSpec [
	<spec: #default>
	| fontWidth labelsWidth rowHeight checkboxWidth |
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	labelsWidth := fontWidth * 5.
	rowHeight := self inputTextHeight.
	checkboxWidth := fontWidth * 1.
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				newRow: [ :row | 
					row add: #attributeLabel right: labelsWidth.
					row add: #attributeTextInput ]
				height: rowHeight.
			col
				newRow: [ :row | 
					row add: #elementLabel right: labelsWidth.
					row add: #elementTextInput ]
				height: rowHeight.
			col
				newRow: [ :row | 
					row add: #isExternalInput right: checkboxWidth.
					row add: #isExternaLabel ]
				height: rowHeight * 3.
			col
				newRow: [ :row | row add: #submitButton ]
				height: rowHeight * 1.3 ]
			origin: 0 @ 0.12
			corner: 1 @ 0.9;
		yourself
]

{ #category : #accessing }
FactorForm >> attributeLabel [
	^ attributeLabel
]

{ #category : #accessing }
FactorForm >> attributeTextInput [
	^ attributeTextInput
]

{ #category : #accessing }
FactorForm >> elementLabel [
	^ elementLabel
]

{ #category : #accessing }
FactorForm >> elementTextInput [
	^ elementTextInput
]

{ #category : #accessing }
FactorForm >> graphic: aGraphic [
graphic := aGraphic 
]

{ #category : #initialization }
FactorForm >> initializePresenter [
	
	self submitButton action: [graphic addFactorWithAttribute: (self attributeTextInput text)  element:(self elementTextInput text) isExternal:(self isExternalInput state).
		].	
]

{ #category : #initialization }
FactorForm >> initializeWidgets [
	self setFormFactor.
	submitButton := self newButton label: 'Submit'.
	self setFocus
]

{ #category : #accessing }
FactorForm >> isExternaLabel [
	^ isExternaLabel
]

{ #category : #accessing }
FactorForm >> isExternalInput [
	^ isExternalInput
]

{ #category : #initialization }
FactorForm >> setFocus [
	self focusOrder
		add: attributeTextInput;
		add: elementTextInput;
		add: isExternalInput
]

{ #category : #initialization }
FactorForm >> setFormFactor [
	attributeLabel := self newLabel label: 'attribute:'.
	attributeTextInput := self newTextInput autoAccept: true.
	elementLabel := self newLabel label: 'element:'.
	elementTextInput := self newTextInput autoAccept: true.
	elementTextInput ghostText: 'empty'.
	isExternaLabel := self newLabel label: 'isExternal'.
	isExternalInput := self newCheckBox state: false
]

{ #category : #accessing }
FactorForm >> submitButton [
	^ submitButton
]
