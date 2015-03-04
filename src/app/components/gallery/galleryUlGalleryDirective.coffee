angular
	.module 'reddit-gallery-main'
	.directive 'rgGalleryUlGallery', ($window) ->
		($scope, el) ->
			w = $('#rg-gallery')

			moveAlbum = (index = $scope.album.verticalIndex) ->
				if $scope.album.images[index]
					el.css 'transform', """translate(0, #{ -index*w.height() }px)"""

			fixDimensions = ->
				wh = w.height()
				el.height wh*$scope.album.length + 100

			fixDimensions()
			$($window).on 'resize.rgGalleryUl', fixDimensions

			$scope.$watch 'album.verticalIndex', moveAlbum

			$scope.$on '$destroy', ->
				$($window).off '.rgGalleryUl'
				
