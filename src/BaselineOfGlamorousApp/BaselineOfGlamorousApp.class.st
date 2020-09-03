Class {
	#name : #BaselineOfGlamorousApp,
	#superclass : #BaselineOf,
	#category : #'BaselineOfGlamorousApp-BaselineOfGlamorousApp'
}

{ #category : #accessing }
BaselineOfGlamorousApp >> baseline: spec [
	<baseline>
	spec
		for: #common do: [
			spec
				package: 'GlamorousApp' ]
]
