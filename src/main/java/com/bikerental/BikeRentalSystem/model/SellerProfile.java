package com.bikerental.BikeRentalSystem.model;

 //Represents a seller's profile entry.
 //File format (sellers.txt): userId|location|description|approved
 //approved is stored as 'Y' or 'N'.

public class SellerProfile {

    private String  userId;
    private String  location;
    private String  description;
    private boolean approved;

    public SellerProfile() {}

    public SellerProfile(String userId, String location,
                         String description, boolean approved) {
        this.userId      = userId;
        this.location    = location;
        this.description = description;
        this.approved    = approved;
    }

    public String getUserId()                   { return userId; }
    public void   setUserId(String userId)      { this.userId = userId; }

    public String getLocation()                 { return location; }
    public void   setLocation(String location)  { this.location = location; }

    public String getDescription()                      { return description; }
    public void   setDescription(String description)    { this.description = description; }

    public boolean isApproved()                 { return approved; }
    public void    setApproved(boolean approved){ this.approved = approved; }


      //Returns the pipe-delimited line written to sellers.txt.
      //1716000000001|Colombo Fort|I rent quality mountain bikes|Y

    public String toFileString() {
        return String.join("|",
                userId,
                location,
                description,
                approved ? "Y" : "N");
    }
}