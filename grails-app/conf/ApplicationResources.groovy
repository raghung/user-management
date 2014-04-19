modules = {
    application {
        resource url:'js/application.js'
    }
	
	
	bootstrapJS {
		dependsOn 'jquery'
		
		resource url: 'js/bootstrap.min.js'
		resource url: 'js/bootstrap3-typeahead.min.js'
	}
	
	bootstrapCSS {
		resource url: 'css/bootstrap_custom.min.css'
		resource url: 'css/custom.css'
	}
}