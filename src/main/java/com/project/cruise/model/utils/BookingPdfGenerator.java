package com.project.cruise.model.utils;

import com.google.zxing.WriterException;
import com.itextpdf.text.*;
import com.itextpdf.text.pdf.*;
import com.project.cruise.model.data.BookingDetails;
import com.project.cruise.model.utils.QRCodeGenerator;

import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.util.Date;

public class BookingPdfGenerator {

    public static byte[] generatePdf(BookingDetails details) throws DocumentException, IOException, WriterException {
        // Create document instance
        Document document = new Document();

        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        PdfWriter.getInstance(document, baos);
        document.open();

        // Add cruise logo
        String logoPath = System.getProperty("user.dir") + "/Web Pages/images/cruise.jpg";
        try {
            Image logo = Image.getInstance(logoPath);
            logo.setAlignment(Element.ALIGN_CENTER);
            logo.scaleToFit(200, 100); // Resize logo
            document.add(logo);
        } catch (IOException e) {
            System.err.println("Cruise logo not found at: " + logoPath);
        }

        // Add header
        Font headerFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 18, BaseColor.PINK);
        Paragraph header = new Paragraph("Booking Receipt", headerFont);
        header.setAlignment(Element.ALIGN_CENTER);
        header.setSpacingBefore(20);
        header.setSpacingAfter(20);
        document.add(header);

        // Add booking details table
        PdfPTable table = new PdfPTable(2);
        table.setWidthPercentage(100);
        table.setSpacingBefore(10);
        table.setSpacingAfter(10);

        addTableCell(table, "Booking Reference", details.getBookingReference());
        addTableCell(table, "Passenger Name", details.getPassengerName());
        addTableCell(table, "Passenger Email", details.getPassengerEmail());
        addTableCell(table, "Cruise Name", details.getCruiseName());
        addTableCell(table, "Cruise Route", details.getCruiseRoute());
        addTableCell(table, "Departure Date", details.getDepartureDate());
        addTableCell(table, "Duration (Days)", String.valueOf(details.getDurationDays()));
        addTableCell(table, "Price", "$" + String.format("%.2f", details.getCruisePrice()));

        document.add(table);

        // Add QR code
        byte[] qrCodeBytes = QRCodeGenerator.generateQRCode(details.getBoardingPassQr());
        Image qrCodeImage = Image.getInstance(qrCodeBytes);
        qrCodeImage.setAlignment(Element.ALIGN_CENTER);
        qrCodeImage.scaleAbsolute(150, 150);
        document.add(qrCodeImage);

        // Add footer
        Font footerFont = FontFactory.getFont(FontFactory.HELVETICA_OBLIQUE, 10, BaseColor.GRAY);
        Paragraph footer = new Paragraph("Thank you for choosing our cruise services!", footerFont);
        footer.setAlignment(Element.ALIGN_CENTER);
        footer.setSpacingBefore(20);
        document.add(footer);

        // Add date of issue
        java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("MMMM d, yyyy");
        String currentDate = dateFormat.format(new Date());
        Paragraph dateIssued = new Paragraph("Date Issued: " + currentDate, footerFont);
        dateIssued.setAlignment(Element.ALIGN_RIGHT);
        document.add(dateIssued);

        // Add disclaimer
        Font disclaimerFont = FontFactory.getFont(FontFactory.HELVETICA, 8, BaseColor.DARK_GRAY);
        Paragraph disclaimer = new Paragraph("This receipt is subject to the terms and conditions of our cruise service. Please retain for your records.", disclaimerFont);
        disclaimer.setAlignment(Element.ALIGN_CENTER);
        disclaimer.setSpacingBefore(10);
        document.add(disclaimer);

        document.close();

        return baos.toByteArray();
    }

    private static void addTableCell(PdfPTable table, String key, String value) {
        Font keyFont = FontFactory.getFont(FontFactory.HELVETICA_BOLD, 12, BaseColor.BLACK);
        Font valueFont = FontFactory.getFont(FontFactory.HELVETICA, 12, BaseColor.BLACK);

        PdfPCell cellKey = new PdfPCell(new Phrase(key, keyFont));
        cellKey.setBackgroundColor(BaseColor.LIGHT_GRAY);
        cellKey.setPadding(5);

        PdfPCell cellValue = new PdfPCell(new Phrase(value, valueFont));
        cellValue.setPadding(5);

        table.addCell(cellKey);
        table.addCell(cellValue);
    }
}
