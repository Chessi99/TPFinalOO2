Class {
	#name : #GraphicDrm,
	#superclass : #Object,
	#instVars : [
		'drmBuilder',
		'canvas',
		'links',
		'elements',
		'factors',
		'supports'
	],
	#category : #'Drmer-UI'
}

{ #category : #adding }
GraphicDrm >> addFactorWithAttribute:attribute element:element isExternal:external [
|drmFactor ellipse  label |
	drmFactor:= (drmBuilder factorOnAttribute: attribute of: element )isExternal:external.
	ellipse:=self createEllipse: drmFactor.
	ellipse @ RSPopup @ RSDraggable.
	label:= self createLabelWithText: drmFactor asString on: ellipse  position:#middle  offset:0.  
	elements add:ellipse .
   canvas add: 	label;add: ellipse.
	label pushFront.
	factors at: drmFactor put: (OrderedCollection with: ellipse with:label)  .
	self reload.

]

{ #category : #adding }
GraphicDrm >> addLink:anOrigin destination:aDestination levelOrigin:levelOrigin levelDestination:levelDestination weight:aWeight [

 ^ (drmBuilder link:anOrigin to:aDestination) levelAtOrigin: levelOrigin;levelAtDestination: levelDestination; weight: aWeight. 
]

{ #category : #adding }
GraphicDrm >> addReferences: references link: link [
	references do:[:reference | link addSource: reference] 
]

{ #category : #adding }
GraphicDrm >> addSupport:description [ 
|drmSupport supportUi label|
	drmSupport := drmBuilder support: description.
	supportUi := self createSupportUI: drmSupport .
	label:= self createLabelWithText:description   on:supportUi  position:#middle  offset:0 . 
	supportUi @ RSPopup @ RSDraggable.
	canvas add:supportUi;add: label.
	elements add: supportUi.
	supports at:drmSupport put: (OrderedCollection with:supportUi with:label) .
	self reload
]

{ #category : #adding }
GraphicDrm >> createArrowedLine:drmLink origin:labelOrigin destination:labelDestination [ 
^RSShapeFactory arrowedLine
		model:drmLink;
		color: Color black;
		from: labelOrigin  ;
		to: labelDestination  ;
		withBorderAttachPoint ;
		border:(RSBorder new 
		color:Color black;
		width: drmLink weight)
		yourself.
]

{ #category : #adding }
GraphicDrm >> createEllipse:drmFactor [
^RSEllipse new
		border:(self createFactorBorder: drmFactor isExternal );
		size: drmFactor  asString size + 20;
		model: drmFactor  ; 
		width:100;
		color:(Color white alpha: 0.5).
]

{ #category : #adding }
GraphicDrm >> createFactorBorder:external [
	|border|
	border:=(RSBorder new color:'black' ).
	external ifTrue: [ border dashArray: #(4) ].
	^border
]

{ #category : #adding }
GraphicDrm >> createLabelWithText:aText on:element position:aPosition offset:aOffset [
	|label|
	label:= RSLabel new text:aText; fontSize:10; color: 'black'; @ RSDraggable.
	self createLocation: label destination:element position:aPosition offset:aOffset . 
	^label
]

{ #category : #adding }
GraphicDrm >> createLocation:label destination:aDestination position:aPosition offset:aOffset [
	RSLocation new perform:aPosition; offset: aOffset;
	stick: label   on:  aDestination.	
]

{ #category : #adding }
GraphicDrm >> createSupportUI:drmSupport [
^RSShapeFactory hexagon 
		size: 35; 
		width: (drmSupport description size + 80);
		border: (RSBorder new color:'black');
		color:Color white;
		model:drmSupport.
]

{ #category : #adding }
GraphicDrm >> drawLink:drmLink [
	|arrowedLine label labelText labelOrigin labelDestination  |
	labelText:= (drmLink sources collect: [ :source | source asString  ]) asCommaString.
	labelOrigin:=self createLabelWithText:(drmLink levelAtOrigin) asString  on:(canvas shapeFromModel: 		drmLink origin ) position:#top offset: -15 .
	labelDestination :=self createLabelWithText:(drmLink levelAtDestination) asString  on:(canvas 		shapeFromModel: drmLink destination)  position:#bottom offset:13. 	
	arrowedLine  := self createArrowedLine: drmLink origin:labelOrigin   destination:labelDestination . 
	label := self createLabelWithText: labelText  on: arrowedLine    position:#middle  offset:-8 .
	canvas add:labelOrigin ;add:labelDestination ; add:arrowedLine ;add: label	.
	links at: drmLink put:(OrderedCollection with: label with: labelOrigin with: labelDestination  with: 		arrowedLine  ).
	self reload.	 

]

{ #category : #accessing }
GraphicDrm >> elements [
  ^elements collect: [ :element | element model ]

]

{ #category : #accessing }
GraphicDrm >> factors [
	^ factors
]

{ #category : #initialization }
GraphicDrm >> initialize [
	elements := OrderedCollection new.
	factors := Dictionary new.
	links:=Dictionary new.
	supports:=Dictionary new.
	drmBuilder := DrmModelBuilder new.
	canvas:= RSCanvas new.
	canvas @ RSCanvasController.
	self open.
]

{ #category : #accessing }
GraphicDrm >> links [
	^ links
]

{ #category : #actions }
GraphicDrm >> open [ 
   canvas openOnce
]

{ #category : #updating }
GraphicDrm >> reDrawLink: drmLink [
	| levelAtOrigin levelAtDestination sources linkUi line newLabelOrigin newLabelDestination |
	linkUi := links at: drmLink.
	sources := linkUi first.
	levelAtOrigin := linkUi at: 2.
	levelAtDestination := linkUi at: 3.
	line := linkUi at: 4.
	newLabelOrigin := self createLabelWithText: drmLink levelAtOrigin asString on: (canvas 			shapeFromModel: drmLink origin) position:#top offset:-15.
	newLabelDestination := self createLabelWithText: drmLink levelAtDestination asString on: (canvas 			shapeFromModel: drmLink destination ) position:#bottom offset:13.
	canvas add: newLabelDestination ;add:newLabelOrigin .
	line from: newLabelOrigin; to: newLabelDestination; signalUpdate.
	line border width: drmLink weight  .
	canvas removeShape: levelAtDestination.
	canvas removeShape: levelAtOrigin.
	sources text: (drmLink sources collect: [ :source | source asString ]) asCommaString; signalUpdate.
	linkUi at: 2 put:newLabelDestination  .
	linkUi at: 3 put:newLabelOrigin .
	self reload
]

{ #category : #adding }
GraphicDrm >> references: references link: link [
	link sources: references 
]

{ #category : #actions }
GraphicDrm >> reload [ 
	RSForceBasedLayout new length:120;charge: -800; on: elements  .
	self changed.
	canvas signalUpdate.
	

	
]

{ #category : #adding }
GraphicDrm >> sourceAssumption:aLink [
	aLink sources: (OrderedCollection with:(drmBuilder assumption: ''))
	
]

{ #category : #adding }
GraphicDrm >> sourceExperience:aLink [
	aLink sources: (OrderedCollection with:(drmBuilder experience: ''))
]

{ #category : #adding }
GraphicDrm >> sourceOwn:aLink [
	aLink sources: (OrderedCollection with: (drmBuilder ownInvestigation: ''))
	
]

{ #category : #adding }
GraphicDrm >> sourceUnknown:aLink [
	aLink sources: (OrderedCollection with:(drmBuilder unknownSource: ''))
]

{ #category : #accessing }
GraphicDrm >> supports [
	^ supports
]

{ #category : #updating }
GraphicDrm >> updateFactor: drmFactor with: attribute element: element isExternal: isExternal [
	| factorElements ellipse label |
	drmFactor attribute: attribute; element: element; isExternal: isExternal.
	factorElements := factors at: drmFactor.
	ellipse := factorElements first.
	label := factorElements at: 2.
	label text: drmFactor asString; signalUpdate.
	ellipse border: (self createFactorBorder: isExternal); signalUpdate.
	self reload
]

{ #category : #updating }
GraphicDrm >> updateLink:aLink levelDestination:aLevelDestination levelOrigin:aLevelOrigin origin:aOrigin destination:aDestination weight:aWeight [

aLink destination: aDestination;origin: aOrigin;levelAtDestination: aLevelDestination;levelAtOrigin:aLevelOrigin;weight: aWeight.
]

{ #category : #updating }
GraphicDrm >> updateSupport:drmSupport with:aDescription [
	|uIelements label hexagon|
	drmSupport description: aDescription .
	uIelements := supports at: drmSupport .
	label := uIelements at: 2.
	label text: aDescription; signalUpdate.
	hexagon:= uIelements first.
	hexagon width: (aDescription size + 80); signalUpdate . 

]
