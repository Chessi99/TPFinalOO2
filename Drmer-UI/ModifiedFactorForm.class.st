Class {
	#name : #ModifiedFactorForm,
	#superclass : #FactorForm,
	#instVars : [
		'factor'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
ModifiedFactorForm class >> createWithGraphic:aGraphic factor:aFactor [
	^ (self create:aGraphic) factor:aFactor. 
]

{ #category : #accessing }
ModifiedFactorForm >> factor:aFactor [
	factor:=aFactor.
	self loadInputs.
]

{ #category : #initialization }
ModifiedFactorForm >> initializePresenter [ 
	self submitButton action: [graphic updateFactor:factor with:(self attributeTextInput text)  element:(self elementTextInput text) isExternal:(self isExternalInput state).
		].
]

{ #category : #'as yet unclassified' }
ModifiedFactorForm >> loadInputs [
	attributeTextInput text: factor attribute.
	elementTextInput text: factor element.
	isExternalInput state: factor isExternal.
]
