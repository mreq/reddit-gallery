angular
	.module 'reddit-gallery-reddit'
	.factory 'redditApi', ($http, imgurApi) ->
		return {
			init: (scope, subreddits, type = 'hot') ->
				@subreddits = subreddits
				@type = type
				@load scope
			load: (scope, after = false) ->
				opts =
					url: "http://www.reddit.com/r/#{ @subreddits }/#{ @type }.json"
					type: 'JSONP'
				opts.after = after  if after
				$http opts
					.success (response) =>
						imgurApi.getUrls scope, @extract response
			filterByDomain: (posts, domain = 'imgur.com') ->
				_.filter posts, (post) -> post.data.domain is domain
			extract: (response) ->
				@after = response.data.after
				_.map @filterByDomain(response.data.children), (image) -> image.data.url
		}
