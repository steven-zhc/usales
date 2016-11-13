package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product

class OrderLine {

    Integer quantity
    Float discountPrice
    Float sellPrice
    Float tax
    Float shippingFee
    Float lineTotal
    Float lineProfit
    Date dateCreated
    String note

    Product product

    static belongsTo = [order : Order]

    static constraints = {
        product nullable: false
        quantity size: 1..1000
        tax nullable: false, validator: {val, OrderLine obj -> val <= obj.sellPrice}
        note nullable: true
    }

    @Override
    public String toString() {
        return """\
OrderLine{
    quantity=$quantity,
    discountPrice=$discountPrice,
    sellPrice=$sellPrice,
    tax=$tax,
    shippingFee=$shippingFee,
    lineTotal=$lineTotal,
    lineProfit=$lineProfit,
    dateCreated=$dateCreated,
    note='$note',
    product=$product
}"""
    }
}
