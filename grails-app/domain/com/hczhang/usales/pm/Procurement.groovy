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


    @Override
    public String toString() {
        return """\
Procurement{
    product=$product,
    quantity=$quantity,
    price=$price,
    tax=$tax,
    shippingFee=$shippingFee,
    total=$total,
    status=$status,
    dateCreated=$dateCreated,
    note='$note'
}"""
    }
}
