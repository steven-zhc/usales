<!doctype html>
<html lang="en">
<head>
    <title>Create Category</title>
</head>
<body>

<h1>Create Category</h1>

<g:renderErrors bean="${category}">
    <ul>
        <g:eachError var="error" bean="${category}">
            <li>${error}</li>
        </g:eachError>
    </ul>
</g:renderErrors>

<form action="/category/save" method="post">
    <div>
        <label for="name">Category Name</label>
        <input type="text" id="name" name="name" value="${category?.name}" />
    </div>

    <div>
        <label for="parent" class="col-sm-2 control-label">Parent Category</label>
        <g:select name="parent" optionKey="id" optionValue="name" from="${categories}"
            noSelection="${['':'Select One...']}"
            value="${category?.parent?.name}" class="form-control"/>
    </div>

    <div>
        <button type="submit" name="submit">Create Category</button>
    </div>

</form>


</body>
</html>
