angular
	.module 'reddit-gallery-home', []
	.controller 'HomeCtrl', ($scope, $rootScope, RedditApiFactory) ->
		$rootScope.subrredits = ''
		$scope.queries = []