package com.hczhang.usales.om

import com.hczhang.usales.um.Customer

class Order {

    Integer status
    Date dateCreated
    Float tax
    Float shippingFee
    Float total

    Customer customer

    static hasMany = [lines : OrderLine]

    static constraints = {
    }
}
