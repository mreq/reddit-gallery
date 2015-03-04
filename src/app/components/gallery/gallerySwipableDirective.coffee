angular
	.module 'reddit-gallery-main'
	.directive 'rgSwipable', ->
		($scope, el) ->
			# Code is inspired by http://kenwheeler.github.io/slick/, props to @kenwheeler
			touchObject = {}
			isSwiping = false
			settings =
				minSwipe: 100
			currentUl = null
			currentAlbum = null
			currentHeight = null

			setSwipeOffset = (dir, to) ->
				switch dir
					when 'left'
						tr = $scope.translateX - to
						el.css 'transform', """translate(#{ tr }px, 0)"""
					when 'right'
						tr = $scope.translateX + to
						el.css 'transform', """translate(#{ tr }px, 0)"""
					else 
						if currentAlbum.images.length > 1
							if dir is 'up'
								tr = -currentAlbum.verticalIndex*currentHeight - to
								currentUl.css 'transform', """translate(0, #{ tr }px)"""
							else
								tr = -currentAlbum.verticalIndex*currentHeight + to
								currentUl.css 'transform', """translate(0, #{ tr }px)"""

			swipeDirection = ->
				xDist = touchObject.startX - touchObject.curX
				yDist = touchObject.startY - touchObject.curY
				r = Math.atan2(yDist, xDist)
				swipeAngle = Math.round(r * 180 / Math.PI)
				if swipeAngle < 0
					swipeAngle = 360 - Math.abs(swipeAngle)

				# Divide the circle by 90°s
				if swipeAngle <= 45 and swipeAngle >= 0 or swipeAngle <= 360 and swipeAngle >= 315
					'left'
				else if swipeAngle >= 45 and swipeAngle <= 135
					'up'
				else if swipeAngle >= 135 and swipeAngle <= 225
					'right'
				else
					'down'

			swipeEval = ->
				dir = swipeDirection()
				if touchObject.swipeLength >= settings.minSwipe
					# Slide!
					switch dir
						when 'left'
							if $scope.index < $scope.gallery.length - 1
								$scope.slideToIndex $scope.index + 1
							else
								setSwipeOffset dir, 0
						when 'right'
							if $scope.index > 0
								$scope.slideToIndex $scope.index - 1
							else
								setSwipeOffset dir, 0
						when 'up'
							if currentAlbum.verticalIndex < currentAlbum.images.length - 1
								currentAlbum.verticalIndex = currentAlbum.verticalIndex + 1
							else
								setSwipeOffset dir, 0
						else
							if currentAlbum.verticalIndex > 0
								currentAlbum.verticalIndex = currentAlbum.verticalIndex - 1
							else
								setSwipeOffset dir, 0
				else
					setSwipeOffset dir, 0
				touchObject = {}

			swipeEnd = (event) ->
				isSwiping = false
				el.removeClass 'rg-swiping'
				# return false  unless touchObject.curX?
				$scope.$apply -> swipeEval()

			swipeMove = (event) ->
				return  unless isSwiping
				touches = if event.originalEvent != undefined then event.originalEvent.touches else null

				touchObject.curX = if touches != undefined then touches[0].pageX else event.clientX
				touchObject.curY = if touches != undefined then touches[0].pageY else event.clientY
				dir = swipeDirection()
				if dir is 'left' or dir is 'right'
					touchObject.swipeLength = Math.round(Math.sqrt((touchObject.curX - touchObject.startX) ** 2))
				else
					touchObject.swipeLength = Math.round(Math.sqrt((touchObject.curY - touchObject.startY) ** 2))

				event.preventDefault()  if event.originalEvent != undefined and touchObject.swipeLength > 4
				
				setSwipeOffset dir, touchObject.swipeLength

			swipeStart = (event) ->
				isSwiping = true
				el.addClass 'rg-swiping'
				currentUl = el.children('li').eq($scope.index).find('ul')
				currentAlbum = $scope.gallery[$scope.index]
				currentHeight = el.height()
				if event.originalEvent != undefined and event.originalEvent.touches != undefined
					touches = event.originalEvent.touches[0]
				touchObject.startX = touchObject.curX = if touches != undefined then touches.pageX else event.clientX
				touchObject.startY = touchObject.curY = if touches != undefined then touches.pageY else event.clientY

			swipeHandler = (event) ->
				switch event.data.action
					when 'start'
						swipeStart event
					when 'move'
						swipeMove  event
					when 'end'
						swipeEnd   event

			el.on 'touchstart.rgSwipable mousedown.rgSwipable',   { action: 'start' }, swipeHandler
			el.on 'touchmove.rgSwipable mousemove.rgSwipable',    { action: 'move' },  swipeHandler
			el.on 'touchend.rgSwipable mouseup.rgSwipable',       { action: 'end' },   swipeHandler
			el.on 'touchcancel.rgSwipable mouseleave.rgSwipable', { action: 'end' },   swipeHandler

			$scope.$on '$destroy', ->
				el.off '.rgSwipable'