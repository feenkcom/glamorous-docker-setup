Class {
	#name : #BaselineOfGlamorousDockerSetup,
	#superclass : #BaselineOf,
	#category : #'BaselineOfGlamorousDockerSetup-BaselineOfGlamorousDockerSetup'
}

{ #category : #accessing }
BaselineOfGlamorousDockerSetup >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				package: 'GlamorousDockerSetup' ]
]
