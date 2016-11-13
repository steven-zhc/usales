package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product
import groovy.json.JsonOutput

class OrderController {

    def index() {}

    def add() {

        def list = []
        for (p in Product.list()) {
            list.add([id: p.id, name: p.name, price: p.listPrice])
        }

        def json = JsonOutput.toJson([list: list])

        ["products": json]
    }

    def save(OrderCommand cmd) {

        if (cmd.hasErrors()) {
            flash.message = "Error add Order."
            redirect action: "add"
            return
        }
        def order = new Order(cmd.properties)
        order.dateCreated = Date.parse("MM/dd/yyyy", cmd.date)

        println order

        for (l in cmd.items) {
            def line = new OrderLine(l.properties)
            line.product = Product.get(l.pid)

            order.addToLines(line)

            println line
        }

        order.save(failOnError: true)
        redirect action: "show", id: order.id


    }

    def show() {
//        Order o = Order.findById(params.id)
//        if (o) {
//            ["order", o]
//        } else {
//            response.senError(404)
//        }
    }

}

class LineCommand {

    String pid
    Integer quantity
    Float discountPrice
    Float sellPrice
    Float tax
    Float shippingFee
    Float lineTotal
    Float lineProfit

    static constraints = {
        importFrom OrderLine
    }

}

class OrderCommand {

    String date
    Float deliverFee
    String note
    Float total
    Float profit

    List<LineCommand> items

    static constraints = {
        importFrom Order
    }

}
