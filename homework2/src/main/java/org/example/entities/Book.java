package org.example.entities;

import java.time.LocalDate;
import java.util.Date;

public class Book {
    private int id;
    private String name;
    private String author;
    private String pageNo;
    private LocalDate borrowDate;
    private LocalDate returnDate;
    private boolean isAvailable;

    public Book() {
    }

    public Book(int id, String name, String author, String pageNo, LocalDate borrowDate, LocalDate returnDate, boolean isAvailable) {
        this.id = id;
        this.name = name;
        this.author = author;
        this.pageNo = pageNo;
        this.borrowDate = borrowDate;
        this.returnDate = returnDate;
        this.isAvailable = isAvailable;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPageNo() {
        return pageNo;
    }

    public void setPageNo(String pageNo) {
        this.pageNo = pageNo;
    }

    public LocalDate getBorrowDate() {
        return borrowDate;
    }

    public void setBorrowDate(LocalDate borrowDate) {
        this.borrowDate = borrowDate;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    public LocalDate getReturnDate() {
        return returnDate;
    }

    public void setReturnDate(LocalDate returnDate) {
        this.returnDate = returnDate;
    }

}
