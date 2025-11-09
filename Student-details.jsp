<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>Student Details - ${student.name} ${student.surname}</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 0;
            margin-bottom: 2rem;
        }
        .detail-card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
            border-radius: 15px;
        }
        .section-title {
            color: #495057;
            border-bottom: 2px solid #667eea;
            padding-bottom: 0.5rem;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        .info-label {
            font-weight: 600;
            color: #495057;
        }
        .info-value {
            color: #6c757d;
        }
        .badge-custom {
            font-size: 0.8em;
            padding: 0.4em 0.8em;
        }
        .action-buttons .btn {
            margin: 0 5px;
        }
        .profile-header {
            background: linear-gradient(135deg, #f093fb 0%, #f5576c 100%);
            color: white;
            border-radius: 15px 15px 0 0;
            padding: 2rem;
        }
        .avatar {
            width: 100px;
            height: 100px;
            background: rgba(255, 255, 255, 0.2);
            border-radius: 50%;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 2.5rem;
            margin: 0 auto;
        }
        .info-card {
            border-left: 4px solid #667eea;
            background-color: #f8f9fa;
        }
    </style>
</head>
<body>
<div class="header-container">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h3 fw-bold">👁️ Student Details</h1>
                <p class="mb-0">Complete information for ${student.name} ${student.surname}</p>
            </div>
            <div>
                <a href="${pageContext.request.contextPath}/students" class="btn btn-outline-light btn-sm">
                    ← Back to List
                </a>
                <a href="${pageContext.request.contextPath}/auth/logout" class="btn btn-outline-light btn-sm ms-2">
                    🚪 Logout
                </a>
            </div>
        </div>
    </div>
</div>

<div class="container">
    <div class="row">
        <div class="col-12">
            <div class="card detail-card">
                <!-- Profile Header -->
                <div class="profile-header">
                    <div class="row align-items-center">
                        <div class="col-md-2 text-center">
                            <div class="avatar">
                                <c:choose>
                                    <c:when test="${student.gender == 'Male'}">👨</c:when>
                                    <c:when test="${student.gender == 'Female'}">👩</c:when>
                                    <c:otherwise>👤</c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-md-8">
                            <h2 class="mb-1">${student.name} ${student.surname}</h2>
                            <p class="mb-1">
                                <strong>Student ID:</strong> ${student.id} |
                                <strong>Birth Certificate:</strong> ${student.birthCertificateNo}
                            </p>
                            <div class="mt-2">
                                <c:if test="${not empty student.currentClass}">
                                    <span class="badge bg-light text-dark me-2">🏫 ${student.currentClass}</span>
                                </c:if>
                                <c:choose>
                                    <c:when test="${student.status == 'Active'}">
                                        <span class="badge bg-success">✅ Active</span>
                                    </c:when>
                                    <c:when test="${student.status == 'Inactive'}">
                                        <span class="badge bg-secondary">⏸️ Inactive</span>
                                    </c:when>
                                    <c:when test="${student.status == 'Transferred'}">
                                        <span class="badge bg-info">🔄 Transferred</span>
                                    </c:when>
                                    <c:when test="${student.status == 'Graduated'}">
                                        <span class="badge bg-warning">🎓 Graduated</span>
                                    </c:when>
                                    <c:otherwise>
                                        <span class="badge bg-primary">${student.status}</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                        <div class="col-md-2 text-end">
                            <c:set var="now" value="<%= java.time.LocalDate.now() %>" />
                            <c:if test="${not empty student.dob}">
                                <c:set var="age" value="${now.year - student.dob.year}" />
                                <c:if test="${now.monthValue < student.dob.monthValue || (now.monthValue == student.dob.monthValue && now.dayOfMonth < student.dob.dayOfMonth)}">
                                    <c:set var="age" value="${age - 1}" />
                                </c:if>
                                <h3 class="mb-0">${age}</h3>
                                <small>Years Old</small>
                            </c:if>
                        </div>
                    </div>
                </div>

                <div class="card-body p-4">
                    <div class="row">
                        <!-- Personal Information -->
                        <div class="col-md-6">
                            <h4 class="section-title">📋 Personal Information</h4>
                            <div class="card info-card mb-4">
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">First Name:</div>
                                        <div class="col-sm-8 info-value">${student.name}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Surname:</div>
                                        <div class="col-sm-8 info-value">${student.surname}</div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Birth Certificate:</div>
                                        <div class="col-sm-8 info-value">
                                            <span class="badge bg-secondary">${student.birthCertificateNo}</span>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Gender:</div>
                                        <div class="col-sm-8 info-value">
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
                                                    <span class="text-muted">Not specified</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Date of Birth:</div>
                                        <div class="col-sm-8 info-value">
                                            <c:if test="${not empty student.dob}">
                                                ${student.dob}
                                                <c:if test="${not empty student.dob}">
                                                    <br>
                                                    <small class="text-muted">
                                                        (Age: ${age} years)
                                                    </small>
                                                </c:if>
                                            </c:if>
                                            <c:if test="${empty student.dob}">
                                                <span class="text-muted">Not specified</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Status:</div>
                                        <div class="col-sm-8 info-value">
                                            <c:choose>
                                                <c:when test="${student.status == 'Active'}">
                                                    <span class="badge bg-success">✅ Active</span>
                                                </c:when>
                                                <c:when test="${student.status == 'Inactive'}">
                                                    <span class="badge bg-secondary">⏸️ Inactive</span>
                                                </c:when>
                                                <c:when test="${student.status == 'Transferred'}">
                                                    <span class="badge bg-info">🔄 Transferred</span>
                                                </c:when>
                                                <c:when test="${student.status == 'Graduated'}">
                                                    <span class="badge bg-warning">🎓 Graduated</span>
                                                </c:when>
                                                <c:otherwise>
                                                    <span class="badge bg-primary">${student.status}</span>
                                                </c:otherwise>
                                            </c:choose>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Contact & Academic Information -->
                        <div class="col-md-6">
                            <h4 class="section-title">🏠 Contact & Academic Information</h4>
                            <div class="card info-card mb-4">
                                <div class="card-body">
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Address:</div>
                                        <div class="col-sm-8 info-value">
                                            <c:if test="${not empty student.address}">
                                                ${student.address}
                                            </c:if>
                                            <c:if test="${empty student.address}">
                                                <span class="text-muted">Not specified</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Current Class:</div>
                                        <div class="col-sm-8 info-value">
                                            <c:if test="${not empty student.currentClass}">
                                                <span class="badge bg-info text-white">🏫 ${student.currentClass}</span>
                                            </c:if>
                                            <c:if test="${empty student.currentClass}">
                                                <span class="text-muted">Not assigned</span>
                                            </c:if>
                                        </div>
                                    </div>
                                    <div class="row mb-3">
                                        <div class="col-sm-4 info-label">Student ID:</div>
                                        <div class="col-sm-8 info-value">
                                            <code>#${student.id}</code>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Guardian Information Section -->
                    <div class="row mt-4">
                        <div class="col-12">
                            <h4 class="section-title">👨‍👩‍👧‍👦 Guardian Information</h4>
                            <div class="card info-card">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="col-md-6">
                                            <div class="row mb-3">
                                                <div class="col-sm-4 info-label">Guardian Name:</div>
                                                <div class="col-sm-8 info-value">
                                                    <c:if test="${not empty student.guardianName}">
                                                        <strong>${student.guardianName}</strong>
                                                    </c:if>
                                                    <c:if test="${empty student.guardianName}">
                                                        <span class="text-warning">Not specified</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                            <div class="row mb-3">
                                                <div class="col-sm-4 info-label">Contact Number:</div>
                                                <div class="col-sm-8 info-value">
                                                    <c:if test="${not empty student.guardianContact}">
                                                        📞 ${student.guardianContact}
                                                    </c:if>
                                                    <c:if test="${empty student.guardianContact}">
                                                        <span class="text-muted">Not specified</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                        <div class="col-md-6">
                                            <div class="row mb-3">
                                                <div class="col-sm-4 info-label">Email Address:</div>
                                                <div class="col-sm-8 info-value">
                                                    <c:if test="${not empty student.guardianEmail}">
                                                        📧 ${student.guardianEmail}
                                                    </c:if>
                                                    <c:if test="${empty student.guardianEmail}">
                                                        <span class="text-muted">Not specified</span>
                                                    </c:if>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information -->
                    <c:if test="${not empty student.notes}">
                        <div class="row mt-4">
                            <div class="col-12">
                                <h4 class="section-title">📝 Additional Notes</h4>
                                <div class="card info-card">
                                    <div class="card-body">
                                        <p class="info-value">${student.notes}</p>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </c:if>

                    <!-- Action Buttons -->
                    <div class="row mt-4">
                        <div class="col-12 text-center action-buttons">
                            <a href="${pageContext.request.contextPath}/students/edit?id=${student.id}"
                               class="btn btn-warning btn-lg">
                                ✏️ Edit Student
                            </a>
                            <a href="${pageContext.request.contextPath}/students"
                               class="btn btn-secondary btn-lg">
                                ← Back to List
                            </a>
                            <a href="${pageContext.request.contextPath}/students/delete?id=${student.id}"
                               class="btn btn-danger btn-lg"
                               onclick="return confirm('Are you sure you want to delete ${student.name} ${student.surname}? This action cannot be undone.')">
                                🗑️ Delete Student
                            </a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Print functionality
    function printStudentDetails() {
        window.print();
    }

    // Enhanced delete confirmation
    document.addEventListener('DOMContentLoaded', function() {
        const deleteBtn = document.querySelector('a[href*="/students/delete"]');
        if (deleteBtn) {
            deleteBtn.addEventListener('click', function(e) {
                const confirmed = confirm('Are you sure you want to delete this student? This action cannot be undone and all associated data will be lost.');
                if (!confirmed) {
                    e.preventDefault();
                }
            });
        }
    });
</script>
</body>
</html>