<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Order List</title>
</head>
<body>
    <div>
        <form action="/order/search">
            <span>Product Name</span>
            <input type="text" name="prodName" value="${cmd?.prodName}"/>
            <button type="submit">Search</button>
        </form>
    </div>
    <div>
        <button type="button" onclick="location.href='/order/add'">Creat Order</button>
    </div>
    <div>
        <table>
            <thead>
                <tr>
                    <td>ID</td>
                    <td>Status</td>
                    <td>Date</td>
                    <td>Product</td>
                    <td>Total</td>
                    <td>Profit</td>
                    <td>Note</td>
                </tr>
            </thead>
            <tbody>
                <g:each var="o" in="${orders}" status="i">
                <tr>
                    <td><a href="/order/show/${o.id}">${o.id}</a></td>
                    <td>${message(code: 'order.status.value.' + fieldValue(bean: o, field: "status"))}</td>
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