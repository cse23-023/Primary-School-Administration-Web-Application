package com.example.primaryschoolwebapp.Model;

import java.time.LocalDateTime;
import java.util.Objects;

public class Grade {

    private int id;
    private int studentId;
    private int subjectId;
    private int classId;
    private String term;
    private double marks;
    private LocalDateTime recordedAt;

    // Default constructor
    public Grade() {
        this.recordedAt = LocalDateTime.now(); // default to now
    }

    // Constructor with all fields except ID
    public Grade(int studentId, int subjectId, int classId, String term, double marks, LocalDateTime recordedAt) {
        this.studentId = studentId;
        this.subjectId = subjectId;
        this.classId = classId;
        this.term = term;
        this.marks = marks;
        this.recordedAt = recordedAt != null ? recordedAt : LocalDateTime.now();
    }

    // Full constructor with ID
    public Grade(int id, int studentId, int subjectId, int classId, String term, double marks, LocalDateTime recordedAt) {
        this(studentId, subjectId, classId, term, marks, recordedAt);
        this.id = id;
    }

    // Getters and Setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getStudentId() { return studentId; }
    public void setStudentId(int studentId) { this.studentId = studentId; }

    public int getSubjectId() { return subjectId; }
    public void setSubjectId(int subjectId) { this.subjectId = subjectId; }

    public int getClassId() { return classId; }
    public void setClassId(int classId) { this.classId = classId; }

    public String getTerm() { return term; }
    public void setTerm(String term) { this.term = term; }

    public double getMarks() { return marks; }
    public void setMarks(double marks) { this.marks = marks; }

    public LocalDateTime getRecordedAt() { return recordedAt; }
    public void setRecordedAt(LocalDateTime recordedAt) {
        this.recordedAt = recordedAt != null ? recordedAt : LocalDateTime.now();
    }

    // toString
    @Override
    public String toString() {
        return "Grade{" +
                "id=" + id +
                ", studentId=" + studentId +
                ", subjectId=" + subjectId +
                ", classId=" + classId +
                ", term='" + term + '\'' +
                ", marks=" + marks +
                ", recordedAt=" + recordedAt +
                '}';
    }

    // equals and hashCode (based on id)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (!(o instanceof Grade)) return false;
        Grade grade = (Grade) o;
        return id == grade.id;
    }

    @Override
    public int hashCode() {
        return Objects.hash(id);
    }

    public String getSubject() {
        return "";
    }

    public void setSubject(String subject) {
    }
}
