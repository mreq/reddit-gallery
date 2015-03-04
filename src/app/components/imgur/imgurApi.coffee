angular
	.module 'reddit-gallery-imgur'
	.factory 'imgurApi', ($http) ->
		return {
			getPost: (scope, post) ->
				isAlbum = post.data.url.match '/a/'
				if isAlbum
					@getAlbum scope, post
				else
					@getImage scope, post
			getPosts: (scope, posts) ->
				_.each posts, (post) =>
					@getPost scope, post
			getImage: (scope, post) ->
				opts = 
					url: "https://api.imgur.com/3/image/#{ post.data.url.split('/').pop() }"
					headers:
						Authorization: 'Client-ID 8a5b39ce4ff3d98'
				$http opts
					.success (response) ->
						scope.gallery.push {
							id: post.data.id
							title: post.data.title
							link: "http://www.reddit.com#{ post.data.permalink }"
							thisIndex: scope.gallery.length
							verticalIndex: 0
							images: [response.data]
						}
			getAlbum: (scope, post) ->
				opts = 
					url: "https://api.imgur.com/3/album/#{ post.data.url.split('/').pop() }"
					headers:
						Authorization: 'Client-ID 8a5b39ce4ff3d98'
				$http opts
					.success (response) ->
						scope.gallery.push {
							id: post.data.id
							title: post.data.title
							link: "http://www.reddit.com#{ post.data.permalink }"
							thisIndex: scope.gallery.length
							verticalIndex: 0
							images: response.data.images
						}
		}
