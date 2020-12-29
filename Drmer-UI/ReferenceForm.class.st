Class {
	#name : #ReferenceForm,
	#superclass : #ComposableModel,
	#instVars : [
		'citation',
		'label',
		'linkForm',
		'labelCitation',
		'labelApp',
		'submitButton'
	],
	#category : #'Drmer-UI'
}

{ #category : #specs }
ReferenceForm class >> defaultSpec [ 
		<spec: #default>
	| fontWidth labelsWidth rowHeight |
	fontWidth := StandardFonts defaultFont widthOfString: 'M'.
	labelsWidth := fontWidth * 5.
	rowHeight := self inputTextHeight.
	^ SpecLayout composed
		newColumn: [ :col | 
			col
				newRow: [ :row | 
					row add: #labelCitation right: labelsWidth.
					row add: #citation]
				height: rowHeight .
			col
				newRow: [ :row | 
					row add: #labelApp right: labelsWidth.
					row add: #label ]
				height: rowHeight.

			col
				newRow: [ :row | row add: #submitButton ] 
				height: rowHeight * 1.3.
			
			
		]
		origin: 0 @ 0.12 corner: 1 @ 0.9;	
		
	yourself
]

{ #category : #'as yet unclassified' }
ReferenceForm class >> withLinkForm:linkform [
	^ (self new) linkForm: linkform.
]

{ #category : #accessing }
ReferenceForm >> citation [
	^ citation
	
]

{ #category : #accessing }
ReferenceForm >> citation: anObject [
	citation := anObject
]

{ #category : #initialization }
ReferenceForm >> initializePresenter [ 

self submitButton action: [linkForm addReferenceWithCitation: citation text  label: label text].
]

{ #category : #initialization }
ReferenceForm >> initializeWidgets [
	
	citation:= self newTextInput text:'';autoAccept: true.
	label:= self newTextInput text: '';autoAccept: true. 
	
	submitButton := self newButton label: 'Submit'.
	
	labelCitation:=self newLabel label: 'Citation:'.
	labelApp:= self newLabel label: 'Label'.
	
]

{ #category : #accessing }
ReferenceForm >> label [
	^ label
]

{ #category : #accessing }
ReferenceForm >> labelApp [
	^ labelApp
]

{ #category : #accessing }
ReferenceForm >> labelCitation [
	^ labelCitation
]

{ #category : #accessing }
ReferenceForm >> linkForm [
	^ linkForm
]

{ #category : #accessing }
ReferenceForm >> linkForm: anObject [
	linkForm := anObject
]

{ #category : #accessing }
ReferenceForm >> submitButton [
	^ submitButton
]
