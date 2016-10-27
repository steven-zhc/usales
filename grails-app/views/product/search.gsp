<!doctype html>
<html lang="en">
<head>
    <title>Search Product</title>
    <meta name="layout" content="main">
</head>
<body>
<formset>
    <legend>Search for Product</legend>
    <g:form action="searchResult">
        <label for="product.name">Product Name</label>
        <g:textField name="product.name"/>

        <label for="product.category">Product Category</label>
        <g:select optionKey="id" optionValue="name"
                  name="product.category" from="${categories}" />

        <g:submitButton name="search" value="Search"/>
    </g:form>
</formset>

</body>
</html>