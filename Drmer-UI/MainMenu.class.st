Class {
	#name : #MainMenu,
	#superclass : #ComposableModel,
	#instVars : [
		'buttonAddFactor',
		'buttonAddLink',
		'buttonModifiedFactor',
		'buttonModifiedLink',
		'screen',
		'graphic'
	],
	#category : #'Drmer-UI'
}

{ #category : #specs }
MainMenu class >> defaultSpec [
	^ SpecLayout composed
		newRow: [ :row | 
			row
				add: #buttonAddFactor;
				add: #buttonAddLink;
				add: #buttonModifiedFactor;
				add: #buttonModifiedLink]
			origin: 0 @ 0
			corner: 1 @ 0.7;
		newRow: [ :row | row add: #screen ] origin: 0 @ 0.7 corner: 1 @ 1;
		yourself
]

{ #category : #accessing }
MainMenu >> buttonAddFactor [
	^ buttonAddFactor
]

{ #category : #accessing }
MainMenu >> buttonAddFactor: anObject [
	buttonAddFactor := anObject
]

{ #category : #accessing }
MainMenu >> buttonAddLink [
	^ buttonAddLink
]

{ #category : #accessing }
MainMenu >> buttonAddLink: anObject [
	buttonAddLink := anObject
]

{ #category : #accessing }
MainMenu >> buttonModifiedFactor [
	^ buttonModifiedFactor
]

{ #category : #accessing }
MainMenu >> buttonModifiedFactor: anObject [
	buttonModifiedFactor := anObject
]

{ #category : #accessing }
MainMenu >> buttonModifiedLink [
	^ buttonModifiedLink
]

{ #category : #accessing }
MainMenu >> buttonModifiedLink: anObject [
	buttonModifiedLink := anObject
]

{ #category : #api }
MainMenu >> extent [
	^ 400 @ 100
]

{ #category : #initialization }
MainMenu >> initialize [ 
	super initialize.
	graphic := GraphicDrm new.
	graphic reload.
]

{ #category : #initialization }
MainMenu >> initializePresenter [
	buttonAddFactor  action: [ 
		screen label: buttonAddFactor  label.
		(FactorForm create: graphic ) openWithSpec
		
											].
	buttonAddLink  action: [ screen label: buttonAddLink  label ].
	buttonModifiedFactor  action: [ screen label: buttonModifiedFactor  label ].
	buttonModifiedLink   action: [ screen label: buttonModifiedLink  label ]
]

{ #category : #initialization }
MainMenu >> initializeWidgets [
	screen := self newLabel.
	buttonAddFactor := self newButton.
	buttonAddLink := self newButton.
	buttonModifiedFactor := self newButton.
	buttonModifiedLink := self newButton.
	"widget configuration"
	screen label: 'Please give us your feedback.'.
	buttonAddFactor label: 'Add Factor'.
	buttonAddLink label: 'Add Link'.
	buttonModifiedFactor label: 'Modified Factor'.
	buttonModifiedLink label: 'Modified Link'.

	"specification of order of focus"
	self focusOrder
		add: buttonAddFactor ;
		add: buttonAddLink ;
		add: buttonModifiedFactor;
		add: buttonModifiedLink 
]

{ #category : #accessing }
MainMenu >> screen [
	^ screen
]

{ #category : #accessing }
MainMenu >> screen: anObject [
	screen := anObject
]

{ #category : #api }
MainMenu >> title [ 
	^ 'Main Menu'
]
