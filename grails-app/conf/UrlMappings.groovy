class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"snippet", action:"list")
        "/login/*"(controller:"oauth", action:"auth")
		"500"(view:'/error')
	}
}
