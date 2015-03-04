angular
	.module 'reddit-gallery-home', []
	.controller 'HomeCtrl', ($scope, $rootScope, queryMemory) ->
		$rootScope.subrredits = ''

		$scope.queries = queryMemory.load()