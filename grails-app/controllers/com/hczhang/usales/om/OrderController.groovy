package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product
import groovy.json.JsonOutput

class OrderController {

    def index() {}

    def String getProductsJSON() {
        def list = []
        for (p in Product.list()) {
            list.add([id: p.id, name: p.name, price: p.listPrice])
        }

        def json = JsonOutput.toJson([list: list])
    }

    def add() {

        ["products": getProductsJSON()]
    }

    def save(OrderCommand cmd) {

        if (cmd.hasErrors()) {
            render view: "add", model: ["cmd": cmd, "products": getProductsJSON()]
        }

        def order = new Order(cmd.properties)
        order.dateCreated = Date.parse("MM/dd/yyyy", cmd.date)

        for (l in cmd.items) {
            def line = new OrderLine(l.properties)
            line.product = Product.get(l.pid)

            order.addToLines(line)
        }

        if (order.save()) {
            flash.message = "Added a new Order."
            redirect action: "show", id: order.id
        } else {
            render view: "add", model: ["model": order, "products": getProductsJSON()]
        }

    }

    def show() {
        Order o = Order.findById(params.id)
        if (o) {
            ["order": o, "products": getProductsJSON()]
        } else {
            ["message": "Not Found."]
        }
    }

    def update() {

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
    String note

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
