<!DOCTYPE html><html><head><title>Top 5</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="container mt-4">
<h1>Top 5 Students</h1>
<table class="table">
    <thead><tr><th>Rank</th><th>Name</th><th>Average</th></tr></thead>
    <tbody>
    <c:forEach var="r" items="${rows}" varStatus="st">
        <tr>
            <td>${st.index + 1}</td>
            <td>${r.name} ${r.surname}</td>
            <td>${r.avg}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>
<a class="btn btn-secondary" href="${pageContext.request.contextPath}/students">Back</a>
</body></html>
