<!doctype html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <title>Create Order</title>
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
        <textarea name="note" id="note"></textarea>
    </div>

    <div>
        <button id="add_line_btn" type="button">+</button>
    </div>

    <table id="line_table">
        <thead>
        <tr>
            <td>Product</td>
            <td>Quantity</td>
            <td>List Price</td>
            <td>Discount Price</td>
            <td>Rate</td>
            <td>Sell Price</td>
            <td>Tax</td>
            <td>Shipping</td>
            <td>Total</td>
            <td>Profit</td>
            <td>Note</td>
            <td>Action</td>
        </tr>
        </thead>
        <tbody>
            <g:each var="l" in="${order?.lines}" status="i">
                <tr>
                    <td>${l.product.name}<input type="hidden" name="newItems[${i}].pid" value="${l.product.id}"/></td>
                    <td><input type="number" name="newItems[${i}].quantity" value="${l.quantity}" min="1" max="1000" onchange="updateNumber.apply(this);"/></td>
                    <td><span>${l.product.listPrice}</span></td>
                    <td><input type="text" name="newItems[${i}].discountPrice" value="${l.discountPrice}" onchange="updateDiscountPrice.apply(this);"/></td>
                    <td><input type="text" value="${l.rate}" onchange="updateRate.apply(this);" size="2"/>%</td>
                    <td><input type="text" name="newItems[${i}].sellPrice" value="${l.sellPrice}" onchange="updateSellPrice.apply(this);"/></td>
                    <td><span>${l.tax}</span><input type="hidden" name="newItems[${i}].tax" value="${l.tax}"/></td>
                    <td><input type="text" name="newItems[${i}].shippingFee" value="${l.shippingFee}" onchange="udpateShipping.apply(this);"></td>
                    <td><span>${l.lineTotal}</span><input type="hidden" name="newItems[${i}].lineTotal" value="${l.lineTotal}"/></td>
                    <td><span>${l.lineProfit}</span><input type="hidden" name="newItems[${i}].lineProfit" value="${l.lineProfit}"/></td>
                    <td>
                        <input type="hidden" name="newItems[${i}].id" value="${l.id}"/>
                        <input type="text" name="newItems[${i}].note" value="${l.note}"/>
                    </td>
                    <td><button type="button" onclick="deleteLine.apply(this)">Remove</button></td>
                </tr>
            </g:each>
        </tbody>
    </table>
    <div>
        <span>Total Price</span><span id="order_total_price">0.0</span>
        <input type="hidden" id="total" name="total" value="0.0"/>
    </div>
    <div>
        <span>Profit Price</span><span id="order_profit_price">0.0</span>
        <input type="hidden" id="profit" name="profit" value="0.0"/>
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