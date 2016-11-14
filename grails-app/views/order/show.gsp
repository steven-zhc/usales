<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Show Order</title>
</head>
<body>
<h1>Order ID: ${order.id}</h1>
<h3>${order.dateCreated.format('MM/dd/yyyy')} - ${message(code:'order.status.value.'+fieldValue(bean: order, field: "status"))}</h3>

<form action="">
    <button type="submit">Checkout</button>
</form>

<form action="">
    <div>${order.note}</div>
    <table>
        <thead>
        <tr>
            <td>Product</td>
            <td>List Price</td>
            <td>Discount Price</td>
            <td>Sell Price</td>
            <td>Note</td>
        </tr>
        </thead>
        <tbody>
        <g:each var="l" in="${order.lines}">
            <tr>
                <td>${l.product.name}</td>
                <td>${l.product.listPrice}</td>
                <td>${l.discountPrice}</td>
                <td>${l.sellPrice}</td>
                <td>${l.note}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
    <button type="submit">Save</button>
</form>
</body>
</html>