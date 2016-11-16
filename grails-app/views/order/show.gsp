<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Show Order</title>
</head>
<body>
<g:if test="${message}">
    <div class="message" role="status">${message}</div>
</g:if>

<g:if test="${order}">
    <h1>Order ID: ${order.id}</h1>
    <h3>${order.dateCreated.format('MM/dd/yyyy')} - ${message(code:'order.status.value.'+fieldValue(bean: order, field:
        "status"))}</h3>

    <form action="/order/status">
        <input type="hidden" name="id">
        <button type="submit">Checkout</button>
    </form>

    <form action="/order/update">
        <div><textarea id="order_note" name="order_note">${order.note}</textarea></div>

        <g:if test="${order.status == 1}">
            <button type="button" id="add_line_btn">+</button>
        </g:if>

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
                <g:if test="${order.status == 1}">
                    <td>Action</td>
                </g:if>
            </tr>
            </thead>

            <tbody>
            <g:if test="${order.status == 1}">
                <g:each var="l" in="${order.lines}" status="i">
                    <tr>
                        <td>${l.product.name}<input type="hidden" name="item[${i}].pid" value="${l.product.id}"/></td>
                        <td><input type="number" name="item[${i}].quantity" value="${l.quantity}" min="1" max="1000" onchange="updateNumber.apply(this);"/></td>
                        <td>${l.product.listPrice}</td>
                        <td><input type="text" name="item[${i}].discountPrice" value="${l.discountPrice}" onchange="updateDiscountPrice.apply(this);"/></td>
                        <td><input type="text" value="${l.rate}" onchange="updateRate.apply(this);" size="2"/>%</td>
                        <td><input type="text" name="item[${i}].sellPrice" value="${l.sellPrice}" onchange="updateSellPrice.apply(this);"/></td>
                        <td>${l.tax}</td>
                        <td><input type="text" name="item[${i}].shippingFee" value="${l.shippingFee}" onchange="udpateShipping.apply(this);"></td>
                        <td>${l.lineTotal}</td>
                        <td>${l.lineProfit}</td>
                        <td>
                            <input type="hidden" name="item[${i}].lid" value="${l.id}"/>
                            <input type="text" name="item[${i}].note" value="${l.note}"/>
                        </td>
                        <td><a href="#" onclick="deleteLine.apply(this);">Delete</a></td>
                    </tr>
                </g:each>
            </g:if>
            <g:else>
                <g:each var="l" in="${order.lines}">
                    <tr>
                        <td>${l.product.name}</td>
                        <td>${l.quantity}</td>
                        <td>${l.product.listPrice}</td>
                        <td>${l.discountPrice}</td>
                        <td>${l.getRate()}</td>
                        <td>${l.sellPrice}</td>
                        <td>${l.tax}</td>
                        <td>${l.shippingFee}</td>
                        <td>${l.lineTotal}</td>
                        <td>${l.lineProfit}</td>
                        <td>${l.note}</td>
                    </tr>
                </g:each>
            </g:else>
            </tbody>
        </table>
        <div>
            <span>Total Price</span><span id="order_total_price">${order.total}</span>
            <input type="hidden" id="total" name="total" value="${order.total}"/>
        </div>
        <div>
            <span>Total Price</span><span id="order_profit_price">${order.profit}</span>
            <input type="hidden" id="profit" name="profit" value="${order.profit}"/>
        </div>
        <g:if test="${order.status == 1 || order.status == 2}">
            <button type="submit">Save</button>
        </g:if>
    </form>
</g:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

var products = ${products.encodeAsRaw()}

function calculateRate(p1, p2) {
    return 100 * (1 - p1 / p2);
}
function calculateTax(n) {
    return n * 0.0875;
}
function calculatePrice(quantity, price, shipping) {
    return quantity * (price + calculateTax(price)) + shipping;
}

function updateProduct() {
    var pid = $(this).val();
    var product = null;
    $.each(products.list, function(i, p) {
        if (p.id == pid) {
            product = p;
            return;
        }
    });

    if (product != null) {
        $(this).next().val(pid);
        var quantityTag = $(this).parent().next();

        var listPriceTag = quantityTag.next();
        listPriceTag.text(product.price);

        var discountTag = listPriceTag.next();
        discountTag.children("input").val(product.price).prop('disabled', false);

        var sellPriceTag = discountTag.next().next();
        sellPriceTag.children("input").val(product.price).prop('disabled', false);

        settleAccount($(this).parent().parent());
    }
}

function updateNumber() {
    settleAccount($(this).parent().parent());
}

function updateRate() {
    var v = parseFloat($(this).val());
    var rate = 1.0 +  v / 100;
    var discount = parseFloat($(this).parent().prev().children("input").val());
    var sellPriceTag = $(this).parent().next().children("input");

    sellPriceTag.val((discount * rate).toFixed(2));

    settleAccount($(this).parent().parent());
}

function updateDiscountPrice() {
    var discount = parseFloat($(this).val());
    var sell = parseFloat($(this).parent().next().next().children("input").val());
    var rateTag = $(this).parent().next().children("input");

    rateTag.val(calculateRate(discount, sell).toFixed(0));

    settleAccount($(this).parent().parent());
}

function updateSellPrice() {
    var discount = parseFloat($(this).parent().prev().prev().children("input").val());
    var sell = parseFloat($(this).val());
    var rateTag = $(this).parent().prev().children("input");

    rateTag.val(calculateRate(discount, sell).toFixed(0));

    settleAccount($(this).parent().parent());
}

function updateShipping() {
    settleAccount($(this).parent().parent());
}

function settleAccount(tr) {
    var quantityTag = tr.children("td:first-child").next();
    var quantity = parseInt(quantityTag.children("input").val()); 

    var listPriceTag = quantityTag.next();
    var listPrice = parseFloat(listPriceTag.text());

    var discountTag = listPriceTag.next();
    var discount = parseFloat(discountTag.children("input").val());

    var rateTag = discountTag.next();
    var rate = parseInt(rateTag.children("input").val());

    var sellPriceTag = rateTag.next();
    var sellPrice = parseFloat(sellPriceTag.children("input").val());

    var taxTag = sellPriceTag.next();
    var tax = calculateTax(sellPrice);
    taxTag.text(tax.toFixed(2));

    var shippingTag = taxTag.next();
    var shipping = parseFloat(shippingTag.children("input").val());

    var totalTag = shippingTag.next();
    var total = calculatePrice(quantity, sellPrice, shipping);
    totalTag.text(total.toFixed(2));

    var profitTag = totalTag.next();
    var profit = total - calculatePrice(quantity, discount, shipping);
    profitTag.text(profit.toFixed(2));

    updateOrderAccount();
}

function updateOrderAccount() {
    var sum = 0.0;
    $("#line_table tbody tr").each(function(){
        var v = parseFloat($(this).find("td:nth-last-child(4)").text());
        sum += v;
    });
    $("#order_total_price").text(sum);
    $("#total").val(sum);

    sum = 0.0
    $("#line_table tbody tr").each(function(){
        sum += parseFloat($(this).find("td:nth-last-child(3)").text());
    });
    $("#order_profit_price").text(sum);
    $("#profit").val(sum);
}

function deleteLine() {
    var tr = $(this).parent().parent();
    tr.remove();

    updateOrderAccount();
}

$( function() {

    $("#add_line_btn").click(function () {
        var count = $("#line_table tbody").children("tr").length;
        var optionlist = "";
        $.each(products.list, function(i, p) {
            optionlist += $('<option>').text(p.name).attr('value', p.id).prop('outerHTML');
        });
        
        var str = '<tr>' +
            '<td>' +
            '<select name="item[' + count + '].name" onchange="updateProduct.apply(this);">' +
                '<option value="">Select one product ...</option>' + optionlist +
            '</select>' + 
            '<input type="hidden" name="item[' + count + '].pid" value="0"/>' +
            '</td>' + 
            '<td><input type="number" name="item[' + count + '].quantity" value="1" min="1" max="1000" onchange="updateNumber.apply(this);"/></td>' +
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].discountPrice" class="discount_tag" disabled onchange="updateDiscountPrice.apply(this);"/></td>' +
            '<td><input type="text" value="0" onchange="updateRate.apply(this);" size="2"/>%</td>' + 
            '<td><input type="text" name="item[' + count + '].sellPrice" class="sell_tag" disabled onchange="updateSellPrice.apply(this);"/></td>' +  
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].shippingFee" class="shipping_tag" value="0.0" onchange="udpateShipping.apply(this);"/></td>' +  
            '<td></td>' +  
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].note" />' +
            '<input type="hidden" name="item[' + count + '].lid" value="0"/></td>' +
            '<td><a href="#" onclick="deleteLine.apply(this);">Delete</a></td>' +
            '</tr>';
        $("#line_table tbody").prepend(str);
    });

});

</script>
</body>
</html>
