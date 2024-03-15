package org.example.entities;

public class Employee extends User{
    public Employee() {
    }

    public Employee(int id, String name, String email, String phoneNumber) {
        super(id, name, email, phoneNumber);
    }
}
