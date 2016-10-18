package com.hczhang.usales.prodm

class Product {

    String id
    String name
    String description
    String picPath
    Float listPrice

    Category category

    static constraints = {
        picPath nullable: true

    }
}
