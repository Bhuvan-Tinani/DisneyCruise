package com.project.cruise.model.utils;

import com.project.cruise.model.data.BookingDetails;
import java.util.Objects;
import java.util.Properties;
import javax.activation.DataHandler;
import javax.mail.AuthenticationFailedException;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import javax.mail.util.ByteArrayDataSource;

public class EmailSender {

    // Gmail SMTP Configuration
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587"; // Use 465 for SSL, 587 for TLS
    private static final String PDF_FILENAME = "BookingReceipt.pdf";

    public void sendEmail(BookingDetails details, byte[] pdfBytes, String gmailUsername, String gmailAppPassword)
            throws MessagingException {

        Objects.requireNonNull(details, "Booking details cannot be null");
        Objects.requireNonNull(pdfBytes, "PDF content cannot be null");
        Objects.requireNonNull(gmailUsername, "SMTP username (your Gmail address) cannot be null");
        Objects.requireNonNull(gmailAppPassword, "SMTP password (App Password) cannot be null");

        // Mail server properties for Gmail
        Properties props = new Properties();
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");

        try {
            Session session = Session.getInstance(props, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(gmailUsername, gmailAppPassword);
                }
            });

            MimeMessage message = new MimeMessage(session);
            message.setFrom(new InternetAddress(gmailUsername));
            message.setRecipient(Message.RecipientType.TO, new InternetAddress(details.getPassengerEmail()));
            message.setSubject("Booking Receipt for " + details.getCruiseName());

            MimeMultipart multipart = new MimeMultipart();

            MimeBodyPart textPart = new MimeBodyPart();
            textPart.setText(buildEmailBody(details));
            multipart.addBodyPart(textPart);

            MimeBodyPart pdfPart = new MimeBodyPart();
            ByteArrayDataSource pdfDataSource = new ByteArrayDataSource(pdfBytes, "application/pdf");
            pdfPart.setDataHandler(new DataHandler(pdfDataSource));
            pdfPart.setFileName(PDF_FILENAME);
            multipart.addBodyPart(pdfPart);

            message.setContent(multipart);
            Transport.send(message);

            System.out.println("Email sent successfully to " + details.getPassengerEmail());

        } catch (AddressException e) {
            throw new MessagingException("Invalid email address format: " + e.getMessage(), e);
        } catch (AuthenticationFailedException e) {
            throw new MessagingException(
                "Gmail SMTP authentication failed. Make sure:\n" +
                "1. You are using a Gmail App Password (not your Gmail login password).\n" +
                "2. Your Google account has 2-step verification enabled.\n" +
                "3. You entered the correct email and app password.", e);
        } catch (MessagingException e) {
            throw new MessagingException("Failed to send email: " + e.getMessage(), e);
        }
    }

    private String buildEmailBody(BookingDetails details) {
        String passengerName = Objects.requireNonNull(details.getPassengerName(), "Passenger name is required");
        String cruiseName = Objects.requireNonNull(details.getCruiseName(), "Cruise name is required");
        String departureDate = Objects.requireNonNull(details.getDepartureDate(), "Departure date is required");

        return String.format(
            "Dear %s,%n%n" +
            "Please find attached your booking receipt for %s.%n%n" +
            "Departure Date: %s%n%n" +
            "Thank you for choosing our cruise services.%n%n" +
            "Best regards,%n" +
            "Cruise Booking Team",
            passengerName,
            cruiseName,
            departureDate
        );
    }
}
