<!doctype html>
<html lang="en">
<head>
    <meta name="layout" content="main" />
    <title>Create Product</title>
</head>
<body>
<section>
    <h1>Show Product</h1>

    <g:if test="${flash.message}">
        <div class="message" role="status">${flash.message}</div>
    </g:if>
    <form action="/product/update">
        <g:if test="${product}">
            <div>
                <div>
                    <label>Product Name</label>
                    <input type="text" name="name" value="${product.name}">
                    <input type="hidden" name="pid" value="${product.id}">
                </div>

                <div>
                    <label>Category</label>
                    <g:select name="cid" optionKey="id" optionValue="name" from="${categories}"
                        value="${product.category.id}"
                        noSelection="${['':'Select One...']}"/>
                </div>

                <div>
                    <label>List Price</label>
                    <input type="text" name="listPrice" value="${product.listPrice}">
                </div>

                <div>
                    <label>Product URL</label>
                    <input type="text" name="url" value="${product.url}">
                </div>

                <div>
                    <label>Description</label>
                    <textArea name="description">${product.description}</textArea>
                </div>
            </div>
        </g:if>

        <div>
            <button type="submit">Save</button>
            <button type="button" onclick="window.location='/product/add'">New Product</button>
        </div>
    </form>
</section>
<script>

</script>
</body>
</html>