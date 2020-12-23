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
		'submitButton'
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
	fontWidth := (StandardFonts defaultFont widthOfString: 'M').
	labelsWidth := fontWidth * 8.
	rowHeight := self inputTextHeight.
	checkboxWidth := fontWidth * 2.
	
	^ SpecLayout composed
		newColumn: [ :col | 

			col newRow: [ :row | 
				row add: #attributeLabel right: labelsWidth.
				row add: #attributeTextInput ]
			height: rowHeight.
		
			col newRow: [ :row | 
				row add: #elementLabel right: labelsWidth.
				row add: #elementTextInput ]
			height: rowHeight.


		col newRow: [ :row | 
						row  add: #isExternalInput right: checkboxWidth.
						row add: #isExternaLabel ]
			height: rowHeight*2.




	col newRow: [ :row | 
				row add: #submitButton.]
			height: rowHeight*1.3.

		"fill the rest of the space"
		col newRow: [ :row |  ] ];
			
		yourself.	
]

{ #category : #accessing }
FactorForm >> attributeLabel [
	^ attributeLabel
]

{ #category : #accessing }
FactorForm >> attributeLabel: anObject [
	attributeLabel := anObject
]

{ #category : #accessing }
FactorForm >> attributeTextInput [
	^ attributeTextInput
]

{ #category : #accessing }
FactorForm >> attributeTextInput: anObject [
	attributeTextInput := anObject
]

{ #category : #accessing }
FactorForm >> elementLabel [
	^ elementLabel
]

{ #category : #accessing }
FactorForm >> elementLabel: anObject [
	elementLabel := anObject
]

{ #category : #accessing }
FactorForm >> elementTextInput [
	^ elementTextInput
]

{ #category : #accessing }
FactorForm >> elementTextInput: anObject [
	elementTextInput := anObject
]

{ #category : #accessing }
FactorForm >> graphic: aGraphic [
graphic := aGraphic 
]

{ #category : #initialization }
FactorForm >> initializePresenter [
	
	self submitButton action: [graphic addFactorWithAttribute:'time'  element: 'time-to-marker'].	
]

{ #category : #initialization }
FactorForm >> initializeWidgets [

	attributeLabel  := self newLabel label: 'attribute:'.
	attributeTextInput := self newTextInput autoAccept: true.

	elementLabel := self newLabel label: 'element:'.
	elementTextInput := self newTextInput autoAccept: true.
	elementTextInput ghostText: 'empty'.
	
	isExternaLabel := self newLabel label: 'isExternal'.
	isExternalInput := self newCheckBox state: true.

	submitButton := self newButton label: 'Submit'.
	
	self focusOrder 
		add: attributeTextInput;
		add: elementTextInput;
		add: isExternalInput.
		
]

{ #category : #accessing }
FactorForm >> isExternaLabel [
	^ isExternaLabel
]

{ #category : #accessing }
FactorForm >> isExternaLabel: anObject [
	isExternaLabel := anObject
]

{ #category : #accessing }
FactorForm >> isExternalInput [
	^ isExternalInput
]

{ #category : #accessing }
FactorForm >> isExternalInput: anObject [
	isExternalInput := anObject
]

{ #category : #accessing }
FactorForm >> submitButton [
	^ submitButton
]

{ #category : #accessing }
FactorForm >> submitButton: anObject [
	submitButton := anObject
]
