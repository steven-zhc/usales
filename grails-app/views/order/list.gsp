<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="layout" content="main" />
    <title>Order List</title>
</head>
<body>
    <h1>Order List</h1>
    <div>
        <form action="/order/list">
            <span>Product Name</span>
            <input type="text" name="prodName" value="${cmd?.prodName}"/>
            <select name="status">
                <option value="">Select one status ...</option>
                <option value="1" ${cmd?.status == 1 ? "selected" : ''}>${message(code:'order.status.value.1')}</option>
                <option value="2" ${cmd?.status == 2 ? "selected" : ''}>${message(code:'order.status.value.2')}</option>
                <option value="3" ${cmd?.status == 3 ? "selected" : ''}>${message(code:'order.status.value.3')}</option>
                <option value="4" ${cmd?.status == 4 ? "selected" : ''}>${message(code:'order.status.value.4')}</option>
                <option value="0" ${cmd?.status == 0 ? "selected" : ''}>${message(code:'order.status.value.0')}</option>
            </select>
            <button type="submit">Search</button>
        </form>
    </div>
    <div>
        <button type="button" onclick="location.href='/order/add'">Creat Order</button>
    </div>
    <div>
        <g:if test="${orders}">
        <table>
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Status</th>
                    <th>Date</th>
                    <th>Product</th>
                    <th>Total</th>
                    <th>Profit</th>
                    <th>Payment</th>
                    <th>Note</th>
                </tr>
            </thead>
            <tbody>
                <g:each var="o" in="${orders}" status="i">
                <tr>
                    <td><a href="/order/show/${o.id}">${o.id}</a></td>
                    <td>${message(code: 'order.status.value.' + fieldValue(bean: o, field: "status"))}</td>
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
                    <td>${o.payment}</td>
                    <td>${o.note}</td>
                </tr>
                </g:each>
            </tbody>
        </table>
        </g:if>
    </div>
</body>
</html>