<!DOCTYPE html><html><head><title>Class</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="container mt-4">
<h2><c:if test="${classroom != null}">Edit Class</c:if><c:if test="${classroom == null}">Add Class</c:if></h2>
<form method="post" action="${pageContext.request.contextPath}/classes/save">
    <input type="hidden" name="id" value="${classroom.id}" />
    <div class="mb-3">
        <label>Name</label>
        <input class="form-control" name="name" value="${classroom.name}" required/>
    </div>
    <div class="mb-3">
        <label>Description</label>
        <textarea class="form-control" name="description">${classroom.description}</textarea>
    </div>
    <button class="btn btn-primary">Save</button>
    <a class="btn btn-secondary" href="${pageContext.request.contextPath}/classes">Cancel</a>
</form>
</body></html>
