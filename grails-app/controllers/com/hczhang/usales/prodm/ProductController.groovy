package com.hczhang.usales.prodm

class ProductController {

    static defaultAction = "list"

    def list(String name, Integer cid) {

        if (name || cid) {
            def list = Product.where {
                if (name) {
                    name =~ "%${name}%"
                }
                if (cid) {
                    category.id == cid
                }
            }.list()
            ["name": name, "cid": cid, "categories": Category.list(), "products": list]
        } else {
            ["products": Product.list(), "categories": Category.list()]
        }

    }

    def add() {
        ["categories": Category.list()]
    }

    def save(ProductCommand cmd) {

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
            ["product": p, "categories": Category.list()]
        } else {
            ["message": "Not Found."]
        }
    }

    def update(ProductCommand cmd) {

        Product p = Product.findById(cmd.pid)
        p.properties = cmd.properties;

        if (p.save(flush: true)) {
            flash.message = "Updated Product successful."
        } else {
            flash.message = "Has some exceptions."
        }

        redirect action: "show", id: p.id
    }
}

class SearchProductCommand {
    String name
    Integer cid
}

class ProductCommand {
    Long pid
    String name
    String description
    // TODO: add upload pic later
    //String picPath
    Float listPrice
    Integer cid
    String url

    static constraints = {
        cid nullable: false
        name nullable: false
    }
}
