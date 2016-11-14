<!doctype html>
<html lang="en">
<head>
    <title>Create Product</title>
</head>
<body>
<section>
    <h1>Show Product</h1>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>

    <g:if test="${product}">
        <div>
            <div>
                <span>Product Name</span>
                <div>${product.name}</div>
            </div>

            <div>
                <span>Category</span>
                <div>${product.category.name}</div>
            </div>

            <div>
                <span>List Price</span>
                <div>${product.listPrice}</div>
            </div>

            <div>
                <span>Description</span>
                <div>${product.description}</div>
            </div>
        </div>
    </g:if>

    <div>
        <a href="/product/add">New Product</a>
    </div>
</section>
</body>
</html>