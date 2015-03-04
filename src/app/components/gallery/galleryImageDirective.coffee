angular
	.module 'reddit-gallery-main'
	.directive 'rgImage', ($window) ->
		scope:
			'rgImage': '=' 
		link: ($scope, el) ->
			w = $('#rg-gallery')
			iw = $scope.rgImage.width
			ih = $scope.rgImage.height

			fixDimensions = ->
				wh = w.height()
				ww = w.width()
				if iw > ww
					ih = ih*ww/iw
					iw = ww
					if ih > wh
						iw = iw*wh/ih
						ih = wh
				else
					iw = iw*wh/ih
					ih = wh
					if iw > ww
						ih = ih*ww/iw
						iw = ww
				iw = iw - 20
				ih = ih - 20
				
				el.css
					width: ww
				el.children('img').css
					width: iw
					height: ih
					marginLeft: -iw/2
					marginTop: -ih/2

			fixDimensions()
			$($window).on "resize.rgImage#{ $scope.rgImage.id } orientationchange.rgImage#{ $scope.rgImage.id }", fixDimensions

			$scope.$on '$destroy', ->
				$($window).off ".rgImage#{ $scope.rgImage.id }"
				
