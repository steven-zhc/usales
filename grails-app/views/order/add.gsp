<!doctype html>
<html lang="en">

<head>
    <title>Create Order</title>
    <link rel="stylesheet" href="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/themes/smoothness/jquery-ui.css">
</head>

<body>
    <h1>Create Order</h1>
    <g:form action="save">
        <div>
            <g:submitButton name="submit" value="Create Product" class="ui-button ui-corner-all ui-widget" />
        </div>
        <div>
            <label for="dateCreated">Date</label>
            <input id="dateCreated" type="date" value="${new Date().format('MM/dd/yyyy')}" />
        </div>
        <div>
            <label for="deliverFee">Deliver Fee</label>
            <input type="text" id="deliverFee" value="0.00"/>
        </div>
        <div>
            <label for="note">Note</label>
            <g:textArea name="note" />
        </div>

        <div>
            <button id="create_line_btn" type="button">+</button>
        </div>

        <table id="order_table">
            <thead>
                <tr>
                    <th>Product</th>
                    <th>Quantity</th>
                    <th>List Price</th>
                    <th>Discount Price</th>
                    <th>Sell Price</th>
                    <th>Tax</th>
                    <th>Shipping Fee</th>
                    <th>Total</th>
                    <th>Profit</th>
                </tr>
            </thead>
            <tbody>
            </tbody>
        </table>
        <div>
            <label for="total">Total Price</label>
            <input type="text" id="total" size="9" readonly />
        </div>
        <div>
            <label for="profit">Total Profit</label>
            <input type="text" id="profit" size="9" readonly />
        </div>
    </g:form>
    <div id="line-form" title="Add an Order Line">
        <form>
            <div>
                <label for="d_name">Product</label>
                <select id="d_name">
                    <option value="">Select one product ...</option>
                </select>
            </div>
            <div>
                <label for="d_quantity">Quantity</label>
                <input type="text" id="d_quantity" value="1" />
            </div>
            <div>
                <label for="d_list_price">List Price</label>
                <input type="text" id="d_list_price" readonly/>
            </div>
            <div>
                <label for="d_discount">Discount Price</label>
                <input type="text" id="d_discount">
            </div>
            <div>
                <input type="range" id="d_slider" min="0" max="100" value="0" />
                <input id="d_perc" type="text" value="0" size="2"/><span>%</span>
            </div>
            <div>
                <label for="d_sell_price">Sell Price</label>
                <input type="text" id="d_sell_price" />
            </div>
            <div>
                <label for="d_tax">Tax</label>
                <input type="text" id="d_tax" readonly/>
            </div>
            <div>
                <label for="d_shipping">Shipping Fee</label>
                <input type="text" id="d_shipping" value="0.00" />
            </div>
            <div>
                <label for="d_total">Total</label>
                <input type="text" id="d_total" readonly/>
            </div>
            <div>
                <label for="d_profit">Profit</label>
                <input type="text" id="d_profit" readonly/>
            </div>
        </form>
    </div>
    </div>
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
    <script src="https://ajax.googleapis.com/ajax/libs/jqueryui/1.12.1/jquery-ui.min.js"></script>
    <script>
                
    var products = ${products.encodeAsRaw()}
    
    $( function() {
        var dialog, lineForm,
        name = $("#d_name"),
        quantity = $("#d_quantity"),
        listPrice = $("#d_list_price"),
        discount = $("#d_discount"),
        slider = $("#d_slider"),
        perc = $("#d_perc"),
        sellPrice = $("#d_sell_price"),
        tax = $("#d_tax"),
        shipping = $("#d_shipping"),
        total = $("#d_total"),
        profit = $("#d_profit"),
        allFields = $([]).add(name).add(quantity).add(listPrice)
            .add(discount).add(sellPrice)
            .add(tax).add(shipping).add(total).add(profit);

        $.each(products.list, function(i, p){
            name.append($('<option>').text(p.name).attr('value', p.id));
        });

        function calculateTax(n) {
            return n * 0.0875;
        }

        function calculatePrice(quantity, price, shipping) {
            return quantity * (price + calculateTax(price)) + shipping;
        }

        function getSellTotalVal() {
            var p = calculatePrice(
                parseInt(quantity.val()), 
                parseFloat(sellPrice.val()), 
                parseFloat(shipping.val())
            );

            return p.toFixed(2);
        }

        function getRealTotalVal() {
            var p = calculatePrice(
                parseInt(quantity.val()),
                parseFloat(discount.val()),
                parseFloat(shipping.val())
            );

            return p.toFixed(2);
        }

        function refreshTotalUI() {
            var t1 = getSellTotalVal();
            var t2 = getRealTotalVal();

            total.val(t1);
            profit.val((t1 - t2).toFixed(2));
        }

        name.change(function() {
            var pid = name.find(":selected").val();
            $.each(products.list, function(i, p){
                if (p.id == pid) {
                    listPrice.val(p.price);
                    discount.val(p.price);
                    sellPrice.val(p.price);
                    tax.val(calculateTax(p.price).toFixed(2));
                    
                    refreshTotalUI();

                    return;
                }
            });
        });

        quantity.change(function() {
            refreshTotalUI();
        });

        discount.change(function() {
            refreshPercentageUI(perc.val());
        });
        
        function refreshPercentageUI(pv) {
            slider.val(pv);
            perc.val(pv);
            var p = discount.val() * (1 + pv / 100);
            sellPrice.val(p.toFixed(2));

            tax.val(calculateTax(p).toFixed(2));

            refreshTotalUI();
        }

        slider.change(function() {
            refreshPercentageUI(slider.val());
        });
        perc.change(function() {
            refreshPercentageUI(perc.val());
        });
        
        sellPrice.change(function() {
            var n = 100 - discount.val() / sellPrice.val() * 100;
            slider.val(n.toFixed(0));
            perc.val(n.toFixed(0));
            tax.val(calculateTax(sellPrice.val()).toFixed(2));

            refreshTotalUI();
        });

        shipping.change(refreshTotalUI);
        
        function addLine() {
            var row = $("#order_table tbody tr").length;

            $("#order_table tbody").append(
                "<tr><td>" + 
                "<span>" + name.find(":selected").text() + "</span>" + 
                "<input              id='lines[" + row + "].pid' type='hidden' value='" + name.find(":selected").val() + "'/>" +
                "</td>" +
                "<td><input size='8' id='lines[" + row + "].quantity' type='number' value='" + quantity.val()  + "' /></td>" +
                "<td><span>" + listPrice.val() + "</span></td>" +
                "<td><input size='8' id='lines[" + row + "].discountPrice' type='text' value='" + discount.val()  + "' /></td>" +
                "<td><input size='8' id='lines[" + row + "].sellPrice' type='text' value='" + sellPrice.val() + "' /></td>" +
                "<td><input size='8' id='lines[" + row + "].tax' type='text' value='" + tax.val()       + "' /></td>" +
                "<td><input size='8' id='lines[" + row + "].shippingFee' type='text' value='" + shipping.val()  + "' /></td>" +
                "<td><input size='8' id='lines[" + row + "].lineTotal' type='text' value='" + total.val()     + "' /></td>" +
                "<td><input size='8' id='lines[" + row + "].lineProfit' type='text' value='" + profit.val()    + "' /></td>" +
                "</tr>"
            );
            dialog.dialog("close");

            updateOrderUI();
        }

        dialog = $("#line-form").dialog({
            autoOpen: false,
            height: 470,
            width: 450,
            modal: true,
            buttons: {
                "Add a Line": addLine,
                Cancel: function() {
                    dialog.dialog("close");
                }
            },
            close: function() {
                
            }
        });

        lineForm = $("#line-form").children("form").on("submit", function(event) {
            addLine();
        });

        $("#create_line_btn").button().on("click", function() {
            dialog.dialog("open");
        });

        function updateOrderUI() {
            var sum = 0.0;
            $("#order_table tbody tr").each(function(){
                var v = parseFloat($(this).find("td:nth-last-child(2) input").val());
                sum += v;
            });

            $("#total").val(sum);

            sum = 0.0
            $("#order_table tbody tr").each(function(){
                sum += parseFloat($(this).find("td:last input").val());
            });

            $("#profit").val(sum);

        }

        
    });


</script>
</body>

</html>