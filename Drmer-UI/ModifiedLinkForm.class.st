Class {
	#name : #ModifiedLinkForm,
	#superclass : #LinkForm,
	#category : #'Drmer-UI'
}

{ #category : #'as yet unclassified' }
ModifiedLinkForm class >> createWithGraphic: aGraphic link:aLink [
^ (self create:aGraphic) link:aLink.
]

{ #category : #initialization }
ModifiedLinkForm >> initializeValues [
	groupRadio default: self defaultRadio.
	listOrigin setSelectedItem: link origin .
	listDestination setSelectedItem: link destination   .
]

{ #category : #accessing }
ModifiedLinkForm >> link:aLink [
	link:=aLink.
	self initializeValues
]
