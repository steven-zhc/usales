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

    def update(OrderCommand cmd) {
        if (cmd.hasErrors()) {
            flash.message = "Update Order Failed."
            redirect action: "show", id: cmd.id
            return
        }

        Order order = Order.get(cmd.id)
        order.properties = cmd.properties

        def exists = cmd.items.inject ([:]) {acc, item -> acc << [(item.id) : item] }

        order.lines.inject([]) {acc, item ->
            if (!exists.containsKey(item.id)) {
                acc << item
            }
        }.each { item ->
            order.removeFromLines(item)
        }

        order.lines.each { item ->
            item.properties = exists[item.id].properties
        }

        cmd.newItems.each {item ->
            OrderLine line = new OrderLine(item.properties)
            line.product = Product.get(item.pid)
            order.addToLines(line)
        }

        if (order.save(flush: true)) {
            redirect action: "show", id: cmd.id
            return
        }

        flash.message = "Update Error."
        redirect action: "show", id: cmd.id
    }

    def show() {
        Order o = Order.findById(params.id)
        if (o) {
            ["order": o, "products": getProductsJSON()]
        } else {
            ["message": "Not Found."]
        }
    }

}

class LineCommand {

    Long id
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
        importFrom OrderLine, exclude: ["id"]
        id nullable: true
    }

}

class OrderCommand {

    Long id
    String date
    Float deliverFee
    String note
    Float total
    Float profit

    List<LineCommand> items
    List<LineCommand> newItems

    static constraints = {
        importFrom Order, exclude: ["id"]
        id nullable: true
        date nullable: true
    }

}
