angular
	.module 'reddit-gallery-main'
	.directive 'rgGalleryUl', ($window) ->
		($scope, el) ->
			w = $('#rg-gallery')

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
				
				# Move
				el.css 'transform', """translate(#{ -w.width()*index }px, 0)"""
				$scope.$apply ->
					if index is oldindex
						$scope.gallery[index].verticalIndex = verticalIndex
					else
						$scope.index = index
					

			fixDimensions = ->
				ww = w.width()
				el.width ww*$scope.gallery.length + 100
				el.children('li').width ww
				el.css 'transform', """translate(#{ -w.width()*$scope.index }px, 0)"""

			$($window).on 'resize.rgGalleryUl', fixDimensions
			$scope.$watch 'gallery.length', fixDimensions

			$scope.$on '$destroy', ->
				$($window).off '.rgGalleryUl'
				$(document).off '.rgGalleryUl'
				
