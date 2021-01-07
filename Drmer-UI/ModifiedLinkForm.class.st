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
ModifiedLinkForm >> initializeSubminButton [
	self submitButton
		action: [ graphic
				updateLink: link
				levelDestination: levelDestination selectedItem
				levelOrigin: levelOrigin selectedItem
				origin: listOrigin selectedItem
				destination: listDestination selectedItem.
			self perform: action.
			graphic reDrawLink: link ]
]

{ #category : #initialization }
ModifiedLinkForm >> initializeValues [
	groupRadio default: self defaultRadio.

]

{ #category : #accessing }
ModifiedLinkForm >> link:aLink [
	link:=aLink.
	self initializeValues
]

{ #category : #'as yet unclassified' }
ModifiedLinkForm >> reference [

	(link sources size > 1 )ifTrue:[graphic addReferences: references link: link. ^self].
	graphic references: references link: link. 
]
