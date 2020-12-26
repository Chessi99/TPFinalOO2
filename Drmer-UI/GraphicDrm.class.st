Class {
	#name : #GraphicDrm,
	#superclass : #Object,
	#instVars : [
		'drmBuilder',
		'canvas',
		'factorEllipses',
		'links'
	],
	#category : #'Drmer-UI'
}

{ #category : #adding }
GraphicDrm >> addFactor:aFactor [
]

{ #category : #adding }
GraphicDrm >> addFactorWithAttribute:attribute element:element isExternal:external [
"Este metodo podria instanciar solo el elemento y llamar a un metodo privado que lo agregue al grafico"
|newFactor factor elipse border description|
	newFactor:= (drmBuilder factorOnAttribute: attribute of: element )isExternal:external.
	
	
	border:=(RSBorder new color:'black' ).
	external ifTrue: [ border dashArray: #(4)  ].
	description := (attribute ,' of ',element ).
	
	elipse:=(RSEllipse new) 
		border:border;
		size: description size + 20;
		model: newFactor ; 
		width:100;
		color:(Color white alpha: 0.5).
		
	
	factor := RSGroup new.
		factor add: elipse.
		factor add: (RSLabel new text: description;  fontSize:5; color: 'black'  ).
	factor := (factor asShapeFor: newFactor  )@ RSPopup @ RSDraggable.		 
   canvas add: 	factor.
	factorEllipses add: factor .
	self reload.


]

{ #category : #initialization }
GraphicDrm >> initialize [
	factorEllipses := OrderedCollection new.
	links:=OrderedCollection new.
	drmBuilder := DrmModelBuilder new.
	canvas:= RSCanvas new.
	canvas @ RSCanvasController.
	self open.
]

{ #category : #'instance creation' }
GraphicDrm >> open [ 
   canvas open
]

{ #category : #actions }
GraphicDrm >> reload [ 
	RSForceBasedLayout new length:120;charge: -800; on: factorEllipses .

	
]
