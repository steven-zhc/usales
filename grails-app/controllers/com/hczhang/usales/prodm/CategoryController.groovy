package com.hczhang.usales.prodm

class CategoryController {

    static scaffold = Category

    def index() { }

    def add() {
        ["categories": Category.list()]
    }
}
