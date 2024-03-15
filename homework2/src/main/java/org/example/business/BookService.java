package org.example.business;

import org.example.entities.Book;
import org.example.entities.Borrower;
import org.example.entities.Employee;

public interface BookService {
    void borrowBook(Book book, Borrower borrower, Employee employee);

    void returnBook(Book book, Borrower borrower, Employee employee);

}
