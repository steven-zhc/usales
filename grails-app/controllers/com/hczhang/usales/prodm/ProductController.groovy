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
            flash.message = "Error add Product"

        } else {

            def p = new Product(cmd.properties)
            p.category = Category.get(cmd.cid)

            if (p.validate() && p.save()) {
                flash.message = "successful"

                redirect action: "search"
            } else {
                ["cmd": cmd]
            }
        }
    }
}

class SearchProductCommand {
    String name
    Integer cid

    static constraints = {
        name (nullable: true)
        cid (nullable: true)
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
