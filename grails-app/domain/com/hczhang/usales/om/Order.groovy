package com.hczhang.usales.om

import com.hczhang.usales.um.Customer

class Order {

    Integer status
    Float tax
    Float shippingFee
    Float total
    Date dateCreated
    String note

    Customer customer

    static hasMany = [lines : OrderLine]

    static constraints = {
        note nullable: true
    }
}
