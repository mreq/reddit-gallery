#############################
gulp           = require 'gulp'
bower          = require 'gulp-bower'
browserSync    = require 'browser-sync'
changed        = require 'gulp-changed'
coffee         = require 'gulp-coffee'
concat         = require 'gulp-concat'
gutil          = require 'gulp-util'
includeSources = require 'gulp-include-source'
less           = require 'gulp-less'
minifyCSS      = require 'gulp-minify-css'
notify         = require 'gulp-notify'
plumber        = require 'gulp-plumber'
replace        = require 'gulp-replace'
shell          = require 'gulp-shell'
templateCache  = require 'gulp-angular-templatecache'
uglify         = require 'gulp-uglify'
usemin         = require 'gulp-usemin'
#############################
paths =
	dist:          'dist'
	src:           'src'
	tmp:           'tmp'
	bower:         'src/assets/bower_components'
	stylesheets:   'src/assets/stylesheets/reddit-gallery.less'
	javascripts:   'src/assets/javascripts/*'
	coffeescripts: ['src/app/*.coffee', 'src/app/**/*.coffee', 'src/app/**/**/*.coffee']
	templates:     ['src/app/*.html', 'src/app/**/*.html', 'src/app/**/**/*.html']
	html:          'src/index.html'
#############################
# Reloads browser
gulp.task 'reloadBrowser', ->
	browserSync.reload()
# Runs `bower install`
gulp.task 'bower', ->
	bower()
		.pipe gulp.dest paths.bower
# Clean tmp
gulp.task 'cleanTmp', ->
	gulp.src paths.tmp
		.pipe shell "rm -rf #{ paths.tmp }/*"
# Builds less to css
gulp.task 'less', ->
	gulp
		.src paths.stylesheets
		.pipe changed "#{ paths.tmp }/stylesheets"
		.pipe plumber errorHandler: notify.onError("Error: <%= error.message %>")
		.pipe less()
		.pipe gulp.dest "#{ paths.tmp }/stylesheets"
# Builds coffee to js
gulp.task 'coffee', ->
	gulp
		.src paths.coffeescripts
		.pipe plumber errorHandler: notify.onError("Error: <%= error.message %>")
		.pipe coffee( bare: true ).on('error', gutil.log)
		.pipe concat 'app.js'
		.pipe gulp.dest "#{ paths.tmp }/javascripts"
# Caches angular templates
gulp.task 'templates', ->
	gulp
		.src paths.templates
		.pipe plumber errorHandler: notify.onError("Error: <%= error.message %>")
		.pipe templateCache
			module: 'reddit-gallery-templates'
			standalone: true
		.pipe gulp.dest "#{ paths.tmp }/javascripts"
# Copies (vendor) plain js files
gulp.task 'copyJavascripts', ->
	gulp
		.src paths.javascripts
		.pipe concat 'vendor.js'
		.pipe gulp.dest "#{ paths.tmp }/javascripts"
# Copies other files
gulp.task 'copyFiles', ->
	gulp
		.src "#{ paths.src }/assets/favicon.ico"
		.pipe gulp.dest paths.tmp
# Copies HTML files
gulp.task 'html', ->
	gulp
		.src paths.html
		.pipe gulp.dest paths.tmp
# Run tasks
gulp.task 'init', ['bower', 'cleanTmp'], ->
	gulp.run [
		'less'
		'coffee'
		'templates'
		'copyJavascripts'
		'html'
		'copyFiles'
	]
# Watch files for changes
gulp.task 'watch', ['bower'], ->
	gulp.watch paths.stylesheets,   ['less']
	gulp.watch paths.coffeescripts, ['coffee']
	gulp.watch paths.templates,     ['templates']
	gulp.watch paths.javascripts,   ['copyJavascripts']
	gulp.watch paths.html,          ['html']
	gulp.watch 'bower.json',        ['bower']
	gulp.watch "#{ paths.tmp }/**", ['reloadBrowser']
# Server with livereload (browserSync)
gulp.task 'browser-sync', ['bower'], ->
	browserSync
		server:
			baseDir: paths.tmp
#############################
gulp.task 'server', [
	'init'
	'watch'
	'browser-sync'
]
#############################
gulp.task 'default', ['server']
