package com.hczhang.usales.prodm

class ProductController {

//    static scaffold = Product

    def index() {}

    def search(SearchProductCommand cmd) {

        if (cmd.hasErrors()) {
            ["cmd": cmd, "categories": Category.list()]
        } else {
            def list = Product.where {
                if (cmd?.name) {
                    name =~ "%${cmd.name}%"
                }
                if (cmd?.cid) {
                    category.id == cmd.cid
                }
            }.list()
            ["cmd": cmd, "categories": Category.list(), "products": list]
        }

    }

    def add() {
        ["categories": Category.list()]
    }

    def save(SaveProductCommand cmd) {

        if (cmd.hasErrors()) {
            render view: "add", model: ["cmd": cmd]
        }

        def p = new Product(cmd.properties)
        p.category = Category.get(cmd.cid)

        if (p.save()) {
            flash.message = "Added a new Product."
            redirect action: "show", id: p.id
        } else {
            render view: "add", model: ["model": p]
        }

    }

    def show() {
        Product p = Product.findById(params.id)
        if (p) {
            ["product": p]
        } else {
            ["message": "Not Found."]
        }
    }
}

class SearchProductCommand {
    String name
    Integer cid

    static constraints = {
        name(nullable: true)
        cid(nullable: true)
    }
}

class SaveProductCommand {
    String name
    String description
    // TODO: add upload pic later
    //String picPath
    Float listPrice
    Integer cid

    static constraints = {
        importFrom Product
    }

}
