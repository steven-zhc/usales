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

    Product product

    static belongsTo = [order : Order]

    static constraints = {
        product nullable: false
        quantity size: 1..1000
        tax nullable: false, validator: {val, OrderLine obj -> val <= obj.sellPrice}
    }
}
