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
        } else {
            def order = new Order(cmd.properties)

            for ( l in cmd.lines ) {
                def line = new OrderLine(l.properties)
                line.product = Product.get(l.pid)

                order.addToLines(line)
            }

            order.save()
        }

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

}

class OrderCommand {

    Date dateCreated
    Float deliverFee
    String note
    Float total
    Float profit

    List<LineCommand> lines

}
