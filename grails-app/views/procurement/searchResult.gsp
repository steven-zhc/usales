<!doctype html>
<html lang="en">
<head>
    <title>Search Result</title>
    <meta name="layout" content="main">
</head>
<body>
    <h1>Results</h1>
    <p>Found ${procurements.size()}</p>
    <ul>
        <g:each var="p" in="${procurements}">
            <li>${p}</li>
        </g:each>
    </ul>
    <g:link action="search">Search Again</g:link>

</body>
</html>
