package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product

class OrderLine {

    static final float TAX_RATE = 0.0875

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
        quantity nullable: false, size: 1..1000
        discountPrice nullable: false
        sellPrice nullable: false
        tax nullable: false, validator: {val, OrderLine obj -> val <= obj.sellPrice}
        lineTotal nullable: false
        lineProfit nullable: false
        product nullable: false
        note size: 1..255
    }

    static mapping = {
        shippingFee defaultValue: 0.0
    }

    Integer getRate() {
        return (100 * (1 - discountPrice / sellPrice)).round()
    }

    void settleAccount() {
        tax = (sellPrice * TAX_RATE).round(2)
        lineTotal = (quantity * sellPrice * (1 + TAX_RATE) + shippingFee).round(2)
        lineProfit = (quantity * (sellPrice - discountPrice) * (1 + TAX_RATE) + shippingFee).round(2)
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
