Class {
	#name : #MainMenu,
	#superclass : #ComposableModel,
	#instVars : [
		'buttonAddFactor',
		'buttonAddLink',
		'buttonModifiedFactor',
		'buttonModifiedLink',
		'buttonOpenGaph',
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
				add: #buttonModifiedLink;
				add: #buttonOpenGaph ]
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

{ #category : #accessing }
MainMenu >> buttonOpenGaph [
	^ buttonOpenGaph
]

{ #category : #accessing }
MainMenu >> buttonOpenGaph: anObject [
	buttonOpenGaph := anObject
]

{ #category : #api }
MainMenu >> extent [
	^ 400 @ 100
]

{ #category : #initialization }
MainMenu >> initialize [ 
	super initialize.
	graphic := GraphicDrm new.

]

{ #category : #initialization }
MainMenu >> initializePresenter [
	buttonAddFactor  action: [ 
		screen label: buttonAddFactor  label.
		(FactorForm create: graphic ) openWithSpec
		
											].
	buttonAddLink  action: [ 
		screen label: buttonAddLink  label.
		(LinkForm create: (graphic factorEllipses collect: [:factor | factor model])) openWithSpec .	
	].
	buttonModifiedFactor  action: [ screen label: buttonModifiedFactor  label ].
	buttonModifiedLink   action: [ screen label: buttonModifiedLink  label ].
	buttonOpenGaph  action: [ graphic open]
	
]

{ #category : #initialization }
MainMenu >> initializeWidgets [
	screen := self newLabel.
	buttonAddFactor := self newButton.
	buttonAddLink := self newButton.
	buttonModifiedFactor := self newButton.
	buttonModifiedLink := self newButton.
	buttonOpenGaph := self newButton .
	"widget configuration"
	screen label: 'DRM MENU.'.
	buttonAddFactor label: 'Add Factor'.
	buttonAddLink label: 'Add Link'.
	buttonModifiedFactor label: 'Modified Factor'.
	buttonModifiedLink label: 'Modified Link'.
	buttonOpenGaph label: 'Open Graph'.

	"specification of order of focus"
	self focusOrder
		add: buttonAddFactor ;
		add: buttonAddLink ;
		add: buttonModifiedFactor;
		add: buttonModifiedLink;
		add: buttonOpenGaph 
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
