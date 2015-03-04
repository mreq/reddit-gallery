angular
	.module 'reddit-gallery-home'
	.controller 'HomeCtrl', ($scope, $rootScope, $timeout, queryMemory) ->
		$rootScope.subreddits = null
		$rootScope.loading = false

		$scope.queries = queryMemory.load()

		# Why does this feel hacky :/
		$timeout -> angular.element('#rg-input').focus()