package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product

class OrderLine {

    static final float TAX_RATE = 0.0875

    Product product

    Date dateCreated

    Integer quantity
    Float lineTotal
    Float lineProfit

    String model
    String note

    LineBody purchase
    LineBody sell

//    static embedded = ['purchase', 'sell']
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
    }

    void settle() {

        sell.settle(quantity)
        purchase.settle(quantity)

        lineTotal = sell.total
        lineProfit = (sell.total - purchase.total).round(2)

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

class LineBody {
    Float price
    Float tax
    Float shipping
    Float discount
    Float total

    static belongsTo = [header : OrderLine]

    void settle(int quantity) {
        total = (price * quantity).round(2) + tax + shipping + discount
    }

    @Override
    public String toString() {
        return """\
LineBody{
    price=$price, 
    tax=$tax, 
    shipping=$shipping, 
    discount=$discount, 
    total=$total
}"""
    }
}