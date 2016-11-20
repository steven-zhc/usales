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
    taxTag.children("span").text(tax.toFixed(2));
    taxTag.children("input").val(tax.toFixed(2));

    var shippingTag = taxTag.next();
    var shipping = parseFloat(shippingTag.children("input").val());

    var totalTag = shippingTag.next();
    var total = calculatePrice(quantity, sellPrice, shipping);
    totalTag.children("span").text(total.toFixed(2));
    totalTag.children("input").val(total.toFixed(2));

    var profitTag = totalTag.next();
    var profit = total - calculatePrice(quantity, discount, shipping);
    profitTag.children("span").text(profit.toFixed(2));
    profitTag.children("input").val(profit.toFixed(2));

    updateOrderAccount();
}

function updateOrderAccount() {
    var sum = 0.0;
    $("#line_table tbody tr").each(function(){
        var v = parseFloat($(this).find("td:nth-last-child(4) span").text());
        sum += v;
    });
    sum = sum.toFixed(2);
    $("#order_total_price").text(sum);
    $("#total").val(sum);

    sum = 0.0
    $("#line_table tbody tr").each(function(){
        sum += parseFloat($(this).find("td:nth-last-child(3) span").text());
    });
    sum = sum.toFixed(2);
    $("#order_profit_price").text(sum);
    $("#profit").val(sum);
}

function updateDeliverFee() {
    var fee = parseFloat($("#deliverFee").val());
    var total = parseFloat($("#total").val());
    var sum = (total + fee).toFixed(2);

    $("#order_total_price").text(sum);
    $("#total").val(sum);
}

function deleteLine() {
    var tr = $(this).parent().parent();
    tr.remove();

    updateOrderAccount();
}

function addOrderLine(products) {
    var count = $("#line_table tbody").find("tr#new_items").length;
    var optionlist = "";
    $.each(products.list, function(i, p) {
        optionlist += $('<option>').text(p.name).attr('value', p.id).prop('outerHTML');
    });
    
    var str = '<tr class="new_items">' +
        '<td>' +
        '<select name="newItems[' + count + '].name" onchange="updateProduct.apply(this);">' +
            '<option value="">Select one product ...</option>' + optionlist +
        '</select>' + 
        '<input type="hidden" name="newItems[' + count + '].pid" value="0"/>' +
        '</td>' + 
        '<td><input type="number" name="newItems[' + count + '].quantity" value="1" min="1" max="1000" onchange="updateNumber.apply(this);"/></td>' +
        '<td><span></span></td>' +  
        '<td><input type="text" name="newItems[' + count + '].discountPrice" class="discount_tag" disabled onchange="updateDiscountPrice.apply(this);"/></td>' +
        '<td><input type="text" value="0" onchange="updateRate.apply(this);" size="2"/>%</td>' + 
        '<td><input type="text" name="newItems[' + count + '].sellPrice" class="sell_tag" disabled onchange="updateSellPrice.apply(this);"/></td>' +  
        '<td><span></span><input type="hidden" name="newItems[' + count + '].tax" value=""/></td>' +  
        '<td><input type="text" name="newItems[' + count + '].shippingFee" class="shipping_tag" value="0.0" onchange="udpateShipping.apply(this);"/></td>' +  
        '<td><span></span><input type="hidden" name="newItems[' + count + '].lineTotal" value=""/></td>' +  
        '<td><span></span><input type="hidden" name="newItems[' + count + '].lineProfit" value=""/></td>' +  
        '<td>' +
        '<input type="text"   name="newItems[' + count + '].note" />' +
        '<input type="hidden" name="newItems[' + count + '].id" value="0"/></td>' +
        '<td><button type="button" onclick="deleteLine.apply(this)">Remove</button></td>' +
        '</tr>';
    $("#line_table tbody").prepend(str);
}

