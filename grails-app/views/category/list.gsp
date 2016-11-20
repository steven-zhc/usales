<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Query Category</title>
</head>
<body>
    <h1>Category List</h1>
    
    <button type="button" onclick="location.href='/category/add'" >New Category</button>
    
    <div class="">
        <g:form action="list">
            <label for="name">Category Name</label>
            <g:textField name="name" value="${name}" />
            <g:submitButton name="submit" value="Search" />
        </g:form>
    </div>
    <div class="">
        <table>
            <tr>
                <th>Name</th>
                <th>Parent</th>
            </tr>
            <g:each var="c" in="${categories}">
            <tr>
                <td>${c.name}</td>
                <td>${c.parent?.name}</td>
            </tr>
            </g:each>
        </table>
    </div>
</body>
</html>
