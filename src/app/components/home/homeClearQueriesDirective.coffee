angular
	.module 'reddit-gallery-home'
	.directive 'rgClearQueries', (queryMemory) ->
		($scope, el) ->

			el.on 'click', (e) ->
				e.preventDefault()
				$scope.$apply ->
					queryMemory.clear()
					$scope.queries = []

			$scope.$on '$destroy', ->
				el.off()