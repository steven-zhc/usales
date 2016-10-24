package com.hczhang.usales.pm

import com.hczhang.usales.prodm.Product

class Procurement {

    Product product
    Integer quantity
    Float price
    Float tax
    Float shippingFee
    Float total
    Integer status
    Date dateCreated
    String note

    static constraints = {
        note nullable: true
    }
}
