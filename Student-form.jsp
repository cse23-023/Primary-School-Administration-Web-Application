<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>
        <c:choose>
            <c:when test="${formAction == 'add'}">Add Student</c:when>
            <c:when test="${formAction == 'edit'}">Edit Student</c:when>
            <c:when test="${formAction == 'details'}">Student Details</c:when>
        </c:choose>
        - Student Management System
    </title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .header-container {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 1.5rem 0;
            margin-bottom: 2rem;
        }
        .form-container {
            max-width: 800px;
            margin: 0 auto;
        }
        .card {
            border: none;
            box-shadow: 0 0.5rem 1rem rgba(0, 0, 0, 0.15);
        }
        .form-label {
            font-weight: 600;
            color: #495057;
        }
        .readonly-field {
            background-color: #f8f9fa;
            cursor: not-allowed;
        }
        .required::after {
            content: " *";
            color: #dc3545;
        }
        .section-title {
            color: #495057;
            border-bottom: 2px solid #667eea;
            padding-bottom: 0.5rem;
            margin: 2rem 0 1rem 0;
            font-weight: 600;
        }
        .form-text {
            font-size: 0.875em;
            color: #6c757d;
        }
    </style>
</head>
<body>
<div class="header-container">
    <div class="container">
        <div class="d-flex justify-content-between align-items-center">
            <div>
                <h1 class="h3 fw-bold">
                    <c:choose>
                        <c:when test="${formAction == 'add'}">➕ Add New Student</c:when>
                        <c:when test="${formAction == 'edit'}">✏️ Edit Student</c:when>
                        <c:when test="${formAction == 'details'}">👁️ Student Details</c:when>
                    </c:choose>
                </h1>
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
    <div class="form-container">

        <!-- Error Messages -->
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ❌ ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <!-- Success Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ✅ ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert"></button>
            </div>
        </c:if>

        <div class="card">
            <div class="card-body p-4">
                <form method="post" action="${pageContext.request.contextPath}/students">
                    <input type="hidden" name="id" value="${student.id}" />
                    <input type="hidden" name="formAction" value="${formAction}" />

                    <!-- Basic Information Section -->
                    <h5 class="section-title">📋 Basic Information</h5>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">👤 First Name</label>
                                <input type="text"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="name"
                                       value="${student.name}"
                                       required
                                ${formAction == 'details' ? 'readonly' : ''}
                                       placeholder="Enter first name"
                                       maxlength="50"/>
                                <div class="form-text">Required field - Maximum 50 characters</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">👥 Surname</label>
                                <input type="text"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="surname"
                                       value="${student.surname}"
                                       required
                                ${formAction == 'details' ? 'readonly' : ''}
                                       placeholder="Enter surname"
                                       maxlength="50"/>
                                <div class="form-text">Required field - Maximum 50 characters</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">📄 Birth Certificate No</label>
                                <input type="text"
                                       class="form-control ${formAction == 'details' || formAction == 'edit' ? 'readonly-field' : ''}"
                                       name="birthCertificateNo"
                                       value="${student.birthCertificateNo}"
                                       required
                                ${formAction == 'details' || formAction == 'edit' ? 'readonly' : ''}
                                       placeholder="Enter birth certificate number"
                                       maxlength="9"
                                       pattern="[0-9]{9}"
                                       title="Must be exactly 9 digits"/>
                                <div class="form-text">
                                    <c:choose>
                                        <c:when test="${formAction == 'edit'}">
                                            Birth certificate number cannot be changed
                                        </c:when>
                                        <c:otherwise>
                                            Required field - Must be exactly 9 digits - Must be unique
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">⚧ Gender</label>
                                <select class="form-select ${formAction == 'details' ? 'readonly-field' : ''}"
                                        name="gender"
                                        required
                                ${formAction == 'details' ? 'disabled' : ''}>
                                    <option value="">-- Select Gender --</option>
                                    <option value="Male" ${student.gender == 'Male' ? 'selected' : ''}>Male</option>
                                    <option value="Female" ${student.gender == 'Female' ? 'selected' : ''}>Female</option>
                                    <option value="Other" ${student.gender == 'Other' ? 'selected' : ''}>Other</option>
                                </select>
                                <c:if test="${formAction == 'details'}">
                                    <input type="hidden" name="gender" value="${student.gender}"/>
                                </c:if>
                                <div class="form-text">Required field</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">🎂 Date of Birth</label>
                                <input type="date"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="dob"
                                       value="${student.dob}"
                                       required
                                ${formAction == 'details' ? 'readonly' : ''}/>
                                <div class="form-text">Required field</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">📊 Status</label>
                                <select class="form-select ${formAction == 'details' ? 'readonly-field' : ''}"
                                        name="status"
                                        required
                                ${formAction == 'details' ? 'disabled' : ''}>
                                    <option value="">-- Select Status --</option>
                                    <option value="Active" ${student.status == 'Active' || empty student.status ? 'selected' : ''}>Active</option>
                                    <option value="Inactive" ${student.status == 'Inactive' ? 'selected' : ''}>Inactive</option>
                                    <option value="Transferred" ${student.status == 'Transferred' ? 'selected' : ''}>Transferred</option>
                                    <option value="Graduated" ${student.status == 'Graduated' ? 'selected' : ''}>Graduated</option>
                                </select>
                                <c:if test="${formAction == 'details'}">
                                    <input type="hidden" name="status" value="${student.status}"/>
                                </c:if>
                                <div class="form-text">Required field</div>
                            </div>
                        </div>
                    </div>

                    <div class="mb-3">
                        <label class="form-label required">🏠 Address</label>
                        <textarea class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                  name="address"
                                  rows="3"
                                  required
                        ${formAction == 'details' ? 'readonly' : ''}
                                  placeholder="Enter student's address"
                                  maxlength="500">${student.address}</textarea>
                        <div class="form-text">Required field - Maximum 500 characters</div>
                    </div>

                    <!-- Guardian Information Section -->
                    <h5 class="section-title">👨‍👩‍👧‍👦 Guardian Information</h5>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">👤 Guardian Full Name</label>
                                <input type="text"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="guardianName"
                                       value="${student.guardianName}"
                                       required
                                ${formAction == 'details' ? 'readonly' : ''}
                                       placeholder="Enter guardian's full name"
                                       maxlength="100"/>
                                <div class="form-text">Required field - Maximum 100 characters</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">📞 Guardian Contact</label>
                                <input type="tel"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="guardianContact"
                                       value="${student.guardianContact}"
                                       required
                                ${formAction == 'details' ? 'readonly' : ''}
                                       placeholder="Enter guardian's phone number"
                                       maxlength="15"
                                       pattern="[0-9+\-\s()]{10,15}"
                                       title="Enter a valid phone number"/>
                                <div class="form-text">Required field - Maximum 15 characters</div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label">📧 Guardian Email</label>
                                <input type="email"
                                       class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                       name="guardianEmail"
                                       value="${student.guardianEmail}"
                                ${formAction == 'details' ? 'readonly' : ''}
                                       placeholder="Enter guardian's email address"
                                       maxlength="100"/>
                                <div class="form-text">Optional - Maximum 100 characters</div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="mb-3">
                                <label class="form-label required">🏫 Current Class</label>
                                <select class="form-select ${formAction == 'details' ? 'readonly-field' : ''}"
                                        name="currentClass"
                                        required
                                ${formAction == 'details' ? 'disabled' : ''}>
                                    <option value="">-- Select Class --</option>
                                    <option value="Grade 1" ${student.currentClass == 'Grade 1' ? 'selected' : ''}>Grade 1</option>
                                    <option value="Grade 2" ${student.currentClass == 'Grade 2' ? 'selected' : ''}>Grade 2</option>
                                    <option value="Grade 3" ${student.currentClass == 'Grade 3' ? 'selected' : ''}>Grade 3</option>
                                    <option value="Grade 4" ${student.currentClass == 'Grade 4' ? 'selected' : ''}>Grade 4</option>
                                    <option value="Grade 5" ${student.currentClass == 'Grade 5' ? 'selected' : ''}>Grade 5</option>
                                    <option value="Grade 6" ${student.currentClass == 'Grade 6' ? 'selected' : ''}>Grade 6</option>
                                    <option value="Grade 7" ${student.currentClass == 'Grade 7' ? 'selected' : ''}>Grade 7</option>
                                    <option value="Kindergarten" ${student.currentClass == 'Kindergarten' ? 'selected' : ''}>Kindergarten</option>
                                    <option value="Nursery" ${student.currentClass == 'Nursery' ? 'selected' : ''}>Nursery</option>
                                </select>
                                <c:if test="${formAction == 'details'}">
                                    <input type="hidden" name="currentClass" value="${student.currentClass}"/>
                                </c:if>
                                <div class="form-text">Required field</div>
                            </div>
                        </div>
                    </div>

                    <!-- Additional Information Section -->
                    <h5 class="section-title">📝 Additional Information</h5>

                    <div class="mb-3">
                        <label class="form-label">📋 Notes</label>
                        <textarea class="form-control ${formAction == 'details' ? 'readonly-field' : ''}"
                                  name="notes"
                                  rows="3"
                        ${formAction == 'details' ? 'readonly' : ''}
                                  placeholder="Enter any additional notes about the student"
                                  maxlength="1000">${student.notes}</textarea>
                        <div class="form-text">Optional - Maximum 1000 characters</div>
                    </div>

                    <div class="d-flex justify-content-between mt-4">
                        <div>
                            <a href="${pageContext.request.contextPath}/students" class="btn btn-secondary">
                                ← Back to List
                            </a>
                        </div>

                        <c:if test="${formAction != 'details'}">
                            <div>
                                <button type="reset" class="btn btn-outline-secondary me-2">
                                    🔄 Reset
                                </button>
                                <button type="submit" class="btn btn-primary">
                                    <c:choose>
                                        <c:when test="${formAction == 'add'}">
                                            💾 Add Student
                                        </c:when>
                                        <c:when test="${formAction == 'edit'}">
                                            💾 Update Student
                                        </c:when>
                                    </c:choose>
                                </button>
                            </div>
                        </c:if>

                        <c:if test="${formAction == 'details'}">
                            <div>
                                <a href="${pageContext.request.contextPath}/students/edit?id=${student.id}"
                                   class="btn btn-warning">
                                    ✏️ Edit Student
                                </a>
                            </div>
                        </c:if>
                    </div>
                </form>
            </div>
        </div>

        <!-- Debug Information (remove in production) -->
        <c:if test="${formAction == 'add' || formAction == 'edit'}">
            <div class="mt-4 card">
                <div class="card-body">
                    <h6>Form Validation Notes:</h6>
                    <small class="text-muted">
                        • All fields marked with * are required<br>
                        • Birth Certificate must be exactly 9 digits<br>
                        • Phone number must be valid (10-15 characters)<br>
                        • Form will validate all requirements before submission
                    </small>
                </div>
            </div>
        </c:if>
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

    // Enhanced form validation
    document.addEventListener('DOMContentLoaded', function() {
        const form = document.querySelector('form');
        if (form) {
            form.addEventListener('submit', function(e) {
                const name = form.querySelector('input[name="name"]').value.trim();
                const surname = form.querySelector('input[name="surname"]').value.trim();
                const birthCertificateNo = form.querySelector('input[name="birthCertificateNo"]').value.trim();
                const gender = form.querySelector('select[name="gender"]').value;
                const dob = form.querySelector('input[name="dob"]').value;
                const address = form.querySelector('textarea[name="address"]').value.trim();
                const guardianName = form.querySelector('input[name="guardianName"]').value.trim();
                const guardianContact = form.querySelector('input[name="guardianContact"]').value.trim();
                const currentClass = form.querySelector('select[name="currentClass"]').value;
                const status = form.querySelector('select[name="status"]').value;

                let missingFields = [];

                if (!name) missingFields.push('First Name');
                if (!surname) missingFields.push('Surname');
                if (!birthCertificateNo) missingFields.push('Birth Certificate No');
                if (!gender) missingFields.push('Gender');
                if (!dob) missingFields.push('Date of Birth');
                if (!address) missingFields.push('Address');
                if (!guardianName) missingFields.push('Guardian Name');
                if (!guardianContact) missingFields.push('Guardian Contact');
                if (!currentClass) missingFields.push('Current Class');
                if (!status) missingFields.push('Status');

                if (missingFields.length > 0) {
                    e.preventDefault();
                    alert('Please fill in all required fields:\n• ' + missingFields.join('\n• '));
                    return false;
                }

                // Validate birth certificate number format (exactly 9 digits)
                if (!/^\d{9}$/.test(birthCertificateNo)) {
                    e.preventDefault();
                    alert('Birth Certificate Number must be exactly 9 digits.');
                    return false;
                }

                console.log('Form submitted with:', {
                    name: name,
                    surname: surname,
                    birthCertificateNo: birthCertificateNo,
                    gender: gender,
                    dob: dob,
                    address: address,
                    guardianName: guardianName,
                    guardianContact: guardianContact,
                    currentClass: currentClass,
                    status: status,
                    formAction: form.querySelector('input[name="formAction"]').value
                });
            });
        }

        // Real-time validation for birth certificate number
        const birthCertInput = document.querySelector('input[name="birthCertificateNo"]');
        if (birthCertInput) {
            birthCertInput.addEventListener('input', function() {
                const value = this.value.replace(/\D/g, '');
                this.value = value;

                if (value.length > 9) {
                    this.value = value.slice(0, 9);
                }
            });
        }

        // Real-time validation for guardian contact
        const guardianContactInput = document.querySelector('input[name="guardianContact"]');
        if (guardianContactInput) {
            guardianContactInput.addEventListener('input', function() {
                const value = this.value.replace(/[^\d+\-\s()]/g, '');
                this.value = value;

                if (value.length > 15) {
                    this.value = value.slice(0, 15);
                }
            });
        }
    });
</script>
</body>
</html>