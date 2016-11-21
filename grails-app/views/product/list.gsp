<!doctype html>
<html lang="en">
<head>
    <meta name="layout" content="main" />
    <title>Search Product</title>
</head>
<body>
<div>
    <h1>Product List</h1>

    <button type="button" onclick="location.href='/product/add'" >New Product</button>

    <g:form action="list">
        <label for="name">Product Name</label>
        <g:textField name="name" value="${cmd?.name}"/>

        <label for="cid">Product Category</label>
        <g:select name="cid" from="${categories}"
                  optionKey="id" optionValue="name"
                  noSelection="${['':'Select One...']}"
                  value="${cmd?.cid}"/>

        <g:submitButton name="search_button" value="Search"/>

    </g:form>
</div>

<div class="">
    <table>
        <tr>
            <th>Name</th>
            <th>Category</th>
            <th>List Price</th>
            <th>Description</th>
        </tr>
        <g:each var="p" in="${products}">
            <tr>
                <td>${p.name}</td>
                <td>${p.category.name}</td>
                <td>${p.listPrice}</td>
                <td>${p.description}</td>
            </tr>
        </g:each>
    </table>
</div>

</body>
</html>