package com.hczhang.usales.prodm

class ProductController {

    static scaffold = Product

    def index() { }

    def search() {
        return ["categories": Category.list()]
    }

    def searchResult(String name, Integer cid) {

    }
}
