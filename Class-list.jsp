<!DOCTYPE html><html><head><title>Classes</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="container mt-4">
<h1>Classes</h1>
<a class="btn btn-success" href="${pageContext.request.contextPath}/classes/add">Add Class</a>
<table class="table mt-3">
    <thead><tr><th>ID</th><th>Name</th><th>Description</th><th>Actions</th></tr></thead>
    <tbody>
    <c:forEach var="c" items="${classes}">
        <tr>
            <td>${c.id}</td>
            <td>${c.name}</td>
            <td>${c.description}</td>
            <td>
                <a class="btn btn-sm btn-warning" href="${pageContext.request.contextPath}/classes/edit?id=${c.id}">Edit</a>
                <a class="btn btn-sm btn-danger" href="${pageContext.request.contextPath}/classes/delete?id=${c.id}" onclick="return confirm('Delete?')">Delete</a>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body></html>
