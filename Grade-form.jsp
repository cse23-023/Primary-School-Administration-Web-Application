<!DOCTYPE html><html><head><title>Add Grade</title>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"></head>
<body class="container mt-4">
<h1>Add Grade</h1>
<form method="post" action="${pageContext.request.contextPath}/grades/save">
    <div class="mb-3">
        <label>Student</label>
        <select class="form-select" name="studentId">
            <c:forEach var="s" items="${students}">
                <option value="${s.id}">${s.fullName} (${s.birthCertificateNo})</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3">
        <label>Class</label>
        <select class="form-select" name="classId">
            <c:forEach var="c" items="${classes}">
                <option value="${c.id}">${c.name}</option>
            </c:forEach>
        </select>
    </div>
    <div class="mb-3"><label>Subject Id (use subject admin to create)</label><input name="subjectId" class="form-control" required/></div>
    <div class="mb-3"><label>Term</label><input name="term" class="form-control" required/></div>
    <div class="mb-3"><label>Marks</label><input type="number" step="0.01" name="marks" class="form-control" required/></div>
    <button class="btn btn-primary">Save</button>
</form>
</body></html>
