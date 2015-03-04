angular
	.module 'reddit-gallery-main'
	.directive 'rgGalleryUl', ($window) ->
		($scope, el) ->
			w = $('#rg-gallery')

			fixDimensions = ->
				ww = w.width()
				el.width ww*$scope.gallery.length + 100

			$($window).on 'resize.rgGalleryUl', fixDimensions
			$scope.$watch 'gallery.length', fixDimensions

			$scope.$on '$destroy', ->
				$($window).off '.rgGalleryUl'
				
