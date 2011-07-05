<html>
<head>
	<title>Snippet list</title>
	<g:javascript library="jquery" plugin="jquery" />
	<g:javascript src="common.js" />
</head>
<body>
<h1>Snippet</h1>
<g:form action="add">
	<g:textField id="name" name="name" value"" /><br/>
	<g:textField id="language" name="language" value"" /><br/>
	<g:textField id="comment" name="comment" value"" /><br/>
	<g:textArea id="snipet" name="snippet" value="" rows="20" cols="80" /><br/>
	<g:submitButton name="submit" />
</g:form>
<g:link action="index">back</g:link>
</body>
</html>