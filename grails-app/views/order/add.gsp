<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main" />
    <title>Create Order</title>

    <asset:stylesheet src="order.css"/>
</head>

<body>
<h1>Create Order</h1>
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

<form action="/order/save" method="post">

    <input type="hidden" name="status" value="1"/>

    <div>
        <button type="submit">Create Order</button>
    </div>

    <div>
        <label for="date">Date</label>
        <input id="date" name="date" value="${new Date().format('MM/dd/yyyy')}"/>
    </div>
    <div>
        <label for="note">Note</label>
        <input type="text" name="note" />
    </div>

    <div>
        <label for="order_total">Order Total</label>
        <span id="order_total">0.0</span>
    </div>
    <div>
        <label for="order_profit">Order Profit</label>
        <span id="order_profit">0.0</span>
    </div>

    <div>
        <button id="add_line_btn" type="button">+</button>
    </div>

    <div id="items">
        
    </div>
</form>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<asset:javascript src="order.js" />

<script>
                
var products = ${products.encodeAsRaw()};

$( function() {
    addOrderLine(products);
    
    $("#add_line_btn").click(function (e) {
        addOrderLine(products);
    });
});

</script>

</body>
</html>