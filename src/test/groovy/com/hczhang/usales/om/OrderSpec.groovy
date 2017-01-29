package com.hczhang.usales.om

import com.hczhang.usales.prodm.Product
import grails.test.mixin.TestFor
import spock.lang.Specification

/**
 * See the API for {@link grails.test.mixin.domain.DomainClassUnitTestMixin} for usage instructions
 */
@TestFor(Order)
class OrderSpec extends Specification {

    def setup() {
    }

    def cleanup() {
    }

    /*
    void "Add Order, Order Line, Order Body"() {
        given: "A new Order"
        def prod = new Product(name: "GNC")

        def order = new Order(total: 100, profit: 10, note: "unit test")
        def line = new OrderLine(
                product: prod,
                quantity: 1,
                lineTotal: 100,
                lineProfit: 10,
                purchase: new LineBody(price: 90, tax: 0, shipping: 0, discount: 0, total: 90),
                sell: new LineBody(price: 100, tax: 0, shipping: 0, discount: 0, total: 100)
        )
        order.addToLines(line)

        when: "Save order cascade"
        order.save(failOnError: true)

        then: "The order and related sub-object should be saved"
        1 == order.lines.size()

    }

    void "Remove an Order Line from Order"() {
        given: "A Order"

        def order = new Order(total: 100, profit: 10, note: "unit test")

        OrderLine line = new OrderLine(
                product: new Product(name: "GNC"),
                quantity: 1,
                lineTotal: 100,
                lineProfit: 10,
                purchase: new LineBody(price: 90, tax: 0, shipping: 0, discount: 0, total: 90),
                sell: new LineBody(price: 100, tax: 0, shipping: 0, discount: 0, total: 100)
        )
        order.addToLines(line)

        line = new OrderLine(
                product: new Product(name: "Burberry"),
                quantity: 1,
                lineTotal: 100,
                lineProfit: 10,
                purchase: new LineBody(price: 90, tax: 0, shipping: 0, discount: 0, total: 90),
                sell: new LineBody(price: 100, tax: 0, shipping: 0, discount: 0, total: 100)
        )
        order.addToLines(line)

        order.settle()

        order.save(failOnError: true)

        when: "Delete one Line from Order"
        order.removeFromLines(line)

        then: "The order should still have one Order Line"
        1 == order.lines.size()
    }
    */
}
