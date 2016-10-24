package com.hczhang.usales.um

class User {

    String username
    String password

    Customer profile

    static constraints = {
        profile nullable: true
    }
}
