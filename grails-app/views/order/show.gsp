<!doctype html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main" />
    <title>Show Order</title>

    <asset:stylesheet src="order.css"/>
</head>
<body>

<g:if test="${order}">
    <h1>Order ID: ${order.id}</h1>
    <h3>${order.dateCreated.format('MM/dd/yyyy')} - ${message(code:'order.status.value.'+fieldValue(bean: order, field:
        "status"))}</h3>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <g:renderErrors bean="${order}">
        <ul>
            <g:eachError var="err" bean="${order}">
                <li>${err}</li>
            </g:eachError>
        </ul>
    </g:renderErrors>

    <form action="/order/update">
        <input type="hidden" name="id" value="${order.id}">

        <g:if test="${order.status == 1}">
            <button type="submit" name="status" value="0">Cancel</button>
            <button type="submit" name="status" value="2">Checkout</button>
            <div><input type="text" name="note" value="${order.note}"/></div>
        </g:if>
        <g:elseif test="${order.status == 2}" >
            
            <button type="submit" name="status" value="3">Shipping</button>

            <div>
                <span>Deliver Fee</span>
                <input type="text" id="deliverFee" name="deliverFee" value="${order.deliverFee}" onchange="updateDeliverFee();"/>
            </div>
            
            <div>
                <span>Tracking #</span>
                <input type="text" id="trackingNo" name="trackingNo" value="${order.trackingNo}"/>
            </div>
            
            <div><input type="text" name="note" value="${order.note}"/></div>
        </g:elseif>
        <g:elseif test="${order.status == 3}" >
            <input type="text" name="payment" value="0.0" />
            <button type="submit" name="status" value="4">Pay off</button>
            <div>
                <label>Deliver Fee</span>
                <span>${order.deliverFee}</span>
            </div>
            <div>
                <label>Tracking #</span>
                <span>${order.trackingNo}</span>
            </div>

            <div><input type="text" name="note" value="${order.note}"/></div>
        </g:elseif>
        <g:elseif test="${order.status == 4}">
            <div>${order.note}</div>
            <div>
                <label>Deliver Fee</span>
                <span>${order.deliverFee}</span>
            </div>
            <div>
                <label>Payment</label>
                <span>${order.payment}</span>
            </div>
        </g:elseif>
        
        <div>
            <label>Order Total</label>
            <span>${order.total}</span>
        </div>
        <div>
            <label>Order Profit</label>
            <span>${order.profit}</span>
        </div>
        
        <g:if test="${order.status == 1}">
            <button type="button" id="add_line_btn">+</button>
            <button type="submit">Save</button>
        </g:if>
        <g:elseif test="${order.status in 2..3}">
            <button type="submit">Save</button>
        </g:elseif>

        <div id="items">
        <g:if test="${order.status == 1}">    
            <g:each var="l" in="${order.lines}" status="i">
            <div class="order_line">
                <input type="hidden" name="items[${i}].id" value="${l.id}"/>
                <table class="item_header">
                    <tr><td>Product</td><td>List Price</td><td>Quantity</td><td>Total</td><td>Profit</td><td>Model</td><td>Note</td><td></td></tr>
                    <tr>
                        <td>
                            <g:if test="${l.product.url}">
                                <a href="${l.product.url}">${l.product.name}</a>
                            </g:if>
                            <g:else>
                                ${l.product.name}
                            </g:else>
                            <input type="hidden" name="items[${i}].pid" value="${l.product.id}"/>
                        </td>
                        <td>${l.product.listPrice}</td>
                        <td><input type="number" name="items[${i}].quantity" value="${l.quantity}" min="1" max="1000" onchange="quantityChanged.apply(this);" /> </td>
                        <td class="item_total">0.0</td>
                        <td class="item_profit">0.0</td>
                        <td><input type="text" name="items[${i}].model" value="${l.model}" /></td>
                        <td><input type="text" name="items[${i}].note" value="${l.note}" /></td>
                        <td><button type="button" onclick="deleteLine.apply(this)">Remove</button></td>
                    </tr>
                </table>
                <table class="item_body">
                    <tr>
                        <td></td>
                        <td>Unit Price</td>
                        <td>Quantity</td>
                        <td>Tax</td>
                        <td>Discount</td>
                        <td>Shipping</td>
                        <td>Total</td>
                    </tr>
                    <tr class="item_purchase">
                        <td>Purchase</td>
                        <td><input type="text" name="items[${i}].purchase.price" value="${l.purchase.price}" onchange="unitPriceChanged.apply(this);"/></td>
                        <td>${l.quantity}</td>
                        <td><input type="text" name="items[${i}].purchase.tax" value="${l.purchase.tax}" onchange="numValueChanged.apply(this);"/></td>
                        <td><input type="text" name="items[${i}].purchase.discount" value="${l.purchase.discount}" value="-0.0" onchange="numValueChanged.apply(this);"/></td>
                        <td><input type="text" name="items[${i}].purchase.shipping" value="${l.purchase.shipping}" onchange="numValueChanged.apply(this);"/></td>
                        <td class="total_purchase">0.0</td>
                    </tr>
                    <tr>
                        <td></td><td><input type="text" size="2"></td><td></td><td></td><td></td><td></td><td></td>
                    </tr>
                    <tr class="item_sell">
                        <td>Sell</td>
                        <td><input type="text" name="items[${i}].sell.price" value="${l.sell.price}"  onchange="unitPriceChanged.apply(this);"></td>
                        <td>${l.quantity}</td>
                        <td><input type="text" name="items[${i}].sell.tax" value="${l.sell.tax}" onchange="numValueChanged.apply(this);"></td>
                        <td><input type="text" name="items[${i}].sell.discount" value="${l.sell.discount}" value="-0.0" onchange="numValueChanged.apply(this);"/></td>
                        <td><input type="text" name="items[${i}].sell.shipping" value="${l.sell.shipping}" onchange="numValueChanged.apply(this);"></td>
                        <td class="total_sell">0.0</td>
                    </tr>
                </table>
            </div>
            </g:each>
        </g:if>
        <g:else>
            <g:each var="l" in="${order.lines}" status="i">
            <div class="order_line">
                <table class="item_header">
                    <tr><td>Product</td><td>List Price</td><td>Quantity</td><td>Total</td><td>Profit</td><td>Model</td><td>Note</td><td></td></tr>
                    <tr>
                        <td>${l.product.name}</td>
                        <td>${l.product.listPrice}</td>
                        <td>${l.quantity}</td>
                        <td class="item_total">0.0</td>
                        <td class="item_profit">0.0</td>
                        <td>${l.model}</td>
                        <td>${l.note}</td>
                        <td></td>
                    </tr>
                </table>
                <table class="item_body">
                    <tr>
                        <td></td>
                        <td>Unit Price</td>
                        <td>Quantity</td>
                        <td>Tax</td>
                        <td>Discount</td>
                        <td>Shipping</td>
                        <td>Total</td>
                    </tr>
                    <tr class="item_purchase">
                        <td>Purchase</td>
                        <td>${l.purchase.price}</td>
                        <td>${l.quantity}</td>
                        <td>${l.purchase.tax}</td>
                        <td>${l.purchase.discount}</td>
                        <td>${l.purchase.shipping}</td>
                        <td class="total_purchase">0.0</td>
                    </tr>
                    <tr>
                        <td></td><td><input type="text" size="2"></td><td></td><td></td><td></td><td></td><td></td>
                    </tr>
                    <tr class="item_sell">
                        <td>Sell</td>
                        <td>${l.sell.price}</td>
                        <td>${l.quantity}</td>
                        <td>${l.sell.tax}</td>
                        <td>${l.sell.discount}</td>
                        <td>${l.sell.shipping}</td>
                        <td class="total_sell">0.0</td>
                    </tr>
                </table>
            </div>
            </g:each>
        </g:else>
        </div>
        <!--items end-->
    </form>
</g:if>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
<asset:javascript src="order.js" />

<script>

var products = ${products.encodeAsRaw()};

$( function() {
    $("#add_line_btn").click(function (e) {
        addOrderLine(products);
    });

    if (${order.status} == 1) {

        $(".item_purchase").each(function () {
            updateBodySection($(this));
        });
        $(".item_sell").each(function() {
            updateBodySection($(this));
        });
        $(".order_line").each(function() {
            updateItem($(this));
        });

        updateOrder();
    }

});

</script>
</body>
</html>
