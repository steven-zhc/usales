package com.hczhang.usales.um

class Address {

    String address1
    String address2
    String city
    String state
    String zipCode
    String country

    static constraints = {
        address2 nullable: true
    }
}
