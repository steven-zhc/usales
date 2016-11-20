<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Show Order</title>
</head>
<body>

<g:if test="${order}">
    <h1>Order ID: ${order.id}</h1>
    <h3>${order.dateCreated.format('MM/dd/yyyy')} - ${message(code:'order.status.value.'+fieldValue(bean: order, field:
        "status"))}</h3>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <form action="/order/update">
        <input type="hidden" name="id" value="${order.id}">

        <g:if test="${order.status == 1}">
            <button type="submit" name="status" value="0">Cancel</button>
        </g:if>

        <g:if test="${order.status == 1}">
            <button type="submit" name="status" value="2">Checkout</button>
            <div><textarea id="note" name="note">${order.note}</textarea></div>
        </g:if>
        <g:elseif test="${order.status == 2}" >
            
            <button type="submit" name="status" value="3">Shipping</button>

            <div>
                <span>Shipping Fee</span>
                <input type="text" id="deliverFee" name="deliverFee" value="${order.deliverFee}"/>
            </div>
            
            <div>
                <span>Tracking #</span>
                <input type="text" id="trackingNo" name="trackingNo" value="${order.trackingNo}"/>
            </div>
            
            <div><textarea id="note" name="note">${order.note}</textarea></div>
        </g:elseif>
        <g:elseif test="${order.status == 3}" >
            <input type="text" name="payment" value="0.0" />
            <button type="submit" name="status" value="4">Pay off</button>
            <div>
                <span>Shipping Fee</span>
                <span>${order.deliverFee}</span>
            </div>
            <div>
                <span>Tracking #</span>
                <span>${order.trackingNo}</span>
            </div>

            <div><textarea id="note" name="note">${order.note}</textarea></div>
        </g:elseif>
        <g:elseif test="${order.status == 4}">
            <div>${order.note}</div>
        </g:elseif>
        

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
                        <td>${l.product.name}<input type="hidden" name="items[${i}].pid" value="${l.product.id}"/></td>
                        <td><input type="number" name="items[${i}].quantity" value="${l.quantity}" min="1" max="1000" onchange="updateNumber.apply(this);"/></td>
                        <td><span>${l.product.listPrice}</span></td>
                        <td><input type="text" name="items[${i}].discountPrice" value="${l.discountPrice}" onchange="updateDiscountPrice.apply(this);"/></td>
                        <td><input type="text" value="${l.rate}" onchange="updateRate.apply(this);" size="2"/>%</td>
                        <td><input type="text" name="items[${i}].sellPrice" value="${l.sellPrice}" onchange="updateSellPrice.apply(this);"/></td>
                        <td><span>${l.tax}</span><input type="hidden" name="items[${i}].tax" value="${l.tax}"/></td>
                        <td><input type="text" name="items[${i}].shippingFee" value="${l.shippingFee}" onchange="udpateShipping.apply(this);"></td>
                        <td><span>${l.lineTotal}</span><input type="hidden" name="items[${i}].lineTotal" value="${l.lineTotal}"/></td>
                        <td><span>${l.lineProfit}</span><input type="hidden" name="items[${i}].lineProfit" value="${l.lineProfit}"/></td>
                        <td>
                            <input type="hidden" name="items[${i}].id" value="${l.id}"/>
                            <input type="text" name="items[${i}].note" value="${l.note}"/>
                        </td>
                        <td><button type="button" onclick="deleteLine.apply(this)">Remove</button></td>
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
            <span>Profit Price</span><span id="order_profit_price">${order.profit}</span>
            <input type="hidden" id="profit" name="profit" value="${order.profit}"/>
        </div>
        <g:if test="${order.status == 1}">
            <button type="submit">Save</button>
        </g:if>
        <g:if test="${order.status == 4}">
            <div>
                <span>Payment</span><span>${order.payment}</span>
            </div>
        </g:if>
    </form>
</g:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<asset:javascript src="order.js" />

<script>

var products = ${products.encodeAsRaw()};

$( function() {
    $("#add_line_btn").click(function (e) {
        e.preventDefault();
        addOrderLine(products);
    });

    $("#deliverFee").change(function (e) {
        e.preventDefault();
        updateDeliverFee();
    });
});

</script>
</body>
</html>
