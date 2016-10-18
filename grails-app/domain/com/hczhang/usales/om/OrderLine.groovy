package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product

class OrderLine {

    String id
    Float price
    Integer quantity
    Float lineTotal

    Product product

    static belongsTo = [order : Order]

    static constraints = {
    }
}
