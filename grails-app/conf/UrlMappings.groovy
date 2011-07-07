class UrlMappings {

	static mappings = {
		"/$controller/$action?/$id?"{
			constraints {
				// apply constraints here
			}
		}

		"/"(controller:"snippet", action:"list")
		"/$id"(controller:"snippet", action="list")
		"500"(view:'/error')
	}
}
