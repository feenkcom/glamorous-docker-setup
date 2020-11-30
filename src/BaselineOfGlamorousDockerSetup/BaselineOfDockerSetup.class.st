Class {
	#name : #BaselineOfDockerSetup,
	#superclass : #BaselineOf,
	#category : #'BaselineOfDockerSetup-BaselineOfDockerSetup'
}

{ #category : #accessing }
BaselineOfDockerSetup >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				package: 'DockerSetup' ]
]
