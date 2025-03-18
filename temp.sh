#!/bin/bash

# Define output file
OUTPUT_FILE="blood_bank_er_diagram.png"

# Create the ER diagram using Graphviz
cat <<EOF | dot -Tpng -o $OUTPUT_FILE
digraph ERDiagram {
    rankdir=LR;
    node [shape=rectangle, style=filled, fillcolor=lightblue];

    User [label="User\n(User_ID, Name, Email, Phone, Address, User_Type, Password)"];
    Doctor [label="Doctor\n(Doctor_ID, Hospital_Name, License_Number, Designation)"];
    NormalPerson [label="Normal Person\n(Person_ID, Blood_Type, Age, Last_Donation_Date)"];
    Guest [label="Guest\n(Guest_ID, Temporary_Token)"];
    BloodBank [label="Blood Bank\n(Bank_ID, Name, Location, Contact_Number, Hospital_Affiliation)"];
    BloodStock [label="Blood Stock\n(Stock_ID, Blood_Bank_ID, Blood_Type, Quantity, Last_Updated)"];
    Donation [label="Donation\n(Donation_ID, Donor_ID, Bank_ID, Blood_Type, Quantity, Donation_Date)"];
    Request [label="Request\n(Request_ID, Requester_ID, Bank_ID, Blood_Type, Quantity, Status, Request_Date)"];
    Order [label="Order\n(Order_ID, Doctor_ID, Bank_ID, Blood_Type, Quantity, Status, Order_Date, Delivery_Date)"];

    # Relationships
    User -> Doctor [label="Specializes As"];
    User -> NormalPerson [label="Specializes As"];
    User -> Guest [label="Specializes As"];
    NormalPerson -> Donation [label="Donates"];
    BloodBank -> BloodStock [label="Maintains"];
    Doctor -> Order [label="Places"];
    Order -> BloodBank [label="Ordered From"];
    Request -> BloodBank [label="Requested From"];
    User -> Request [label="Requests"];
    Donation -> BloodBank [label="Donated To"];
}
EOF

echo "ER Diagram generated: $OUTPUT_FILE"
