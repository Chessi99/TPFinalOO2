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
GraphicDrm >> addFactorWithAttribute:attribute element:element [
|newFactor factor|
	newFactor:= drmBuilder factorOnAttribute: attribute of: element.
	factor := RSGroup new.
	factor add: (RSEllipse new size: 30; model: newFactor ; color:((Color gray alpha: 0.5))   ).
	factor add: (RSLabel new text:'text'; fontSize:5; color: 'black'  ). 
	(factor asShapeFor: newFactor  )@ RSPopup @ RSDraggable.
	
	canvas add: factor asShape .

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
