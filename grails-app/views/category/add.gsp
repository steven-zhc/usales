<!doctype html>
<html lang="en">
<head>
    <title>Create Category</title>
</head>
<body>

<h1>Create Category</h1>
<g:form action="addCategory" class="form-horizontal">
    <div class="form-horizontal">
        <label for="name" class="col-sm-2 control-label">Category Name</label>
        <g:textField name="name" class="form-control"/>
    </div>

    <div class="form-group">
        <label for="parent" class="col-sm-2 control-label">Parent Category</label>
        <g:select name="parent" optionKey="id" optionValue="name" from="${categories}" class="form-control"/>
    </div>

    <div class="form-group">
        <label for="description" class="col-sm-2 control-label">Description</label>
        <g:textArea name="description" class="form-control"/>
    </div>

    <div class="form-group">
        <g:submitButton name="create_category" value="Create Category" class="btn btn-default"/>
    </div>
    
</g:form>


</body>
</html>
