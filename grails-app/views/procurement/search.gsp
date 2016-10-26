<!doctype html>
<html lang="en">
<head>
    <title>Search Procurement</title>
    <meta name="layout" content="main">
</head>
<body>
<formset>
    <legend>Search for Procurement</legend>
    <g:form action="searchResult">
        <label for="pname">Product Name</label>
        <g:textField name="pname"/>

        <label for="start_date">Start Date</label>
        <g:textField name="start_date"></g:textField>

        <label for="end_date">Start Date</label>
        <g:textField name="end_date"></g:textField>

        <label for="pstatus">Start Date</label>
        <g:textField name="pstatus"></g:textField>

        <g:submitButton name="search" value="Search"/>
    </g:form>
</formset>

</body>
</html>
