package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product

class OrderLine {

    static final float TAX_RATE = 0.0875

    Product product

    String model

    Date dateCreated

    Integer quantity
    Float shippingFee
    Float lineTotal
    Float lineProfit
    String note

    LineDetails purchase
    LineDetails sell

    static embedded = ['purchase', 'sell']

    static belongsTo = [order : Order]

    static constraints = {
        model size: 2..50
        quantity nullable: false, size: 1..1000
        lineTotal nullable: false
        lineProfit nullable: false
        product nullable: false
        note size: 1..255
    }

    static mapping = {
        shippingFee defaultValue: 0.0
    }

    void settleAccount() {

        sell.settle()
        purchase.settle()

        lineTotal = sell.total
        lineProfit = sell.total - purchase.total

    }

    @Override
    public String toString() {
        return """\
OrderLine{
    product=$product, 
    dateCreated=$dateCreated, 
    quantity=$quantity, 
    lineTotal=$lineTotal, 
    lineProfit=$lineProfit, 
    note='$note', 
    purchase=$purchase, 
    sell=$sell
}"""
    }
}

class LineDetails {
    Float price
    Float tax
    Float shipping
    Float discount
    Float total

    void settle() {
        total = price + tax + shipping + discount
    }

    @Override
    public String toString() {
        return """\
LineDetails{
    price=$price, 
    tax=$tax, 
    shipping=$shipping, 
    discount=$discount, 
    total=$total
}"""
    }
}