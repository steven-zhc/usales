package com.hczhang.usales.im

import com.hczhang.usales.om.Order
import com.hczhang.usales.um.Customer

class Invoice {

    String id
    Date dateCreated
    Customer shippingTo
    Order order

    static constraints = {
    }
}
