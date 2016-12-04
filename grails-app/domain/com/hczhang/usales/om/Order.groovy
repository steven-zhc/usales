package com.hczhang.usales.om

class Order {

    static final int ORDER_STATUS_INQUIRE = 1

    Integer status = 1

    Float total
    Float profit
    Date dateCreated
    String note

    Float deliverFee
    Date deliverDate
    String trackingNo

    Float payment

    List lines
    static hasMany = [lines : OrderLine]

    static constraints = {
        note size: 1..255
        status defaultValue: 1
        payment defaultValue: 0.0
    }

    static mapping = {
        table '`order`'

        lines lazy: false
        status column: '`status`'
    }

    void settle() {
        this.lines.each { i -> i.settle() }
        this.total = this.lines.inject(0.0) { acc, line -> acc + line.lineTotal }
        this.profit = this.lines.inject(0.0) { acc, line -> acc + line.lineProfit }

        if (deliverFee) {
            this.total += this.deliverFee
        }
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
    deliverDate=$deliverDate,
    trackingNo='$trackingNo'
}"""
    }
}
