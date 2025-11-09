package com.example.primaryschoolwebapp.Model;

import java.time.LocalDate;

public class Student {
    private int id;
    private String name;
    private String surname;
    private String birthCertificateNo;
    private String gender;
    private LocalDate dob;
    private String address;
    private String guardianName;
    private String guardianContact;
    private String guardianEmail;
    private String currentClass;
    private String status;
    private String notes;

    // Constructors
    public Student() {}

    public Student(int id, String name, String surname, String birthCertificateNo,
                   String gender, LocalDate dob, String address, String guardianName,
                   String guardianContact, String guardianEmail, String currentClass,
                   String status, String notes) {
        this.id = id;
        this.name = name;
        this.surname = surname;
        this.birthCertificateNo = birthCertificateNo;
        this.gender = gender;
        this.dob = dob;
        this.address = address;
        this.guardianName = guardianName;
        this.guardianContact = guardianContact;
        this.guardianEmail = guardianEmail;
        this.currentClass = currentClass;
        this.status = status;
        this.notes = notes;
    }

    // Getters and setters for all fields
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getName() { return name; }
    public void setName(String name) { this.name = name; }

    public String getSurname() { return surname; }
    public void setSurname(String surname) { this.surname = surname; }

    public String getBirthCertificateNo() { return birthCertificateNo; }
    public void setBirthCertificateNo(String birthCertificateNo) { this.birthCertificateNo = birthCertificateNo; }

    public String getGender() { return gender; }
    public void setGender(String gender) { this.gender = gender; }

    public LocalDate getDob() { return dob; }
    public void setDob(LocalDate dob) { this.dob = dob; }

    public String getAddress() { return address; }
    public void setAddress(String address) { this.address = address; }

    public String getGuardianName() { return guardianName; }
    public void setGuardianName(String guardianName) { this.guardianName = guardianName; }

    public String getGuardianContact() { return guardianContact; }
    public void setGuardianContact(String guardianContact) { this.guardianContact = guardianContact; }

    public String getGuardianEmail() { return guardianEmail; }
    public void setGuardianEmail(String guardianEmail) { this.guardianEmail = guardianEmail; }

    public String getCurrentClass() { return currentClass; }
    public void setCurrentClass(String currentClass) { this.currentClass = currentClass; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public String getNotes() { return notes; }
    public void setNotes(String notes) { this.notes = notes; }

    // Helper method
    public String getFullName() {
        return name + " " + surname;
    }
}