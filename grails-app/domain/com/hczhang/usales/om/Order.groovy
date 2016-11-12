package com.hczhang.usales.om

class Order {

    Integer status = 0
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
        status column: '`status`'
    }
}
