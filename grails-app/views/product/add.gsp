<!doctype html>
<html lang="en" xmlns:g="http://www.w3.org/1999/xhtml">
<head>
    <meta name="layout" content="main" />
    <title>Create Product</title>
</head>
<body>

<h1>Create Product</h1>

<g:renderErrors bean="${cmd}">
    <ul>
        <g:eachError var="err" bean="${cmd}">
            <li>${err}</li>
        </g:eachError>
    </ul>
</g:renderErrors>

<g:renderErrors bean="${model}">
    <ul>
        <g:eachError var="err" bean="${model}">
            <li>${err}</li>
        </g:eachError>
    </ul>
</g:renderErrors>

<form action="/product/save" method="post">
    <div>
        <label for="name">Product Name</label>
        <input type="text" id="name" name="name"/>
    </div>

    <div>
        <label for="cid">Category</label>
        <g:select name="cid" optionKey="id" optionValue="name" from="${categories}"
                  noSelection="${['':'Select One...']}"/>
        <button type="button" onclick="location.href='/category/add'" >New Category</button>
    </div>

    <div>
        <label for="listPrice">List Price</label>
        <input type="text" id="listPrice" name="listPrice"/>
    </div>

    <div>
        <label for="description">Description</label>
        <textarea name="description" id="description" cols="30" rows="10"></textarea>
    </div>

    <div>
        <button type="submit">Create Product</button>
    </div>

</form>

</body>
</html>