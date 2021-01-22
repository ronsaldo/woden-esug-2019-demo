Class {
	#name : #WodenEsug2019DemoTitleScreen,
	#superclass : #WDESOverlayScreen,
	#instVars : [
		'sequenceTime',
		'backgroundColor',
		'foregroundColor',
		'regularFont',
		'boldFont'
	],
	#category : #WodenEsug2019Demo
}

{ #category : #rendering }
WodenEsug2019DemoTitleScreen >> boldFont [
	^ boldFont ifNil: [ boldFont := (FreeTypeFont fromFile: 'assets/fonts/xolonium/Xolonium-Bold.ttf' pointSize: 40) ]
]

{ #category : #rendering }
WodenEsug2019DemoTitleScreen >> buildUISceneGraphWith: builder [
	| bounds extent string stringWidth stringBounds fontHeight |
	bounds := builder clippingBounds.
	extent := bounds extent.
	string := 'WODANIC ALPHA'.
	stringWidth := self boldFont widthOfString: string.
	fontHeight := self boldFont getPreciseHeight.
	stringBounds := ((extent x - stringWidth) / 2) @ ((extent y - fontHeight) / 2) extent: stringWidth @ fontHeight.
	
	^ builder containerWith: { 
		builder rectangle: bounds color: backgroundColor.
		builder string: string in: stringBounds font: self boldFont color: foregroundColor
	}.
]

{ #category : #rendering }
WodenEsug2019DemoTitleScreen >> drawOnBabylonCanvas: canvas [
	| builder mesh |
	builder := canvas driver mesh2DBuilder.
	
	builder fill
		color: backgroundColor;
		rectangle: (0@0 extent: canvas surface extent).

	builder transform
		translateBy: canvas surface extent / 2;
		scaleBy: canvas surface extent y / 480.

	builder transform restoreAfter: [
		builder
			text
			color: foregroundColor;
			font: self regularFont;

			position: -210 @ -170;
			draw: 'Voyage in the';
			newline;
			position: -260 @ -110;
			font: self boldFont;
			draw: 'WODANIC ALPHA'.
	].

	builder transform restoreAfter: [
		builder transform scaleBy: 0.6.

		builder text
			font: self regularFont;
			color: foregroundColor;

			position: -190 @ 0;
			draw: 'Episode 0.01:';

			position: -350 @ 120;
			draw: 'A mysterious awakening'; newline;
			draw: '        in the volcanic'; newline;
			draw: '         Lake Wallen.'.

	].		

	mesh := builder mesh.
	canvas draw: mesh.
]

{ #category : #rendering }
WodenEsug2019DemoTitleScreen >> initialize [
	super initialize.
	sequenceTime := 0.0.
	backgroundColor := Color black.
	foregroundColor := Color black.
]

{ #category : #testing }
WodenEsug2019DemoTitleScreen >> isAlive [
	^ sequenceTime < 10.0
	"^ sequenceTime < 0.0."
]

{ #category : #rendering }
WodenEsug2019DemoTitleScreen >> regularFont [
	^ regularFont ifNil: [ regularFont := (FreeTypeFont fromFile: 'assets/fonts/xolonium/Xolonium-Regular.ttf' pointSize: 40) ]
]

{ #category : #testing }
WodenEsug2019DemoTitleScreen >> tick: delta [
	| fadeOut |
	sequenceTime := sequenceTime + delta.

	fadeOut := 1.0 - (sequenceTime smoothStepFrom: 5.5 to: 10.0).
	backgroundColor := Float32x4 w: fadeOut.
	foregroundColor := Float32x4 x: 1.0 y: 1.0 z: 1.0 w: (sequenceTime smoothStepFrom: 0.0 to: 5.0 )*fadeOut.
		
	backgroundColor := backgroundColor asColor.
	foregroundColor := foregroundColor asColor.
	
]
