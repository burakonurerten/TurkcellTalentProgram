package org.example.entities;

public class Borrower extends User{
    public Borrower() {
    }

    public Borrower(int id, String name, String email, String phoneNumber) {
        super(id, name, email, phoneNumber);
    }
}
