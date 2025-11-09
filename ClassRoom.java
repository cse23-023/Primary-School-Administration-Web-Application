package com.example.primaryschoolwebapp.Model;


public class ClassRoom {
    private int id;
    private String name;
    private String description;
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    public String getDescription() { return description; }
    public void setDescription(String description) { this.description = description; }

    public void setClassName(String className) {
    }

    public void setGradeLevel(String gradeLevel) {
    }

    public void setTeacherName(String teacherName) {
    }

    public String getClassName() {
        return "";
    }

    public String getGradeLevel() {
        return "";
    }

    public String getTeacherName() {
        return "";
    }
}
