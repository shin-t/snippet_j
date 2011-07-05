<html>
<head>
	<title>Snippet list</title>
	<style type="text/css">
		table{border:2px #cccccc solid;}
		th{border:2px #aaaaaa solid;}
		td{border:1px #888888 solid;}
	</style>
	<g:javascript library="jquery" plugin="jquery" />
	<g:javascript src="common.js" />
</head>
<body>
<h1>Snippet list</h1>
<g:form action="index">
	<g:textField id="keyword" name="keyword" value="keyword" />
	<g:submitButton name="search" />
</g:form>
<table>
	<tr>
		<th>name</th>
		<th>language</th>
		<th>comment</th>
		<th>snippet</th>
	</tr>
	<g:each in="${snippets}">
		<tr>
			<td>${it.name.encodeAsHTML()}</td>
			<td>${it.language.encodeAsHTML()}</td>
			<td>${it.comment.encodeAsHTML()}</td>
			<td><pre><code>${it.snippet.encodeAsHTML()}</code></pre></td>
		</tr>
	</g:each>
</table>
<g:link action="add">add</g:link>
</body>
</html>