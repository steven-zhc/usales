<!doctype html>
<html lang="en">
<head>
    <title>Show Category</title>
</head>
<body>
<section>
    <h1>Show Category</h1>

    <g:if test="${message}">
        <div class="message" role="status">${message}</div>
    </g:if>

    <g:if test="${category}">
        <div>
            <div>
                <span>Category Name</span>
                <div>${category.name}</div>
            </div>

            <div>
                <span>Parent Category</span>
                <div><a href="/category/show/${category.parent?.id}">${category.parent?.name}</a></div>
            </div>
        </div>
    </g:if>

    <div>
        <a href="/category/add">New Category</a>
    </div>
</section>
</body>
</html>