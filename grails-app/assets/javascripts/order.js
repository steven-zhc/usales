// Order Line Body functions
// ------------------------------------------------------------------------
function calculateRate(p1, p2) {
    return 100 * (1 - p1 / p2);
}
function calculateTax(n) {
    return n * 0.0875;
}
function calculatePrice(quantity, price, tax, shipping, discount) {
    return quantity * price + tax + shipping + discount;
}

// Calculate details price changed
function updateBodySection(tr) {

    var unitePrice = parseFloat(tr.find("td:nth-child(2) input").val());
    var quantity   = parseInt(tr.children("td:nth-child(3)").text());
    var tax        = parseFloat(tr.find("td:nth-child(4) input").val());
    var discount   = parseFloat(tr.find("td:nth-child(5) input").val());
    var shipping   = parseFloat(tr.find("td:nth-child(6) input").val());
    
    var total = calculatePrice(quantity, unitePrice, tax, shipping, discount);

    tr.children("td:last-child").text(total.toFixed(2));

    updateItem(tr.parentsUntil("div.order_line").parent());
}

function unitPriceChanged() {
    var price = parseFloat($(this).val());

    var quantityTag = $(this).parent().next();
    var quantity = parseInt(quantityTag.text());

    var tax = calculateTax(price * quantity).toFixed(2);
    quantityTag.next().children("input").val(tax);
    
    updateBodySection($(this).parentsUntil("tbody"));
}

function numValueChanged() {
    updateBodySection($(this).parentsUntil("tbody"));
}

// Order Line Header functions
// ------------------------------------------------------------------------

function quantityChanged() {
    var q = $(this).val();

    var bodyTable = $(this).parentsUntil("div.order_line").next();

    var purchaseTr = bodyTable.find("tr.item_purchase");
    var sellTr     = bodyTable.find("tr.item_sell");

    purchaseTr.find("td:nth-child(3)").text(q);
    sellTr.find("td:nth-child(3)").text(q);

    // quantity changed, need to recalculate tax.
    unitPriceChanged.apply(purchaseTr.find("td:nth-child(2) input"));
    unitPriceChanged.apply(sellTr.find("td:nth-child(2) input"));
}

// Update item header
function updateItem(line) {
    var headerTable = line.children(".item_header");
    var totalTag    = headerTable.find(".item_total");
    var profitTag   = headerTable.find(".item_profit");

    var bodyTable        = line.children(".item_body");
    var purchaseTotalTag = bodyTable.find(".total_purchase");
    var sellTotalTag     = bodyTable.find(".total_sell");
    
    var purchaseTotal = parseFloat(purchaseTotalTag.text());
    var sellTotal     = parseFloat(sellTotalTag.text());
    var profit        = sellTotal - purchaseTotal;

    totalTag.text(sellTotal.toFixed(2));
    profitTag.text(profit.toFixed(2));

    updateOrder();
}

function productChanged() {
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

        var td = $(this).parent();
        td.next().text(product.price);

        var headerTable = $(this).parentsUntil("div.order_line");
        var bodyTable = headerTable.next();

        var p1 = bodyTable.find("tr.item_purchase td:nth-child(2) input");
        p1.val(product.price);
        unitPriceChanged.apply(p1);

        var p2 = bodyTable.find("tr.item_sell td:nth-child(2) input");
        p2.val(product.price);
        unitPriceChanged.apply(p2);

        bodyTable.show();
    }
}

// function updateRate() {
//     var v = parseFloat($(this).val());
//     var rate = 1.0 +  v / 100;
//     var discount = parseFloat($(this).parent().prev().children("input").val());
//     var sellPriceTag = $(this).parent().next().children("input");

//     sellPriceTag.val((discount * rate).toFixed(2));

//     settleAccount($(this).parent().parent());
// }

// Order functions
// ------------------------------------------------------------------------
// recalculate account balance
function updateOrder() {
    var sum = 0.0;
    $(".item_total").each(function(){
        sum += parseFloat($(this).text());
    });
    sum = sum.toFixed(2);
    $("#order_total").text(sum);
    $("#total").val(sum);

    sum = 0.0
    $(".item_profit").each(function(){
        sum += parseFloat($(this).text());
    });
    sum = sum.toFixed(2);
    $("#order_profit").text(sum);
    $("#profit").val(sum);
}

function deleteLine() {
    $(this).parentsUntil("div").parent().remove();

    updateOrderAccount();
}

function addOrderLine(prods) {
    var count = $(".order_line").length;
    var optionlist = "";
    $.each(prods.list, function(i, p) {
        optionlist += $('<option>').text(p.name).attr('value', p.id).prop('outerHTML');
    });

    var str = '<div class="order_line">' + 
        '<table class="item_header">' + 
        '<tr><td>Product</td><td>List Price</td><td>Quantity</td><td>Total</td><td>Profit</td><td>Note</td><td></td></tr>' + 
        '<tr>' + 
        '<td><select name="newItems[0].name" onchange="productChanged.apply(this);">' + 
        '<option value="">Select one product ...</option>'  + optionlist +
        '</select><input type="hidden" name="newItems[' + count + '].pid" value="0"/></td>' + 
        '<td>0.0</td>' + 
        '<td><input type="number" name="newItems[' + count + '].quantity" value="1" min="1" max="1000" onchange="quantityChanged.apply(this);" /> </td>' + 
        '<td class="item_total">0.0</td>' + 
        '<td class="item_profit">0.0</td>' + 
        '<td><input type="text" name="newItems[' + count + '].note" /></td>' + 
        '<td><button type="button" onclick="deleteLine.apply(this)">Remove</button></td>' + 
        '</tr></table>' + 
        '<table class="item_body">' + 
        '<tr><td></td><td>Unit Price</td><td>Quantity</td><td>Tax</td><td>Discount</td><td>Shipping</td><td>Total</td></tr>' + 
        '<tr class="item_purchase">' + 
        '<td>Purchase</td>' + 
        '<td><input type="text" name="newItems[' + count + '].purchase.price" value="0.0" onchange="unitPriceChanged.apply(this);"/></td>' + 
        '<td>1</td>' + 
        '<td><input type="text" name="newItems[' + count + '].purchase.tax" value="0.0" onchange="numValueChanged.apply(this);"/></td>' + 
        '<td><input type="text" name="newItems[' + count + '].purchase.discount" value="-0.0" onchange="numValueChanged.apply(this);"/></td>' + 
        '<td><input type="text" name="newItems[' + count + '[.purchase.shipping" value="0.0" onchange="numValueChanged.apply(this);"/></td>' + 
        '<td class="total_purchase">0.0</td>' + 
        '</tr><tr><td></td><td><input type="text" size="2"></td><td></td><td></td><td></td><td></td><td></td></tr>' + 
        '<tr class="item_sell">' + 
        '<td>Sell</td>' + 
        '<td><input type="text" name="newItems[' + count + '].sell.price" value="0.0" onchange="unitPriceChanged.apply(this);"></td>' + 
        '<td>1</td>' + 
        '<td><input type="text" name="newItems[' + count + '].sell.tax" value="0.0" onchange="numValueChanged.apply(this);"></td>' + 
        '<td><input type="text" name="newItems[' + count + '].sell.discount" value="-0.0" onchange="numValueChanged.apply(this);"/></td>' + 
        '<td><input type="text" name="newItems[' + count + '].sell.shipping" value="0.0" onchange="numValueChanged.apply(this);"></td>' + 
        '<td class="total_sell">0.0</td>' + 
        '</tr></table></div>';
    var line = $(str);
    line.find(".item_body").hide();

    $("#items").prepend(line);
}

