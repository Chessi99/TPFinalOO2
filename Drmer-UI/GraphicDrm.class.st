Class {
	#name : #GraphicDrm,
	#superclass : #Object,
	#instVars : [
		'drmBuilder',
		'canvas'
	],
	#category : #'Drmer-UI'
}

{ #category : #adding }
GraphicDrm >> addFactor:aFactor [
]

{ #category : #adding }
GraphicDrm >> addFactorWithAttribute:attribute element:element isExternal:external [
"Este metodo podria instanciar solo el elemento y llamar a un metodo privado que lo agregue al grafico"
|newFactor factor elipse border|
	newFactor:= (drmBuilder factorOnAttribute: attribute of: element )isExternal:external.
	border:=(RSBorder new color:'black' ).
	external ifTrue: [ border dashArray: #(4)  ].
	
	elipse:=(RSEllipse new) 
		border:border;
		size: 30;
		model: newFactor ; 
		color:(Color white alpha: 0.5).
		
	
	factor := RSGroup new.
		factor add: elipse.
		factor add: (RSLabel new text: 
						(attribute ,' of ',element ); 
						fontSize:5; color: 'black'  ).
						 
   canvas add: 	(factor asShapeFor: newFactor  )@ RSPopup @ RSDraggable.
	canvas  @ RSCanvasController.


]

{ #category : #initialization }
GraphicDrm >> initialize [

	canvas:= RSCanvas new.
	drmBuilder := DrmModelBuilder new.
]

{ #category : #actions }
GraphicDrm >> reload [ 
	canvas @ RSCanvasController.
	(InspectDebuggerDebugAction gtActionFor:(canvas)) executeAction.
]
