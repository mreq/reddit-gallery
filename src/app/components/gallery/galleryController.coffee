angular
	.module 'reddit-gallery-main'
	.controller 'GalleryCtrl', ($scope, $rootScope, $routeParams, redditApi, queryMemory) ->
		query = $routeParams.subreddits
		queryMemory.save query

		$rootScope.subreddits = query
		$scope.gallery = []

		redditApi.init $scope, $rootScope.subreddits
