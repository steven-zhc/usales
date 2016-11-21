package com.hczhang.usales

import com.hczhang.usales.om.Order

/**
 * Created by steven on 20/11/2016.
 */
class UsalesController {
    def index(Integer status) {

        def r = Order.createCriteria().get {
            gt "status", 2
            projections {
                count "id"
                sum "total"
                sum "profit"
                sum "payment"
            }
        }

        def statistics = new Statistics(count: r[0], total: r[1], profit: r[2], payment: r[3])

        def list = null
        if (status) {
            list = Order.findAllByStatus(status)
        } else {
            list = Order.list()
        }

        ["statistics": statistics, "list": list]
    }
}

class Statistics {
    Integer count
    Float total
    Float profit
    Float payment

    void setTotal(Float total) {
        this.total = total.round(2)
    }

    void setProfit(Float profit) {
        this.profit = profit.round(2)
    }

    void setPayment(Float payment) {
        this.payment = payment.round(2)
    }
}