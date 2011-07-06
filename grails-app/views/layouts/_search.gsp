<div id="search">
	<g:form url='[controller: "snippet", action: "search"]'
			id="searchableForm"
			name="searchableForm"
			method="get">
		<g:textField name="q" value="${params.q}" />
		<input type="submit" value="Search" />
	</g:form>
</div>
