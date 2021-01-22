Class {
	#name : #WodanicDrivingCharacterController,
	#superclass : #WDESCharacterDrivingVehicleDisplacementStrategy,
	#instVars : [
		'driverEntryPosition',
		'localDriverPosition',
		'drivingTime'
	],
	#category : #WodenEsug2019Demo
}

{ #category : #simulation }
WodanicDrivingCharacterController >> activateUseCommand [
	super activateUseCommand.

	vehicleKinematicBehavior
		engineDirection: 0.0;
		turnDirection: 0.0.
]

{ #category : #'as yet unclassified' }
WodanicDrivingCharacterController >> applyVehicleAngleDelta: angleDelta [
	character headAngle: character headAngle + (Float32x3 y: angleDelta)
]

{ #category : #accessing }
WodanicDrivingCharacterController >> character: aCharacter [
	super character: aCharacter.
	driverEntryPosition := character ownerEntity sectorTransform translation.
]

{ #category : #initialization }
WodanicDrivingCharacterController >> initialize [
	super initialize.
	driverEntryPosition := Float32x3 zeros.
	drivingTime := 0.0.
]

{ #category : #accessing }
WodanicDrivingCharacterController >> localDriverPosition [
	^ localDriverPosition
]

{ #category : #accessing }
WodanicDrivingCharacterController >> localDriverPosition: anObject [
	localDriverPosition := anObject
]

{ #category : #simulation }
WodanicDrivingCharacterController >> prePhysicsTick: delta [
	super prePhysicsTick: delta.
	vehicleKinematicBehavior
		engineDirection: character leftStickDirection y;
		turnDirection: character leftStickDirection x.
	drivingTime := drivingTime + delta
]

{ #category : #hooks }
WodanicDrivingCharacterController >> vehicleDriverPosition [
	^ driverEntryPosition interpolateTo: (vehicle sectorTransform transformPosition: localDriverPosition) at: (drivingTime smoothStepFrom: 0.0 to: 0.8)
]
