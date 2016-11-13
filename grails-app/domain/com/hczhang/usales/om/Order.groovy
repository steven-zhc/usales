package com.hczhang.usales.om

class Order {

    OrderStatus status
    Float deliverFee
    Float total
    Float profit
    Date dateCreated
    String note

//  Customer customer

    static hasMany = [lines : OrderLine]

    static constraints = {
        note nullable: true
    }

    static mapping = {
        table '`order`'
        status column: '`status`', defaultValue: OrderStatus.INQUIRE
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

enum OrderStatus {
    CANCEL(-1), INQUIRE(0), PROCESS(1), SHIPPING(2), COMPLETE(3)

    private final int s

    OrderStatus(int s) {
        this.s = s
    }

    int getStatus() {
        return s
    }
}