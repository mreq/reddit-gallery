angular
	.module 'reddit-gallery-reddit'
	.factory 'redditApi', ($http, $rootScope, imgurApi) ->
		return {
			init: (scope, subreddits, type = 'hot') ->
				@subreddits = subreddits
				@type = type
				@load scope
			load: (scope, after = false) ->
				opts =
					url: "http://www.reddit.com/r/#{ @subreddits }/#{ @type }.json"
					type: 'JSONP'
					params:
						count: 10
				opts.params.after = after  if after
				$http opts
					.success (response) =>
						imgurApi.getPosts scope, @extract response
						$rootScope.loading = false
			loadMore: (scope) ->
				@load scope, @after  if @after
			filterByDomain: (posts, domain = 'imgur.com') ->
				_.filter posts, (post) -> post.data.domain is domain
			extract: (response) ->
				@after = response.data.after
				@filterByDomain(response.data.children)
		}
