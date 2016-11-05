<!doctype html>
<html lang="en">
<head>
    <title>Create Product</title>
</head>
<body>

<h1>Create Category</h1>
<g:form action="save">
    <div>
        <label for="name">Product Name</label>
        <g:textField name="name"/>
    </div>

    <div>
        <label for="cid">Category</label>
        <g:select name="cid" optionKey="id" optionValue="name" from="${categories}"
                  noSelection="${['':'Select One...']}"/>
    </div>

    <div>
        <label for="listPrice">List Price</label>
        <g:textField name="listPrice"/>
    </div>

    <div>
        <label for="description">Description</label>
        <g:textArea name="description"/>
    </div>

    <div>
        <g:submitButton name="submit" value="Create Product"/>
    </div>

</g:form>


</body>
</html>
