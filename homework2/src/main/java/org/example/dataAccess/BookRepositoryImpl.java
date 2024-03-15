package org.example.dataAccess;

import org.example.entities.Book;

public class BookRepositoryImpl implements BookRepository {
    @Override
    public void addToDb(Book book) {
        System.out.println("Added to DB.");
    }
}
