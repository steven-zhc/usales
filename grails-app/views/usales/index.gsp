<!doctype html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Welcome to USales</title>
</head>
<body>
    <h1>Welcome to USales</h1>

    <div id="content" role="main">
        <table>
            <tr>
                <th>Order</th>
                <th>Total</th>
                <th>Profit</th>
                <th>Payment</th>
            </tr>
            <tr>
                <td>${statistics.count}</td>
                <td>${statistics.total}</td>
                <td>${statistics.profit}</td>
                <td>${statistics.payment}</td>
            </tr>
        </table>
        
        <h2>Todo List</h2>
        <form action="/">
            <button type="submit" name="status" value="1">Inquiring</button>
            <button type="submit" name="status" value="2">Processing</button>
            <button type="submit" name="status" value="3">Shipping</button>
        </form>
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Product</th>
                    <th>Total</th>
                    <th>Profit</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody>
                <g:each var="o" in="${list}">
                    <tr>
                        <td><a href="/order/show/${o.id}">${o.id}</a></td>
                        <td>${message(code:'order.status.value.'+fieldValue(bean: o, field:"status"))}</td>
                        <td>${o.dateCreated.format('MM/dd/yyyy')}</td>
                        <td>
                            <g:each var="line" in="${o.lines}" status="j">
                                ${line.product.name}
                                <g:if test="${j != o.lines.size() - 1}">
                                    <br/>
                                </g:if>
                            </g:each>
                        </td>
                        <td>${o.total}</td>
                        <td>${o.profit}</td>
                        <td>${o.note}</td>
                    </tr>
                </g:each>
                
            </tbody>
        </table>
    </div>

</body>
</html>
