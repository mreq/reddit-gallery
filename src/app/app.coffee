angular
	.module 'reddit-gallery', [
		'ngRoute'
		'reddit-gallery-templates'
		'reddit-gallery-api'
		'reddit-gallery-main'
		'reddit-gallery-home'
	]
	.constant 'routes',
		'/':
			controller: 'HomeCtrl'
			templateUrl: 'components/home/homeView.html'
		'/r/:subreddits':
			controller: 'GalleryCtrl'
			templateUrl: 'components/gallery/galleryView.html'
			
	.config ($routeProvider, $locationProvider, routes) ->
		_.each routes, (route, path) ->
			$routeProvider.when path, route

		$routeProvider.otherwise
			redirectTo: '/'

		# $locationProvider.html5Mode
		# 	enabled: true
		# 	requireBase: false
