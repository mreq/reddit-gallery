angular
	.module 'reddit-gallery-imgur'
	.factory 'imgurApi', ($http) ->
		return {
			getUrl: (scope, url) ->
				isAlbum = url.match '/a/'
				if isAlbum
					@getAlbum scope, url
				else
					@getImage scope, url
			getUrls: (scope, urls) ->
				_.each urls, (url) =>
					@getUrl scope, url
			getImage: (scope, url) ->
				opts = 
					url: "https://api.imgur.com/3/image/#{ url.split('/').pop() }"
					headers:
						Authorization: 'Client-ID 8a5b39ce4ff3d98'
				$http opts
					.success (response) ->
						scope.gallery.push [response]
			getAlbum: (scope, url) ->
				opts = 
					url: "https://api.imgur.com/3/album/#{ url.split('/').pop() }"
					headers:
						Authorization: 'Client-ID 8a5b39ce4ff3d98'
				$http opts
					.success (response) ->
						scope.gallery.push response.data.images
		}
