package com.example.primaryschoolwebapp.Model;

import java.time.LocalDateTime;

public class User {
    private int id;
    private String username;
    private String fullname; // maps to 'name' in table
    private String email;
    private String role;

    // getters & setters
    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }

    public String getFullname() { return fullname; }
    public void setFullname(String fullname) { this.fullname = fullname; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getRole() { return role; }
    public void setRole(String role) { this.role = role; }

    public void setPhoneNumber(String phoneNumber) {
    }

    public void setAddress(String address) {
    }

    public void setPassword(String password) {
    }

    public void setName(String name) {
    }

    public void setCreatedAt(LocalDateTime createdAt) {
    }

    public String getPassword() {
        return "";
    }

    public String getName() {
        return "";
    }
}
