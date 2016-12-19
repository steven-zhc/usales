<!doctype html>
<html lang="en" class="no-js">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta http-equiv="X-UA-Compatible" content="IE=edge"/>
    <title>
        <g:layoutTitle default="U-Sales"/>
    </title>
    <meta name="viewport" content="width=device-width, initial-scale=1"/>

    <asset:stylesheet src="application.css"/>

    <g:layoutHead/>
</head>
<body>
    
    <nav class="navbar navbar-default">
        <div>
            <ul class="nav navbar-nav">
                <li><a href="/">Home</a></li>
                <li><a href="/category">Category</a></li>
                <li><a href="/product">Product</a></li>
                <li><a href="/order">Order</a></li>
            </ul>
        </div>
        <ul class="nav navbar-nav navbar-right">
            <li><a href="#">USD -> CNY <span id="currency_exchange">N/A</span></a></li>
        </ul>
    </nav>

    <g:layoutBody/>

    <footer class="footer">
        <div class="container">
            
        </div>
    </footer>

    <asset:javascript src="application.js"/>

<script>
var url = "http://api.fixer.io/latest?base=USD&symbols=CNY";

$( function() {
    $.getJSON(url, function(result) {
        $("#currency_exchange").text(result.rates.CNY);
    });
});

</script>
</body>
</html>
