angular
	.module 'reddit-gallery-main', []
	.controller 'MainCtrl', ($scope) ->
		console.log 'main?'
		$scope.awesomeThings = [
			'HTML5 Boilerplate',
			'AngularJS',
			'Karma',
			'Coffeescript',
			'Less',
			'Jade'
		]