<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Show Order</title>
    <style>
table, td, th {
    border: 1px solid #ddd;
}

table {
    border-collapse: collapse;
    width: 100%;
}

th, td {
    padding: 10px;
}


    </style>
</head>
<body>

<g:if test="${order}">
    <h1>${order.id}</h1>
    <h3>Tracking #: ${order.trackingNo}</h3>

    <h3><a href="#">${order.dateCreated.format('yyyy-MM-dd')} USD -> CNY <span id="currency_exchange">N/A</span></a></h3>

    <table class="item_header">
        <tr class="label_row">
            <th>Product</th>
            <th>Price</th>
            <th>Quantity</th>
            <th>Tax</th>
            <th>Discount</th>
            <th>Shipping</th>
            <th>Total</th>
        </tr>
        <g:each var="l" in="${order.lines}" status="i">
            <tr>
                <td>${l.product.name}</td>
                <td>${l.sell.price}</td>
                <td>${l.quantity}</td>
                <td>${l.sell.tax}</td>
                <td>${l.sell.discount}</td>
                <td>${l.sell.shipping}</td>
                <td class="item_total">${l.lineTotal}</td>
            </tr>
        </g:each>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td align="right">Deliver Fee</td>
            <td>${order.deliverFee}</td>
        </tr>
        <tr>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td></td>
            <td align="right">Total</td>
            <td>${order.total}</td>
        </tr>
    </table>
</g:if>

<asset:javascript src="application.js"/>
<script>
var url = "http://api.fixer.io/${order.dateCreated.format('yyyy-MM-dd')}?base=USD&symbols=CNY";

$( function() {
    $.getJSON(url, function(result) {
        $("#currency_exchange").text(result.rates.CNY);
    });
});

</script>
</body>
</html>
