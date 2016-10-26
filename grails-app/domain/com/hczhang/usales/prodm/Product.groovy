package com.hczhang.usales.prodm

class Product {

    String name
    String description
    String picPath
    Float listPrice = 0

    Category category

    static constraints = {
        picPath nullable: true
        description nullable: true
    }

    String getDisplayString() {
        return name
    }
}
