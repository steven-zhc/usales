package com.hczhang.usales.om

class Order {

    static final int ORDER_STATUS_INQUIRE = 1

    Integer status = 1
    Float deliverFee = 0.0f
    Float total
    Float profit
    Date dateCreated
    String note

    static hasMany = [lines : OrderLine]

    static constraints = {
        note nullable: true
        status defaultValue: 1
    }

    static mapping = {
        table '`order`'

        deliverFee defaultValue: 0
        status column: '`status`'
    }

    @Override
    public String toString() {
        return """\
Order{
    status=$status,
    deliverFee=$deliverFee,
    total=$total,
    profit=$profit,
    dateCreated=$dateCreated,
    note='$note'
}"""
    }
}
