package com.hczhang.usales.om

class Order {

    static final int ORDER_STATUS_INQUIRE = 1

    Integer status = 1

    Float total
    Float profit
    Date dateCreated
    String note
    Float payment

    Float deliverFee
    Date shippingDate
    String trackingNo

    static hasMany = [lines : OrderLine]

    static constraints = {
        note size: 1..255
        status defaultValue: 1
        payment defaultValue: 0.0
    }

    static mapping = {
        table '`order`'

        status column: '`status`'
    }

    @Override
    public String toString() {
        return """\
Order{
    status=$status,
    total=$total,
    profit=$profit,
    dateCreated=$dateCreated,
    note='$note',
    payment=$payment,
    deliverFee=$deliverFee,
    shippingDate=$shippingDate,
    trackingNo='$trackingNo'
}"""
    }
}
