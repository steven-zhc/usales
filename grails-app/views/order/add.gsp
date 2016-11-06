<!doctype html>
<html lang="en">
<head>
    <title>Create Order</title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
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
        <g:textField name="total"/>
    </div>
    <div>
        <button id="create-line" type="button">+</button>
    </div>
    <div>
        <table>
            <tr>
                <th>Product</th>
                <th>Quantity</th>
                <th>List Price</th>
                <th>Discount</th>
                <th>Sell Price</th>
                <th>Tax</th>
                <th>Shipping Fee</th>
                <th>Total</th>
                <th>Profit</th>
            </tr>

        </table>
    </div>
    <div id="line-form" title="Add an Order Line">
        <div>
            <label for="d_pid">Product</label>
            <select id="d_pid">
                <option value="volvo">Volvo</option>
                <option value="saab">Saab</option>
                <option value="mercedes">Mercedes</option>
                <option value="audi">Audi</option>
            </select>
        </div>

        <div>
            <label for="d_quantity">Quantity</label>
            <input type="text" id="d_quantity" value="1"/>
        </div>

        <div>
            <label for="d_list_price">List Price</label>
            <input type="text" id="d_list_price" readonly/>
        </div>

        <div>
            <label for="d_discount">Discount</label>
            <input type="text" id="d_discount">
        </div>

        <div>
            <label for="d_sell_price">Sell Price</label>
            <input type="text" id="d_sell_price"/>
        </div>
        <div>
            <span>0%</span><input type="range" id="d_percentage" min="0" max="100"/><span>100%</span>
        </div>

        <div>
            <label for="d_tax">Tax</label>
            <input type="text" id="d_tax" readonly/>
        </div>

        <div>
            <label for="d_shipping">Shipping Fee</label>
            <input type="text" id="d_shipping" value="0.00"/>
        </div>

        <div>
            <label for="d_total">Total</label>
            <input type="text" id="d_total" readonly/>
        </div>

        <div>
            <label for="d_profit">Profit</label>
            <input type="text" id="d_profit" readonly/>
        </div>

    </div>

</g:form>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
<script>

</script>
</body>
</html>
