module.exports = (grunt) ->
	
	
	grunt.loadNpmTasks 'grunt-contrib-clean'
	grunt.loadNpmTasks 'grunt-contrib-connect'
	grunt.loadNpmTasks 'grunt-contrib-copy'
	grunt.loadNpmTasks 'grunt-contrib-imagemin'
	grunt.loadNpmTasks 'grunt-contrib-jshint'
	grunt.loadNpmTasks 'grunt-contrib-sass'
	grunt.loadNpmTasks 'grunt-contrib-uglify'
	grunt.loadNpmTasks 'grunt-contrib-watch'
	
	grunt.loadNpmTasks 'grunt-autoprefixer'
	grunt.loadNpmTasks 'grunt-open'
	grunt.loadNpmTasks 'grunt-svgmin'
	grunt.loadNpmTasks 'grunt-static-inline'
	
	


	grunt.initConfig
		connect:
			all:
				options:
					port: 9000
					hostname: 'localhost'
			#dist:
			#	options:
			#		port: 9000
			#		hostname: 'localhost'
			#		base: './dist'
		
		open:
			all:
				path: 'http://localhost:9000/dev/'

		watch:
			options:
				livereload: true
			sass:
				files: 'dev/sass/**/*.scss'
				tasks: ['sass', 'autoprefixer']
			html:
				files: ['dev/*.html']
			javascript:
				files: 'dev/js/*.js'
				tasks: ['jshint']
			svg:
				files: 'dev/images/src/*.svg'
				tasks: ['svgmin']

		sass:
			dev:
				options:
					style: 'compact'
					sourcemap: true
				# files:
				# 	'dev/css/main.css': 'dev/sass/main.scss'
				# 	'dev/css/error.css': 'dev/sass/error.scss'
				files: [{
					expand: true,
					cwd: 'dev/sass/',
					src: ['*.scss'],
					dest: 'dev/css/',
					ext: '.css'
				}]
			dist:
				options:
					style: 'compressed'
					sourcemap: false
				files:
					'dist/css/main.css': 'dev/sass/main.scss'
					'dist/css/error.css': 'dev/sass/error.scss'

		jshint:
			options:
				debug: true
				globals:
				    jQuery: true
				    debugger: true
			dev: 'dev/js/*.js'

		svgmin:
			dev:
				files: [{
					expand: true,
					cwd: 'dev/images/src',
					src: ['**/*.svg'],
					dest: 'dev/images/',
					ext: '.svg'
				}]

		autoprefixer:
			dev:
				options:
					map: true
				expand: true
				flatten: true
				src: 'dev/css/*.css'
				dest: 'dev/css/'
			dist:
				expand: true
				flatten: true
				src: 'dist/css/*.css'
				dest: 'dist/css/'

		# Add inline="true" to the asset call : <link rel="stylesheet" href="css/main.css" inline="true">
		staticinline:
			dist:
				options:
					basepath: 'dist/'
				files:
					'dist/index.html': 'dist/index.html'
					'dist/404.html': 'dist/404.html'

		clean:
			files: 
				expand:	true,
				cwd: 'dist/',
				src: [
					'**/*'
					'!sftp-config.json'
				]

		imagemin:
			dist:
				files: [{
					expand: true,
					cwd: 'dist/images/',
					src: ['**/*.{png,jpg,gif}'],
					dest: 'dist/images/'
				}]

		copy:
			main:
				files: [{
					expand: true,
					cwd: 'dev',
					dest: 'dist',
					src: [
						'index.html',
						'404.html',
						# 'js/main.js',
						#'css/main.css',
						'css/visitor1.ttf',
						'images/*.{gif,webp,png,jpg,svg}',
						'cv/*'
						'robots.txt'
						'humans.txt'
						'.htaccess'
						'apple-touch-icon-precomposed.png'
						'favicon.ico'
					]
				}]

		uglify:
			dist:
				files:
					'dist/js/main.js': ['dev/js/main.js']






	grunt.registerTask 'default', ['jshint']

	grunt.registerTask 'server', [
		'jshint',
		'sass', 'autoprefixer',
		'svgmin',
		'connect', 'open:all', 'watch'
	]

	grunt.registerTask 'build', [
		'clean',
		'jshint', 'uglify',
		'sass:dist', 'autoprefixer:dist',
		'svgmin',
		'copy',
		'staticinline',
		'imagemin',
		'connect', 'open:all', 'watch'
	]










