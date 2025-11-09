<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Management System</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 2rem 0;
            margin-bottom: 2rem;
            border-radius: 0 0 20px 20px;
        }
        .action-buttons .btn {
            margin: 0 2px;
        }
        .table-hover tbody tr:hover {
            background-color: rgba(102, 126, 234, 0.1);
        }
        .badge {
            font-size: 0.75em;
        }
        .guardian-info {
            font-size: 0.85em;
            color: #6c757d;
        }
        .status-badge {
            font-size: 0.7em;
        }
        .class-badge {
            background-color: #17a2b8;
            color: white;
        }
        .student-name {
            font-weight: 600;
            color: #495057;
        }
    </style>
</head>
<body>
<div class="header-container">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="display-4 fw-bold">📚 Student Management System</h1>
                <p class="lead mb-0">Manage your student records efficiently</p>
            </div>
            <div>
                <span class="me-3">Welcome, ${user.name}!</span>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-light btn-sm">
                    🚪 Logout
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <!-- Success/Error Messages -->
    <c:if test="${not empty message}">
        <div class="alert alert-success alert-dismissible fade show" role="alert">
            ✅ ${message}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="message" scope="session"/>
    </c:if>

    <c:if test="${not empty error}">
        <div class="alert alert-danger alert-dismissible fade show" role="alert">
            ❌ ${error}
            <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
        </div>
        <c:remove var="error" scope="session"/>
    </c:if>

    <div class="d-flex justify-content-between align-items-center mb-4">
        <h2 class="text-primary">👥 Student List</h2>
        <a class="btn btn-success btn-lg" href="${pageContext.request.contextPath}/students/add">
            ➕ Add New Student
        </a>
    </div>

    <!-- Statistics Cards -->
    <div class="row mb-4">
        <div class="col-md-3">
            <div class="card text-white bg-primary">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="card-title">${not empty students ? students.size() : 0}</h4>
                            <p class="card-text">Total Students</p>
                        </div>
                        <div class="align-self-center">
                            <span style="font-size: 2rem;">👥</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-success">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="card-title">
                                <c:set var="activeCount" value="0" />
                                <c:forEach var="student" items="${students}">
                                    <c:if test="${student.status == 'Active'}">
                                        <c:set var="activeCount" value="${activeCount + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${activeCount}
                            </h4>
                            <p class="card-text">Active Students</p>
                        </div>
                        <div class="align-self-center">
                            <span style="font-size: 2rem;">✅</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-warning">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="card-title">
                                <c:set var="newStudents" value="0" />
                                <c:forEach var="student" items="${students}">
                                    <c:if test="${empty student.status || student.status == 'New Student'}">
                                        <c:set var="newStudents" value="${newStudents + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${newStudents}
                            </h4>
                            <p class="card-text">New Students</p>
                        </div>
                        <div class="align-self-center">
                            <span style="font-size: 2rem;">🆕</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <div class="col-md-3">
            <div class="card text-white bg-info">
                <div class="card-body">
                    <div class="d-flex justify-content-between">
                        <div>
                            <h4 class="card-title">
                                <c:set var="withGuardian" value="0" />
                                <c:forEach var="student" items="${students}">
                                    <c:if test="${not empty student.guardianName}">
                                        <c:set var="withGuardian" value="${withGuardian + 1}" />
                                    </c:if>
                                </c:forEach>
                                ${withGuardian}
                            </h4>
                            <p class="card-text">With Guardian Info</p>
                        </div>
                        <div class="align-self-center">
                            <span style="font-size: 2rem;">👨‍👩‍👧‍👦</span>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card shadow-sm">
        <div class="card-body">
            <c:if test="${not empty students}">
                <div class="table-responsive">
                    <table class="table table-hover table-striped">
                        <thead class="table-dark">
                        <tr>
                            <th>#</th>
                            <th>Student Information</th>
                            <th>Birth Certificate No</th>
                            <th>Gender</th>
                            <th>Date of Birth</th>
                            <th>Guardian Information</th>
                            <th>Class & Status</th>
                            <th>Actions</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="student" items="${students}" varStatus="status">
                            <tr>
                                <td><strong>${status.index + 1}</strong></td>
                                <td>
                                    <div class="student-name">${student.name} ${student.surname}</div>
                                    <c:if test="${not empty student.address}">
                                        <small class="text-muted">🏠 ${student.address}</small>
                                    </c:if>
                                    <c:if test="${empty student.address}">
                                        <small class="text-warning">⚠️ No address provided</small>
                                    </c:if>
                                </td>
                                <td>
                                    <span class="badge bg-secondary">${student.birthCertificateNo}</span>
                                </td>
                                <td>
                                    <c:choose>
                                        <c:when test="${student.gender == 'Male'}">
                                            <span class="badge bg-primary">👨 Male</span>
                                        </c:when>
                                        <c:when test="${student.gender == 'Female'}">
                                            <span class="badge bg-danger">👩 Female</span>
                                        </c:when>
                                        <c:when test="${student.gender == 'Other'}">
                                            <span class="badge bg-info">⚧ Other</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">Not specified</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td>
                                    <c:if test="${not empty student.dob}">
                                        <div>${student.dob}</div>
                                        <c:set var="now" value="<%= java.time.LocalDate.now() %>" />
                                        <c:set var="age" value="${now.year - student.dob.year}" />
                                        <c:if test="${now.monthValue < student.dob.monthValue || (now.monthValue == student.dob.monthValue && now.dayOfMonth < student.dob.dayOfMonth)}">
                                            <c:set var="age" value="${age - 1}" />
                                        </c:if>
                                        <small class="text-muted">(${age} years)</small>
                                    </c:if>
                                    <c:if test="${empty student.dob}">
                                        <span class="text-warning">⚠️ Not specified</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty student.guardianName}">
                                        <strong>${student.guardianName}</strong>
                                        <c:if test="${not empty student.guardianContact}">
                                            <br><small class="guardian-info">📞 ${student.guardianContact}</small>
                                        </c:if>
                                        <c:if test="${not empty student.guardianEmail}">
                                            <br><small class="guardian-info">📧 ${student.guardianEmail}</small>
                                        </c:if>
                                    </c:if>
                                    <c:if test="${empty student.guardianName}">
                                        <span class="text-warning">⚠️ No guardian info</span>
                                    </c:if>
                                </td>
                                <td>
                                    <c:if test="${not empty student.currentClass}">
                                        <span class="badge class-badge">${student.currentClass}</span>
                                        <br>
                                    </c:if>
                                    <c:choose>
                                        <c:when test="${student.status == 'Active'}">
                                            <span class="badge bg-success status-badge">Active</span>
                                        </c:when>
                                        <c:when test="${student.status == 'Inactive'}">
                                            <span class="badge bg-secondary status-badge">Inactive</span>
                                        </c:when>
                                        <c:when test="${student.status == 'Transferred'}">
                                            <span class="badge bg-info status-badge">Transferred</span>
                                        </c:when>
                                        <c:when test="${student.status == 'Graduated'}">
                                            <span class="badge bg-warning status-badge">Graduated</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-primary status-badge">${student.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                                <td class="action-buttons">
                                    <div class="btn-group-vertical btn-group-sm">
                                        <a class="btn btn-info btn-sm mb-1"
                                           href="${pageContext.request.contextPath}/students/details?id=${student.id}"
                                           title="View Details">
                                            👁️ Details
                                        </a>
                                        <a class="btn btn-warning btn-sm mb-1"
                                           href="${pageContext.request.contextPath}/students/edit?id=${student.id}"
                                           title="Edit Student">
                                            ✏️ Edit
                                        </a>
                                        <a class="btn btn-danger btn-sm"
                                           href="${pageContext.request.contextPath}/students/delete?id=${student.id}"
                                           onclick="return confirm('Are you sure you want to delete ${student.name} ${student.surname}? This action cannot be undone.')"
                                           title="Delete Student">
                                            🗑️ Delete
                                        </a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${empty students}">
                <div class="text-center py-5">
                    <div class="text-muted">
                        <h3>📝 No Students Found</h3>
                        <p>Get started by adding your first student record.</p>
                        <a class="btn btn-primary btn-lg mt-3"
                           href="${pageContext.request.contextPath}/students/add">
                            ➕ Add Your First Student
                        </a>
                    </div>
                </div>
            </c:if>
        </div>
    </div>

    <!-- Summary Information -->
    <div class="mt-4">
        <div class="row">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title">📊 Quick Summary</h6>
                        <ul class="list-unstyled">
                            <li>Total Students: <strong>${not empty students ? students.size() : 0}</strong></li>
                            <li>With Guardian Info: <strong>${withGuardian}</strong></li>
                            <li>Active Students: <strong>${activeCount}</strong></li>
                            <li>New Students: <strong>${newStudents}</strong></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-body">
                        <h6 class="card-title">⚡ Quick Actions</h6>
                        <div class="d-grid gap-2">
                            <a class="btn btn-outline-primary btn-sm"
                               href="${pageContext.request.contextPath}/students/add">
                                ➕ Add New Student
                            </a>
                            <button class="btn btn-outline-secondary btn-sm" onclick="window.print()">
                                🖨️ Print List
                            </button>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Auto-dismiss alerts after 5 seconds
    setTimeout(function() {
        const alerts = document.querySelectorAll('.alert');
        alerts.forEach(alert => {
            const bsAlert = new bootstrap.Alert(alert);
            bsAlert.close();
        });
    }, 5000);

    // Enhanced confirmation for delete
    document.addEventListener('DOMContentLoaded', function() {
        const deleteLinks = document.querySelectorAll('a[href*="/students/delete"]');
        deleteLinks.forEach(link => {
            link.addEventListener('click', function(e) {
                const studentName = this.closest('tr').querySelector('.student-name').textContent;
                const confirmed = confirm(`Are you sure you want to delete ${studentName}? This action cannot be undone.`);
                if (!confirmed) {
                    e.preventDefault();
                }
            });
        });
    });
</script>
</body>
</html>