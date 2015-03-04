angular
	.module 'reddit-gallery-main'
	.controller 'GalleryCtrl', ($scope, $rootScope, $routeParams, $timeout, redditApi, queryMemory) ->
		query = $routeParams.subreddits
		queryMemory.save query

		$rootScope.subreddits = query
		$scope.gallery = []
		$scope.index = 0
		$scope.verticalIndex = 0
		$scope.translate = 0
		$scope.verticalTranslate = 0
		
		redditApi.init $scope, $rootScope.subreddits

		# Why does this feel hacky :/
		$timeout -> angular.element('#rg-input').blur()
