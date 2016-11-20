package com.hczhang.usales.prodm

class ProductController {

//    static scaffold = Product

    def index() {}

    def list(String name, Integer cid) {

        if (name || cid) {
            def list = Product.where {
                if (name) {
                    name =~ "%${cmd.name}%"
                }
                if (cid) {
                    category.id == cmd.cid
                }
            }.list()
            ["cmd": cmd, "categories": Category.list(), "products": list]
        } else {
            ["name": name, "cid": cid, "categories": Category.list()]
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
            flash.message = "Added a new Product successful."
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
