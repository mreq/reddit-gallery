angular
	.module 'reddit-gallery-main'
	.directive 'rgGalleryInput', ($window, $timeout, $rootScope) ->
		link: ($scope, el) ->
			$scope.subreddits ?= ''
			submit = ->
				if $scope.subreddits.length > 0
					$window.location.assign "#/r/#{ $scope.subreddits }"
				else
					$window.location.assign "#/"

			$timeout ->
				el.focus()

			el.on 'keyup', (e) ->
				e.stopPropagation()  # prevent gallery from moving
				if e.keyCode is 13
					submit()
				else if e.keyCode is 27
					el.blur()
				
			$scope.$on '$destroy', ->
				el.off()