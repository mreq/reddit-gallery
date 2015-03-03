angular
	.module 'reddit-gallery-api', []
	.factory 'RedditApiFactory', ($http) ->
		return {
			init: (subreddits, type = 'hot') ->
				@subreddits = subreddits
				@type = type
				@load()
			load: (after = false) ->
				opts =
					url: "http://www.reddit.com/r/#{ @subreddits }/#{ @type }.json"
					type: 'JSONP'
				opts.after = after  if after
				$http opts
			filterByDomain: (posts, domain = 'imgur.com') ->
				posts.map -> @data.domain is domain
			append: ->
				@load subreddits, type
					.success (response) ->
						response
		}
