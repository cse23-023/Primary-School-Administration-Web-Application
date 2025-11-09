<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="container mt-5">

<h1 class="mb-4">Dashboard</h1>

<c:choose>

    <c:when test="${role == 'ADMIN'}">
        <div class="alert alert-primary">Welcome Admin</div>
        <a href="${pageContext.request.contextPath}/students" class="btn btn-primary mb-2">Manage Students</a>
        <a href="${pageContext.request.contextPath}/classes" class="btn btn-primary mb-2">Manage Classes</a>
        <a href="${pageContext.request.contextPath}/grades" class="btn btn-primary mb-2">Manage Grades</a>
    </c:when>

    <c:when test="${role == 'TEACHER'}">
        <div class="alert alert-success">Welcome Teacher</div>
        <a href="${pageContext.request.contextPath}/grades" class="btn btn-primary mb-2">Add Grades</a>
        <a href="${pageContext.request.contextPath}/students" class="btn btn-primary mb-2">View Students</a>
    </c:when>

    <c:otherwise>
        <div class="alert alert-info">Welcome Parent</div>
        <a href="${pageContext.request.contextPath}/students" class="btn btn-primary mb-2">View Students</a>
    </c:otherwise>

</c:choose>

<a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-danger mt-4">Logout</a>

</body>
</html>


