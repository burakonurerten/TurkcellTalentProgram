package org.example.logging;

public class DatabaseLogger extends BaseLogger{
    @Override
    public void log(String message) {
        System.out.println("Logged to DB " + message);
    }
}
