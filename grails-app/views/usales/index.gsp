<!doctype html>
<html>
<head>
    <meta name="layout" content="main" />
    <title>Welcome to USales</title>

    <asset:stylesheet src="index.css"/>
</head>
<body>
    <h1>Welcome to USales</h1>

    <div id="content" role="main">
        <div id="cards">
            <div class="card">
                <div class="card_header"><h1>${statistics.count}</h1></div>
                <div class="card_container"><p>Order</p></div>
            </div>
            <div class="card">
                <div class="card_header"><h1>${statistics.total}</h1></div>
                <div class="card_container"><p>Total</p></div>
            </div>
            <div class="card">
                <div class="card_header"><h1>$${statistics.profit}</h1></div>
                <div class="card_container"><p>Profit</p></div>
            </div>
            <div class="card">
                <div class="card_header"><h1>$${statistics.payment}</h1></div>
                <div class="card_container"><p>Payment</p></div>
            </div>
        </div>
        <div class="clear_div"></div>

        
        <div id="todo_list">
            <h2>Todo List</h2>
            <form action="/">
                <button type="submit" name="status" value="1">Inquiring</button>
                <button type="submit" name="status" value="2">Processing</button>
                <button type="submit" name="status" value="3">Shipping</button>
            </form>
            <g:if test="${list}">
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
                                    <g:each var="l" in="${o.lines}" status="j">
                                        <g:if test="${l.product.url}">
                                            <a href="${l.product.url}">${l.product.name}</a>
                                        </g:if>
                                        <g:else>
                                            ${l.product.name}
                                        </g:else>
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
            </g:if>
        </div>
    </div>

</body>
</html>
