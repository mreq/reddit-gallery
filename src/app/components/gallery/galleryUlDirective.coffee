angular
	.module 'reddit-gallery-main'
	.directive 'rgGalleryUl', ($window) ->
		($scope, el) ->
			w = $('#rg-gallery')
			$scope.translateX = 0

			$scope.slideToIndex = (index) ->
				$scope.index = index
				$scope.translateX = -w.width()*index
				el.css 'transform', """translate(#{ $scope.translateX }px, 0)"""

			# Bind keyboard
			$(document).on 'keyup.rgGalleryUl', (e) ->
				oldindex = index = $scope.index
				verticalIndex = $scope.gallery[index].verticalIndex

				if e.keyCode is 39       # right
					index = index + 1
				else if e.keyCode is 37  # left
					index = index - 1
				else if e.keyCode is 40  # down
					verticalIndex = verticalIndex + 1
				else if e.keyCode is 38  # up
					verticalIndex = verticalIndex - 1
				else                     # other keys focus the input
					angular.element('#rg-input').focus()
					return false

				if index < 0 or index > ($scope.gallery.length - 1)
					return false

				if verticalIndex < 0 or verticalIndex > ($scope.gallery[oldindex].images.length - 1)
					return false
				
				$scope.$apply ->
					if index is oldindex
						$scope.gallery[index].verticalIndex = verticalIndex
					else
						$scope.slideToIndex index
					

			fixDimensions = ->
				ww = w.width()
				el.width ww*$scope.gallery.length + 100
				el.children('li').width ww
				$scope.slideToIndex $scope.index

			$($window).on 'resize.rgGalleryUl', fixDimensions
			$scope.$watch 'gallery.length', fixDimensions

			$scope.$on '$destroy', ->
				$($window).off '.rgGalleryUl'
				$(document).off '.rgGalleryUl'
				
