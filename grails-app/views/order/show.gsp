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
        <input type="hidden" name="">
        <button type="submit">Checkout</button>
    </form>

    <form action="">
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
                        <td>${l.product.name}</td>
                        <td><input type="number" name="item[${i}].quantity" value="${l.quantity}"/></td>
                        <td>${l.product.listPrice}</td>
                        <td><input type="text" name="item[${i}].discountPrice" value="${l.discountPrice}"/></td>
                        <td><input type="text" name="item[${i}].sellPrice" value="${l.sellPrice}"/></td>
                        <td>${l.tax}</td>
                        <td><input type="text" name="item[${i}].shippingFee" value="${l.shippingFee}"></td>
                        <td>${l.lineTotal}</td>
                        <td>${l.lineProfit}</td>
                        <td>
                            <input type="hidden" name="item[${i}].id" value="${l.id}"/>
                            <input type="text" name="item[${i}].note" value="${l.note}"/>
                        </td>
                        <td><a href="/order/delete/${l.id}">Delete</a></td>
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
        <button type="submit">Save</button>
    </form>
</g:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<script>

var products = ${products.encodeAsRaw()}

function calculateTax(n) {
    return n * 0.0875;
}
function calculatePrice(quantity, price, shipping) {
    return quantity * (price + calculateTax(price)) + shipping;
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
            '<select name="item[' + count + '].name">' +
                '<option value="">Select one product ...</option>' + optionlist +
            '</td>' + 
            '<td><input type="number" name="item[' + count + '].quantity" value="1"/></td>' +
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].discountPrice" class="discount_tag" disabled/></td>' +  
            '<td><input type="text" name="item[' + count + '].sellPrice" class="sell_tag" disabled/></td>' +  
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].shippingFee" class="shipping_tag" value="0.0"/></td>' +  
            '<td></td>' +  
            '<td></td>' +  
            '<td><input type="text" name="item[' + count + '].note" /></td>' +
            '<td><a href="#">Delete</a></td>' +
            '</tr>';
        $("#line_table tbody").prepend(str);

        $("#line_table tbody").find("input:not([name$='note'])").each(function(index) {
            $(this).change(function() {
                settleAccount($(this).parent().parent());
            });
        });

        $("#line_table tbody").find("select").each(function(index) {

            $(this).change(function() {
                var pid = $(this).val();
                var product = null;
                $.each(products.list, function(i, p) {
                    if (p.id == pid) {
                        product = p;
                        return;
                    }
                });

                if (product != null) {
                    var quantityTag = $(this).parent().next();

                    var listPriceTag = quantityTag.next();
                    listPriceTag.text(product.price);

                    var discountTag = listPriceTag.next();
                    discountTag.children("input").val(product.price).prop('disabled', false);

                    var sellPriceTag = discountTag.next();
                    sellPriceTag.children("input").val(product.price).prop('disabled', false);

                    settleAccount($(this).parent().parent());
                }
            });
        });
    });

    function settleAccount(tr) {
        var quantityTag = tr.children("td:first-child").next();
        var quantity = parseInt(quantityTag.children("input").val()); 

        var listPriceTag = quantityTag.next();
        var listPrice = parseFloat(listPriceTag.text());

        var discountTag = listPriceTag.next();
        var discount = parseFloat(discountTag.children("input").val());

        var sellPriceTag = discountTag.next();
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
    }
    

});

</script>
</body>
</html>
