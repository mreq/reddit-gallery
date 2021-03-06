angular
	.module 'reddit-gallery-reddit'
	.factory 'queryMemory', ->
		return {
			save: (query) ->
				try
					queries = @load()
					queries.push query
					localStorage.setItem 'redditGalleryQueries', JSON.stringify _.uniq queries
				catch
					false
			load: ->
				try
					ar = localStorage.getItem 'redditGalleryQueries'
					if ar?
						JSON.parse ar
					else
						[]
				catch
					[]
			clear: ->
				try
					localStorage.setItem 'redditGalleryQueries', '[]'
				catch
					false
		}
