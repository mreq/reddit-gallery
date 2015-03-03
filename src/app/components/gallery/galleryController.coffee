angular
	.module 'reddit-gallery-main'
	.controller 'GalleryCtrl', ($scope, $rootScope, $routeParams, RedditApiFactory) ->
		$rootScope.subreddits = $routeParams.subreddits

		# redditApi = new RedditApiFactory
		# redditApi.init 'pics'
		# 	.success (response) ->
		# 		console.log response
		# 