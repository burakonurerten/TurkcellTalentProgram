package org.example.business;


import java.time.LocalDate;
import java.time.temporal.ChronoUnit;
import org.example.dataAccess.BookRepository;
import org.example.entities.*;
import org.example.logging.BaseLogger;

public class BookServiceImpl implements BookService{
    BaseLogger logger;
    BookRepository repository;

    public BookServiceImpl(BaseLogger logger, BookRepository repository) {
        this.logger = logger;
        this.repository = repository;
    }

    @Override
    public void borrowBook(Book book, Borrower borrower, Employee employee) {
        System.out.println("\nBorrow Book Section:\n");
        logger.logFirst("Logged before borrowing book.");
        repository.addToDb(book);
    }

    @Override
    public void returnBook(Book book, Borrower borrower, Employee employee) {
        System.out.println("\nReturning Book Section:\n");
        logger.logFirst("Logged before returning book");
        long daysBetween = ChronoUnit.DAYS.between(book.getReturnDate(), LocalDate.now());

        if (daysBetween > 5) {
            logger.logFirst("You return the book " + daysBetween + " days late");
        }
        repository.addToDb(book);
    }
}
