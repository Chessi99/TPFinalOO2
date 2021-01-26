Class {
	#name : #SupportForm,
	#superclass : #ComposableModel,
	#instVars : [
		'description',
		'submitButton',
		'graphic',
		'descriptionLabel'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
SupportForm class >> create:aGraphic [ 
	^(self new)graphic:aGraphic.
]

{ #category : #specs }
SupportForm class >> defaultSpec [
	<spec: #default>
	| fontWidth labelsWidth rowHeight  |
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	labelsWidth := fontWidth * 5.
	rowHeight := self inputTextHeight.
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				newRow: [ :row | 
					row add: #descriptionLabel  right: labelsWidth.
					row add: #description  ]
				height: rowHeight .
			col
				newRow: [ :row | row add: #submitButton ] 
				height: rowHeight * 1.3.
			
			
		]
		origin: 0 @ 0.12 corner: 1 @ 0.9;	
		
	yourself
]

{ #category : #accessing }
SupportForm >> description [
	^ description
]

{ #category : #accessing }
SupportForm >> descriptionLabel [
	^ descriptionLabel
]

{ #category : #accessing }
SupportForm >> graphic: anObject [
	graphic := anObject
]

{ #category : #initialization }
SupportForm >> initializePresenter [
	
	self submitButton action: [ graphic addSupport: self description text ].
]

{ #category : #initialization }
SupportForm >> initializeWidgets [
	descriptionLabel := self newLabel label: 'Description: '.
	description := self newTextInput autoAccept: true.
	submitButton := self newButton label: 'Submit'.
	self focusOrder
		add: descriptionLabel;
		add: submitButton
]

{ #category : #accessing }
SupportForm >> submitButton [
	^ submitButton
]
