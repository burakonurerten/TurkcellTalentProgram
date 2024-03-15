package org.example.logging;

public class MailLogger extends BaseLogger{
    @Override
    public void log(String message) {
        System.out.println("Logged to mail " + message);
    }
}
