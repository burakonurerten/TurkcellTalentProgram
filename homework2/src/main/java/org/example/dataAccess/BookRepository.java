package org.example.dataAccess;

import org.example.entities.Book;

public interface BookRepository {
    void addToDb(Book book);
}
