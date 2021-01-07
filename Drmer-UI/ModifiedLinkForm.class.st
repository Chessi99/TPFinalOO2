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
ModifiedLinkForm >> defaultRadio [
 |sources|
	sources:=(link sources collect: [ :source | source asString  ]) asCommaString.	   
	sources = '[A]'  ifTrue: [ ^buttonAssumption  ].
   sources = '[E]'  ifTrue: [ ^buttonExperience ].
   sources = '[?]'  ifTrue: [ ^buttonUnknown  ].
   sources = '[O]'  ifTrue: [ ^buttonOwn  ].

   ^buttonReference.
]

{ #category : #initialization }
ModifiedLinkForm >> initializeValues [
	groupRadio default: self defaultRadio.
	listOrigin setSelectedItem: link origin.
	listDestination setSelectedItem: link destination.
	levelDestination setSelectedItem: link levelAtDestination.
]

{ #category : #accessing }
ModifiedLinkForm >> link:aLink [
	link:=aLink.
	self initializeValues
]
