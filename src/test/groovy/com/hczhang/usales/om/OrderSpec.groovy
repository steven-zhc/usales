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
}
