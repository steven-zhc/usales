package com.hczhang.usales.sm

import com.hczhang.usales.prodm.Product

class Stock {

    Product product
    Integer quantity
    String location

    static constraints = {
        location nullable: true
    }
}
