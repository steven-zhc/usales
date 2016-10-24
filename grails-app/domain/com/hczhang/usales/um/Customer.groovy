package com.hczhang.usales.um

class Customer {

    String firstName
    String lastName
    String phone
    String email

    Address i18nAddress
    Address enAddress

    static constraints = {
        i18nAddress nullable: false
        enAddress nullable: false
        phone nullable: false
        email nullable: false
    }
}
