<!doctype html>
<html lang="en">
<head>
    <title>Create Order</title>
    
</head>
<body>

<h1>Create Order</h1>

<g:form action="save">

    <div>
        <g:submitButton name="submit" value="Create Product"/>
    </div>

    <div>
        <label for="name">Date</label>
        <g:datePicker name="dateCreated" value="${new Date()}"
                      precision="day"
                      noSelection="['':'-Choose-']"/>
    </div>

    <div>
        <label for="note">Description</label>
        <g:textArea name="note"/>
    </div>

    <div>
        <label for="profit">Profit</label>
        <g:textField name="profit"/>
    </div>

    <div>
        <label for="total">Total Price</label>
        <g:textField name="total" />
    </div>

</g:form>


</body>
</html>
