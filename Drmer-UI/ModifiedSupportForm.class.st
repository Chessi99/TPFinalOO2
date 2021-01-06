Class {
	#name : #ModifiedSupportForm,
	#superclass : #SupportForm,
	#instVars : [
		'support'
	],
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
ModifiedSupportForm class >> createWithGraphic: aGraphic support:aSupport [
^ (self create:aGraphic) support:aSupport.
]

{ #category : #initialization }
ModifiedSupportForm >> initializePresenter [
	
	self submitButton action: [ graphic updateSupport:support with:self description text ].
]

{ #category : #accessing }
ModifiedSupportForm >> support:aSupport [
	support := aSupport.
	description  text: aSupport description 
]
