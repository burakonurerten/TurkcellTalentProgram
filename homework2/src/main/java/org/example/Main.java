package org.example;


import org.example.business.BookService;
import org.example.business.BookServiceImpl;
import org.example.dataAccess.BookRepositoryImpl;
import org.example.entities.Book;
import org.example.entities.Borrower;
import org.example.entities.Employee;
import org.example.logging.DatabaseLogger;
import org.example.logging.FileLogger;
import org.example.logging.Logger;
import org.example.logging.MailLogger;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public class Main {
    public static void main(String[] args) {
        System.out.println("Hello Turkcell!");

        LocalDate borrowDateForBook1 = LocalDate.of(2023, 9, 10);
        LocalDate returnDateForBook1 = LocalDate.of(2023, 10, 5);
        LocalDate borrowDateForBook2 = LocalDate.of(2023, 11, 10);
        LocalDate returnDateForBook2 = LocalDate.of(2023, 12, 5);
        LocalDate borrowDateForBook3 = LocalDate.of(2023, 1, 10);
        LocalDate returnDateForBook3 = LocalDate.of(2024, 3, 15);

        Borrower borrower1 = new Borrower(1, "Burak", "burakonurerten@gmail.com", "5413712874");
        Borrower borrower2 = new Borrower(2, "Halil", "halil@gmail.com", "313123123");
        Borrower borrower3 = new Borrower(3, "Ibrahim", "ibrahim@gmail.com", "123123123");

        Employee employee = new Employee(1, "Halit", "halit@gmail.com", "123123123");

        Book book1 = new Book(1,  "Oblomov", "Gonçarov", "830", borrowDateForBook1, returnDateForBook1, true);
        Book book2 = new Book(2,  "Dönüş", "Ayşe Kulin", "250", borrowDateForBook2, returnDateForBook2, true);
        Book book3 = new Book(3, "Yer Demri Gök Bakır", "Yaşar Kemal", "250", borrowDateForBook3, returnDateForBook3, true);


        BookService bookService1 = new BookServiceImpl(new FileLogger(), new BookRepositoryImpl());
        bookService1.borrowBook(book1, borrower1, employee);
        bookService1.returnBook(book1, borrower1, employee);

        BookService bookService2 = new BookServiceImpl(new MailLogger(), new BookRepositoryImpl());
        bookService2.borrowBook(book2, borrower2, employee);
        bookService2.returnBook(book2, borrower2, employee);

        BookService bookService3 = new BookServiceImpl(new DatabaseLogger(), new BookRepositoryImpl());
        bookService3.borrowBook(book3, borrower3, employee);
        bookService3.returnBook(book3, borrower3, employee);
    }
}