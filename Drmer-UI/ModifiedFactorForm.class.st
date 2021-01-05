Class {
	#name : #ModifiedFactorForm,
	#superclass : #FactorForm,
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
ModifiedFactorForm class >> createWithGraphic:aGraphic factor:aFactor [
	^ (self create:aGraphic) factor:aFactor. 
]

{ #category : #accessing }
ModifiedFactorForm >> factor:aFactor [
	factor:=aFactor.
	attributeTextInput text: aFactor attribute.
	elementTextInput text: aFactor element.
	isExternalInput state: aFactor isExternal.
]

{ #category : #initialization }
ModifiedFactorForm >> initializePresenter [ 
	self submitButton action: [graphic updateFactor:factor with:(self attributeTextInput text)  element:(self elementTextInput text) isExternal:(self isExternalInput state).
		].
]
