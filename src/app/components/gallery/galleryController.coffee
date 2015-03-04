angular
	.module 'reddit-gallery-main'
	.controller 'GalleryCtrl', ($scope, $rootScope, $routeParams, $timeout, redditApi, queryMemory) ->
		query = $routeParams.subreddits
		queryMemory.save query

		$rootScope.loading = true
		$rootScope.subreddits = query
		$scope.gallery = []
		$scope.index = 0
		$scope.verticalIndex = 0
		$scope.translate = 0
		$scope.verticalTranslate = 0

		$scope.hideDistant = (index) ->
			Math.abs(index - $scope.index) > 1

		redditApi.init $scope, $rootScope.subreddits

		$scope.$watch 'index', (n) ->
			if not $rootScope.loading and $scope.gallery.length - n < 2
				# Load more
				redditApi.loadMore $scope

		# Why does this feel hacky :/
		$timeout -> angular.element('#rg-input').blur()
